package com.smartparking.smartbrain.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Entry.EntryRequest;
import com.smartparking.smartbrain.encoder.AESEncryption;
import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.Invoice;
import com.smartparking.smartbrain.repository.InvoiceRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EntryService {

	@Value("${jwt.signerKey}")
	protected String SECRET_KEY;
	final ParkingSlotService parkingSlotService;
	final InvoiceRepository invoiceRepository;

	// viết một hàm tạo chuỗi String sử dụng mã hóa từ hóa đơn Response
	// với hóa đơn theo ngày thì khi người dùng đặt cọc sẽ dùng hóa đơn đặt cọc để
	// vào và hóa đơn thanh toán để ra
	public void enterParkingLot(EntryRequest request) {
		try {
			Invoice invoiceDecrypt = AESEncryption.decryptObject(request.getObjectEncrypt(), SECRET_KEY, Invoice.class);
			InvoiceStatus status = invoiceDecrypt.getStatus();
			Invoice invoice = invoiceRepository.findById(invoiceDecrypt.getInvoiceID())
					.orElseThrow(() -> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
			if (invoice.getParkingSlot().getSlotStatus().equals(SlotStatus.OCCUPIED)) {
				throw new AppException(ErrorCode.YOUR_VEHICLE_HAS_ENTERED_PARKING_LOT);
			}
			if (status.equals(InvoiceStatus.DEPOSIT) || status.equals(InvoiceStatus.PAID)) {
				parkingSlotService.updateParkingSlotStatus(invoice.getParkingSlot().getSlotID(), SlotStatus.OCCUPIED);
			}
		} catch (Exception e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Has error occur when decrypt QR CODE");
		}
	}

	public void leaveParkingLot(EntryRequest request) {
		try {
			Invoice invoiceDecrypt = AESEncryption.decryptObject(request.getObjectEncrypt(), SECRET_KEY, Invoice.class);
			InvoiceStatus status = invoiceDecrypt.getStatus();
			Invoice invoice = invoiceRepository.findById(invoiceDecrypt.getInvoiceID())
					.orElseThrow(() -> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
			if (invoice.getParkingSlot().getSlotStatus().equals(SlotStatus.AVAILABLE)) {
				throw new AppException(ErrorCode.YOUR_VEHICLE_HAS_LEFT_PARKING_LOT);
			}
			if (status.equals(InvoiceStatus.PAID)) {
				if (invoice.getMonthlyTicket() != null) {
					parkingSlotService.updateParkingSlotStatus(invoice.getParkingSlot().getSlotID(),
							SlotStatus.RESERVED);
				} else {
					parkingSlotService.updateParkingSlotStatus(invoice.getParkingSlot().getSlotID(),
							SlotStatus.AVAILABLE);
				}
			}
		} catch (Exception e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Has error occur when decrypt QR CODE");
		}
	}

}
