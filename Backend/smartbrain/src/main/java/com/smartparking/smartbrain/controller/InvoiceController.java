package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedDailyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedMonthlyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.PaymentDailyRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.PagedResponse;
import com.smartparking.smartbrain.dto.response.Invoice.InvoiceResponse;
import com.smartparking.smartbrain.service.InvoiceService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/invoices")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class InvoiceController {
	InvoiceService invoiceService;

	@PostMapping("/daily/deposit")
	public ApiResponse<InvoiceResponse> depositDailyInvoice(@Valid @RequestBody InvoiceCreatedDailyRequest request) {
		return ApiResponse.<InvoiceResponse>builder()
				.code(200)
				.result(invoiceService.depositDailyInvoice(request))
				.message("Invoice deposited successfully")
				.build();
	}

	@PostMapping("/daily/payment")
	public ApiResponse<InvoiceResponse> paymentDailyInvoice(@Valid @RequestBody PaymentDailyRequest request) {
		return ApiResponse.<InvoiceResponse>builder()
				.code(200)
				.result(invoiceService.paymentDailyInvoice(request))
				.message("Invoice payment successfully")
				.build();
	}

	@PostMapping("/monthly")
	public ApiResponse<InvoiceResponse> createMonthlyInvoice(@Valid @RequestBody InvoiceCreatedMonthlyRequest request) {
		return ApiResponse.<InvoiceResponse>builder()
				.code(200)
				.result(invoiceService.createMonthlyInvoice(request))
				.message("Invoice payment successfully")
				.build();
	}

	@GetMapping("/{InvoiceID}")
	public ApiResponse<InvoiceResponse> getInvoiceByID(@PathVariable String InvoiceID) {
		return ApiResponse.<InvoiceResponse>builder()
				.code(200)
				.result(invoiceService.getInvoiceByID(InvoiceID))
				.message("Invoice retrieved successfully")
				.build();
	}

	@GetMapping("/user/{UserID}")
	public ApiResponse<PagedResponse<InvoiceResponse>> getInvoiceByUserID(
			@PathVariable String UserID,
			@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "size", defaultValue = "10") int size) {
		return ApiResponse.<PagedResponse<InvoiceResponse>>builder()
				.code(200)
				.result(invoiceService.getInvoiceByUserID(UserID, PageRequest.of(page, size)))
				.message("Invoice retrieved successfully")
				.build();
	}

	@GetMapping("")
	public ApiResponse<PagedResponse<InvoiceResponse>> getAll(
			@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "size", defaultValue = "10") int size) {
		return ApiResponse.<PagedResponse<InvoiceResponse>>builder()
				.code(200)
				.result(invoiceService.getAllInvoice(PageRequest.of(page, size)))
				.message("Invoice retrieved successfully")
				.build();
	}

	@GetMapping("/active/{userID}")
	public ApiResponse<List<InvoiceResponse>> getAllActive(
			@RequestParam(value = "status", defaultValue = "active") String status,
			@PathVariable String userID) {
		return ApiResponse.<List<InvoiceResponse>>builder()
				.code(200)
				.result(invoiceService.getAllActiveInvoiceByUser(userID))
				.message("Invoice retrieved successfully")
				.build();
	}
	@GetMapping("/parkinglot/{parkingLotID}")
		public ApiResponse<List<InvoiceResponse>> getAllInvoiceByParkinglot(@PathVariable String parkingLotID) {
		return ApiResponse.<List<InvoiceResponse>>builder()
				.code(200)
				.message("Invoice fetch successfully")
				.result(invoiceService.getAllInvoiceByParkingLot(parkingLotID))
				.build();
		}

}
