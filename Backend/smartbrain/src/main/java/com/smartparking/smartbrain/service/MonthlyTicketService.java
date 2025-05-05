package com.smartparking.smartbrain.service;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.dto.request.MonthlyTicket.CreatedMonthlyTicketRequest;
import com.smartparking.smartbrain.dto.response.MonthlyTicket.MonthlyTicketResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.MonthlyTicketMapper;
import com.smartparking.smartbrain.model.MonthlyTicket;
import com.smartparking.smartbrain.repository.InvoiceRepository;
import com.smartparking.smartbrain.repository.MonthlyTicketRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class MonthlyTicketService {
	MonthlyTicketRepository monthlyTicketRepository;
	MonthlyTicketMapper monthlyTicketMapper;
	UserRepository userRepository;
	ParkingSlotRepository parkingSlotRepository;
	InvoiceRepository invoiceRepository;
	DateTimeConverter dateTimeConverter;

	public MonthlyTicketResponse createdMonthlyTicket(CreatedMonthlyTicketRequest request) {
		Instant startedAt = dateTimeConverter.fromStringToInstant(request.getStartedAt());

		// Chuyển sang ZonedDateTime để lấy được năm và tháng
		ZonedDateTime zonedStart = startedAt.atZone(ZoneId.of("Asia/Ho_Chi_Minh")); // hoặc "UTC" tùy setup của hệ thống

		int year = zonedStart.getYear();
		int month = zonedStart.getMonthValue();

		// Check slot đã bị đặt trong cùng tháng chưa
		List<MonthlyTicket> existingTickets = monthlyTicketRepository
				.findAllByParkingSlot_SlotIDAndMonth(request.getParkingSlotID(), year, month);

		if (!existingTickets.isEmpty()) {
			throw new AppException(ErrorCode.SLOT_ALREADY_RESERVED_THIS_MONTH);
		}
		var monthlyTicket= monthlyTicketMapper.toMonthlyTicket(request);
		var user = userRepository.findById(request.getUserID())
				.orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTS));
		monthlyTicket.setUser(user);

		var parkingSlot = parkingSlotRepository.findById(request.getParkingSlotID())
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_EXISTS));
		monthlyTicket.setParkingSlot(parkingSlot);

		var invoice = invoiceRepository.findById(request.getInvoiceID())
				.orElseThrow(() -> new AppException(ErrorCode.INVOICE_NOT_EXISTS));
		monthlyTicket.setInvoice(invoice);

		monthlyTicketRepository.save(monthlyTicket);
		return monthlyTicketMapper.toMonthlyTicketResponse(monthlyTicket);

	}
}
