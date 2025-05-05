package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smartparking.smartbrain.dto.request.Entry.EntryRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.service.EntryService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/entry")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EntryController {
	EntryService entryService;

	@PostMapping("enter")
	public ApiResponse<Void> enterParkingLot(@RequestBody @Valid EntryRequest request) {
		entryService.enterParkingLot(request);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("QR valid, open the barier. Welcome")
				.build();
	}

	@PostMapping("leave")
	public ApiResponse<Void> leaveParkingLot(@RequestBody @Valid EntryRequest request) {
		entryService.leaveParkingLot(request);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("QR valid, open the barier. See you again")
				.build();
	}

}
