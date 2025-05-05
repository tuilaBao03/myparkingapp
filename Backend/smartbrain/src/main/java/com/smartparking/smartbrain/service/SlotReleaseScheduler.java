package com.smartparking.smartbrain.service;

import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

import com.smartparking.smartbrain.model.MonthlyTicket;
import com.smartparking.smartbrain.repository.MonthlyTicketRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.model.Invoice;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.repository.InvoiceRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;

import jakarta.transaction.Transactional;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(makeFinal = true, level = AccessLevel.PRIVATE)
public class SlotReleaseScheduler {

	ParkingSlotRepository slotRepository;
	InvoiceRepository invoiceRepository;
	MonthlyTicketRepository monthlyTicketRepository;
	ParkingSlotRepository parkingSlotRepository;


	// Chạy mỗi 5 phút
	@Transactional
	@Scheduled(fixedRate = 5 * 60 * 1000)
	public void releaseExpiredReservations() {
		Instant threshold = Instant.now().minus(3, ChronoUnit.HOURS);

		// Lấy các slot đang ở trạng thái RESERVED mà createdAt quá 3 hours
		List<ParkingSlot> expiredSlots = slotRepository.findExpiredReservedSlots(threshold);
		log.info("Found {} active slots", expiredSlots.size());
		for (ParkingSlot slot : expiredSlots) {
			try {
				Set<Invoice> invoiceSet = Optional.ofNullable(slot.getInvoices()).orElse(Set.of());
				List<Invoice> invoices = new ArrayList<>(invoiceSet);

				Invoice latestDepositInvoice = invoices.stream()
						.filter(invoice -> invoice.getStatus() == InvoiceStatus.DEPOSIT)
						.max(Comparator.comparing(Invoice::getCreatedAt))
						.orElse(null);
				if (latestDepositInvoice == null || latestDepositInvoice.getCreatedAt().isBefore(threshold)) {
					log.info("Releasing slot {} due to expired or missing deposit", slot.getSlotName());
					slotRepository.updateSlotStatus(slot.getSlotID(), SlotStatus.AVAILABLE);
					if (latestDepositInvoice != null) {
						invoiceRepository.updateInvoiceStatus(latestDepositInvoice.getInvoiceID(),
								InvoiceStatus.CANCELLED);
						log.info("Cancelled invoice {} for slot {}", latestDepositInvoice.getInvoiceID(),
								slot.getSlotName());

					}
				}
			} catch (Exception e) {
				log.error("Error processing slot {}: {}", slot.getSlotName(), e.getMessage(), e);
			}
		}
		log.info("Finished checking expired slots");

	}

	@Scheduled(cron = "0 0 0 1 * ?") // Chạy lúc 0h ngày đầu tháng
	public void updateSlotStatusAtStartOfMonth() {
		Instant now = Instant.now();
		ZoneId zone = ZoneId.of("Asia/Ho_Chi_Minh"); // hoặc "UTC", tùy hệ thống của em
		ZonedDateTime zonedNow = now.atZone(zone);
		int year = zonedNow.getYear();
		int month = zonedNow.getMonthValue();

		List<MonthlyTicket> tickets = monthlyTicketRepository
				.findAllByMonth(year, month); // Custom query đã convert sẵn từ Instant

		for (MonthlyTicket ticket : tickets) {
			ParkingSlot slot = ticket.getParkingSlot();

			if (slot.getSlotStatus() != SlotStatus.RESERVED) {
				slot.setSlotStatus(SlotStatus.RESERVED);
				parkingSlotRepository.save(slot);
			}
		}
	}


}
