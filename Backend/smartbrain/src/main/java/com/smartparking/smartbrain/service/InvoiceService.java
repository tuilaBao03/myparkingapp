package com.smartparking.smartbrain.service;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

import com.smartparking.smartbrain.model.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedDailyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedMonthlyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.PaymentDailyRequest;
import com.smartparking.smartbrain.dto.request.MonthlyTicket.CreatedMonthlyTicketRequest;
import com.smartparking.smartbrain.dto.request.Wallet.DepositRequest;
import com.smartparking.smartbrain.dto.request.Wallet.PaymentRequest;
import com.smartparking.smartbrain.dto.response.PagedResponse;
import com.smartparking.smartbrain.dto.response.Invoice.InvoiceResponse;
import com.smartparking.smartbrain.encoder.AESEncryption;
import com.smartparking.smartbrain.enums.DiscountType;
import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.InvoiceMapper;
import com.smartparking.smartbrain.repository.*;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InvoiceService {
	@Value("${jwt.signerKey}")
	protected String SECRET_KEY;
	final InvoiceRepository invoiceRepository;
	final InvoiceMapper invoiceMapper;
	final UserRepository userRepository;
	final MonthlyTicketService monthlyTicketService;
	final WalletService walletService;
	final DateTimeConverter dateTimeConverter;
	final MonthlyTicketRepository monthlyTicketRepository;
	final ParkingSlotRepository parkingSlotRepository;
	final DiscountRepository discountRepository;
	final VehicleRepository vehicleRepository;
	final InvoiceQRRepository qrRepository;

	// Daily invoice deposit
	@Transactional(rollbackFor = AppException.class)
	public InvoiceResponse depositDailyInvoice(InvoiceCreatedDailyRequest request) {
		Invoice invoice = invoiceMapper.toDailyInvoice(request);
		ParkingSlot parkingSlot = parkingSlotRepository.findById(request.getParkingSlotID())
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));
		if (parkingSlot.getSlotStatus() != SlotStatus.AVAILABLE) {
			throw new AppException(ErrorCode.SLOT_NOT_AVAILABLE);
		}
		Vehicle vehicle = vehicleRepository.findById(request.getVehicleID())
				.orElseThrow(() -> new AppException(ErrorCode.VEHICLE_NOT_FOUND));
		if (!parkingSlot.getVehicleType().equals(vehicle.getVehicleType())) {
			throw new AppException(ErrorCode.SLOT_NOT_VALID_WITH_VEHICLE_TYPE);
		}
		// Lưu hóa đơn vào cơ sở dữ liệu
		invoice = invoiceRepository.save(invoice);
		var depositValue = invoice.getParkingSlot().getPricePerHour()
				.multiply(BigDecimal.valueOf(3));
		DepositRequest depositRequest = DepositRequest.builder()
				.walletID(request.getWalletID())
				.amount(depositValue)
				.description("Deposit daily invoice")
				.currency("USD")
				.build();
		try {
			walletService.deposit(depositRequest, invoice);
		} catch (AppException e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Error unknown when deposit invoice");
		}
		invoice.setTotalAmount(depositValue);
		invoice.setStatus(InvoiceStatus.DEPOSIT);
		invoice = invoiceRepository.save(invoice);
		// update slot status
		parkingSlot.setSlotStatus(SlotStatus.RESERVED);
		parkingSlotRepository.save(parkingSlot);
		InvoiceResponse invoiceResponse = invoiceMapper.toInvoiceResponse(invoice);
		invoiceResponse.setCreatedAt(Instant.now());
		try {
			String object =AESEncryption.encryptObject(invoice, SECRET_KEY);
			invoiceResponse.setObjectDecrypt(object);
			InvoiceQR invoiceQR = InvoiceQR.builder()
					.invoiceID(invoice.getInvoiceID())
					.objectToken(object)
					.isActive(true)
					.build();
			qrRepository.save(invoiceQR);
		} catch (Exception e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Error occur when encrypt invoice");
		}
		return invoiceResponse;
	}

	@Transactional(rollbackFor = AppException.class)
	// Daily invoice payment
	public InvoiceResponse paymentDailyInvoice(PaymentDailyRequest request) {
		var invoice = invoiceRepository.findByIdWithoutRelations(request.getInvoiceID())
				.orElseThrow(() -> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
		log.info("Here invoice");
		var parkingSlot = parkingSlotRepository.findParkingSlotWithoutRelations(request.getParkingSlotID())
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));
		log.info("Here parking slot");
		Discount discount = null;
		if (request.getDiscountID() != null) {
			discount = discountRepository.findDiscountWithoutRelations(request.getDiscountID())
					.orElseThrow(() -> new AppException(ErrorCode.DISCOUNT_NOT_EXISTS));
		}

		log.info("Here discount");
		var createdAt = invoice.getCreatedAt();
		if (invoice.getStatus() != InvoiceStatus.DEPOSIT) {
			throw new AppException(ErrorCode.INVOICE_NOT_DEPOSIT, invoice.getStatus().toString());
		}
		BigDecimal depositAmount = invoice.getTotalAmount();
		BigDecimal totalAmount = Optional
				.ofNullable(caculatorTotalAmount(parkingSlot, discount, createdAt.toString(), false))
				.orElse(BigDecimal.ZERO);
		invoice.setTotalAmount(totalAmount);
		// Nếu depositAmount lớn hơn totalAmount -> Trả lại phần dư
		if (depositAmount.compareTo(totalAmount) > 0) {
			BigDecimal refund = depositAmount.subtract(totalAmount);
			try {
				walletService.refundDeposit(refund, request.getWalletID());
			} catch (Exception e) {
				throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Error occur when refund deposit to user wallet");
			}

		}
		// Nếu totalAmount lớn hơn depositAmount -> Cập nhật totalAmount = totalAmount -
		// depositAmount
		else if (totalAmount.compareTo(depositAmount) > 0) {
			totalAmount = totalAmount.subtract(depositAmount);
		}

		PaymentRequest paymentRequest = PaymentRequest.builder()
				.walletID(request.getWalletID())
				.amount(totalAmount)
				.description("Payment daily invoice")
				.currency("USD")
				.build();
		walletService.makePayment(paymentRequest, invoice);
		invoice.setStatus(InvoiceStatus.PAID);
		invoice = invoiceRepository.save(invoice);
		log.info("complete save invoice");
		InvoiceResponse invoiceResponse = invoiceMapper.toInvoiceResponse(invoice);

		invoiceResponse.setCreatedAt(Instant.now());
		try {
			String object =AESEncryption.encryptObject(invoice, SECRET_KEY);
			invoiceResponse.setObjectDecrypt(object);
			InvoiceQR invoiceQR = InvoiceQR.builder()
					.invoiceID(invoice.getInvoiceID())
					.objectToken(object)
					.isActive(true)
					.build();
			qrRepository.save(invoiceQR);
		} catch (Exception e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Error occur when encrypt invoice");
		}
		return invoiceResponse;
	}

	// Monthly invoice
	@Transactional(rollbackFor = AppException.class)
	public InvoiceResponse createMonthlyInvoice(InvoiceCreatedMonthlyRequest request) {
		Invoice invoice = invoiceMapper.toMonthlyInvoice(request);
		ParkingSlot parkingSlot = parkingSlotRepository.findById(request.getParkingSlotID())
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));
		Vehicle vehicle = vehicleRepository.findById(request.getVehicleID())
				.orElseThrow(() -> new AppException(ErrorCode.VEHICLE_NOT_FOUND));
		if (!parkingSlot.getVehicleType().equals(vehicle.getVehicleType())) {
			throw new AppException(ErrorCode.SLOT_NOT_VALID_WITH_VEHICLE_TYPE);
		}
		invoice = invoiceRepository.save(invoice);
		// Make transaction
		// caculator total amount
		BigDecimal totalAmount = Optional
				.ofNullable(caculatorTotalAmount(invoice.getParkingSlot(), invoice.getDiscount(),
						request.getExpiredAt(), true))
				.orElse(BigDecimal.ZERO);

		PaymentRequest paymentRequest = PaymentRequest.builder()
				.walletID(request.getWalletID())
				.amount(totalAmount)
				.description("Payment monthly invoice")
				.currency("USD")
				.build();
		log.info("Total amount: {}", totalAmount);
		log.info("Payment request: {}", paymentRequest);
		walletService.makePayment(paymentRequest, invoice);
		invoice.setTotalAmount(totalAmount);
		invoice.setStatus(InvoiceStatus.PAID);
		invoice = invoiceRepository.save(invoice);

		// Tạo MonthlyTicket
		CreatedMonthlyTicketRequest request2 = CreatedMonthlyTicketRequest.builder()
				.parkingSlotID(invoice.getParkingSlot().getSlotID())
				.userID(invoice.getUser().getUserID())
				.invoiceID(invoice.getInvoiceID()) // Lúc này invoiceID đã có
				.expiredAt(request.getExpiredAt())
				.startedAt(request.getStartedAt())
				.build();
		var response = monthlyTicketService.createdMonthlyTicket(request2);
		invoiceRepository.save(invoice);
		invoice.setMonthlyTicket(monthlyTicketRepository.findById(response.getMonthlyTicketID())
				.orElseThrow(() -> new AppException(ErrorCode.MONTHLY_TICKET_NOT_EXISTS)));
		// update slot status
		ZonedDateTime zonedStart = dateTimeConverter
				.fromStringToInstant(request.getStartedAt())
				.atZone(ZoneId.of("Asia/Ho_Chi_Minh"));

		ZonedDateTime now = ZonedDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh"));
		if (zonedStart.getYear() == now.getYear() && zonedStart.getMonthValue() == now.getMonthValue()) {
			parkingSlot.setSlotStatus(SlotStatus.RESERVED);
			parkingSlotRepository.save(parkingSlot);
		}

		InvoiceResponse invoiceResponse = invoiceMapper.toInvoiceResponse(invoice);
		invoiceResponse.setCreatedAt(Instant.now());
		try {
			String object =AESEncryption.encryptObject(invoice, SECRET_KEY);
			invoiceResponse.setObjectDecrypt(object);
			InvoiceQR invoiceQR = InvoiceQR.builder()
					.objectToken(object)
					.invoiceID(invoice.getInvoiceID())
					.isActive(true)
					.build();
			qrRepository.save(invoiceQR);
		} catch (Exception e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Error occur when encrypt invoice");
		}
		return invoiceResponse;
	}

	public InvoiceResponse getInvoiceByID(String invoiceID) {
		var invoice = invoiceRepository.findById(invoiceID)
				.orElseThrow(() -> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
		return invoiceMapper.toInvoiceResponse(invoice);
	}

	public BigDecimal caculatorTotalAmount(ParkingSlot parkingSlot, Discount discount, String startTime,
			Boolean isMonthly) {
		Instant timeInstant = dateTimeConverter.fromStringToInstant(startTime);
		if (parkingSlot == null || timeInstant == null) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Parking slot or time is null");
		}
		BigDecimal totalAmount = BigDecimal.ZERO;

		if (isMonthly == true) {
			totalAmount = parkingSlot.getPricePerMonth();
		} else {
			// Tính số giờ từ thời điểm hiện tại đến ngày hết hạn
			long numberOfHours = Duration.between(timeInstant, Instant.now()).toHours();
			log.info("Number of hours: {}", numberOfHours);
			totalAmount = parkingSlot.getPricePerHour().multiply(BigDecimal.valueOf(numberOfHours));
		}

		if (discount != null) {
			BigDecimal maxDiscountValue = discount.getMaxValue();
			BigDecimal discountValue = BigDecimal.valueOf(discount.getDiscountValue());
			if (maxDiscountValue == null) {
				maxDiscountValue = discountValue; // Nếu không có giá trị tối đa, sử dụng giá trị giảm giá
			}

			if (discount.getDiscountType() == DiscountType.PERCENTAGE) {
				// Tính phần trăm giảm giá
				BigDecimal calculatedDiscount = totalAmount.multiply(discountValue).divide(BigDecimal.valueOf(100));

				if (calculatedDiscount.compareTo(maxDiscountValue) > 0) {
					totalAmount = totalAmount.subtract(maxDiscountValue);
				} else {
					totalAmount = totalAmount.subtract(calculatedDiscount);
				}
			} else if (discount.getDiscountType() == DiscountType.FIXED) {
				totalAmount = totalAmount.subtract(discountValue);
			}
		}

		return totalAmount.max(BigDecimal.ZERO); // Đảm bảo giá trị không âm
	}

	public PagedResponse<InvoiceResponse> getInvoiceByUserIDNotPayment(String userID, Pageable pageable) {
		if (!userRepository.existsById(userID)) {
			throw new AppException(ErrorCode.USER_NOT_EXISTS);
		}

		var invoicePage = invoiceRepository.findUnpaidInvoicesByUser(userID, pageable);

		List<InvoiceResponse> invoiceResponses = invoicePage.getContent().stream()
				.map(invoiceMapper::toInvoiceResponse)
				.toList();

		return new PagedResponse<>(
				invoiceResponses,
				invoicePage.getNumber(),
				invoicePage.getSize(),
				invoicePage.getTotalElements(),
				invoicePage.getTotalPages(),
				invoicePage.isLast());
	}

	public PagedResponse<InvoiceResponse> getAllInvoice(Pageable pageable) {
		var invoicePage = invoiceRepository.findAll(pageable);

		List<InvoiceResponse> invoiceResponses = invoicePage.getContent().stream()
				.map(invoiceMapper::toInvoiceResponse)
				.toList();

		return new PagedResponse<>(
				invoiceResponses,
				invoicePage.getNumber(),
				invoicePage.getSize(),
				invoicePage.getTotalElements(),
				invoicePage.getTotalPages(),
				invoicePage.isLast());
	}

	public PagedResponse<InvoiceResponse> getInvoiceByUserID(String userID, Pageable pageable) {
		if (!userRepository.existsById(userID)) {
			throw new AppException(ErrorCode.USER_NOT_EXISTS);
		}

		var invoicePage = invoiceRepository.findByUser_UserID(userID, pageable);

		List<InvoiceResponse> invoiceResponses = invoicePage.getContent().stream()
				.map(invoiceMapper::toInvoiceResponse)
				.toList();

		return new PagedResponse<>(
				invoiceResponses,
				invoicePage.getNumber(),
				invoicePage.getSize(),
				invoicePage.getTotalElements(),
				invoicePage.getTotalPages(),
				invoicePage.isLast());
	}

	public List<InvoiceResponse> getAllActiveInvoiceByUser(String userID) {
		var invoices = invoiceRepository.findAllActiveInvoiceByUser(userID);

		return invoices.stream().map(invoice -> {
			InvoiceResponse response = invoiceMapper.toInvoiceResponse(invoice);

			qrRepository.findByInvoiceIDAndIsActiveTrue(invoice.getInvoiceID())
					.map(InvoiceQR::getObjectToken)
					.ifPresent(response::setObjectDecrypt);

			return response;
		}).toList();
	}


	public List<InvoiceResponse> getAllInvoiceByParkingLot(String parkingLotID) {
		var invoices = invoiceRepository.findAllInvoiceByParkingLotId(parkingLotID);

		return invoices.stream().map(invoiceMapper::toInvoiceResponse).toList();
	}
}
