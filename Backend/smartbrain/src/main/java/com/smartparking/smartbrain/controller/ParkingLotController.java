package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.PagedResponse;
import com.smartparking.smartbrain.dto.response.Discount.DiscountResponse;
import com.smartparking.smartbrain.dto.response.ParkingLot.ParkingLotResponse;
import com.smartparking.smartbrain.dto.response.ParkingSlot.ParkingSlotResponse;
import com.smartparking.smartbrain.service.DiscountService;
import com.smartparking.smartbrain.service.ParkingLotService;
import com.smartparking.smartbrain.service.ParkingSlotService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/parkinglots")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ParkingLotController {

	ParkingLotService parkingLotService;
	ParkingSlotService parkingSlotService;
	DiscountService discountService;

	@PostMapping
	public ApiResponse<ParkingLotResponse> createParkingLot(
			@Valid @RequestBody CreatedParkingLotRequest request) {
		return ApiResponse.<ParkingLotResponse>builder()
				.code(200)
				.message("Parking lot created successfully")
				.result(parkingLotService.createParkingLot(request))
				.build();
	}

	@GetMapping("/all")
	public ApiResponse<List<ParkingLotResponse>> getAllParkingLot() {
		return ApiResponse.<List<ParkingLotResponse>>builder()
				.code(200)
				.result(parkingLotService.getAllParkingLot())
				.message("Parking lots retrieved successfully")
				.build();
	}

	@GetMapping("/user/{userID}")
	public ApiResponse<List<ParkingLotResponse>> getAllParkingLotByUserId(
			@PathVariable("userID") String userID) {
		return ApiResponse.<List<ParkingLotResponse>>builder()
				.code(200)
				.result(parkingLotService.findByUserID(userID))
				.message("Parking lots retrieved successfully").build();
	}

	@GetMapping("/{ParkingLotID}")
	public ApiResponse<ParkingLotResponse> getParkingLotByID(@PathVariable String ParkingLotID) {
		return ApiResponse.<ParkingLotResponse>builder()
				.code(200)
				.result(parkingLotService.getParkingLotByID(ParkingLotID))
				.message("Parking lot retrieved successfully").build();
	}

	@GetMapping("/{ParkingLotID}/parkingslots")
	public ApiResponse<List<ParkingSlotResponse>> getAllParkingSlotByParkingLot(
			@PathVariable String ParkingLotID) {
		return ApiResponse.<List<ParkingSlotResponse>>builder()
				.code(200)
				.result(parkingSlotService.getAllParkingSlotByParkingLotID(ParkingLotID))
				.message("Parking slots retrieved successfully").build();
	}

	@GetMapping("/{ParkingLotID}/discounts")
	public ApiResponse<List<DiscountResponse>> getAllDiscountByParkingLot(
			@PathVariable String ParkingLotID) {
		return ApiResponse.<List<DiscountResponse>>builder()
				.code(200)
				.result(discountService.getAllDiscountByParkingLotID(ParkingLotID))
				.message("Discounts retrieved successfully").build();
	}

	@DeleteMapping("/{ParkingLotID}")
	public ApiResponse<Void> deleteParkingLot(@PathVariable String ParkingLotID) {
		parkingLotService.deleteParkingLot(ParkingLotID);
		return ApiResponse.<Void>builder()
				.code(200)
				.message(ParkingLotID + " has been deleted")
				.build();
	}

	@GetMapping("/search")
	public ApiResponse<PagedResponse<ParkingLotResponse>> findParkingLotByName(
			@RequestParam String name, @RequestParam(defaultValue = "0") int page,
			@RequestParam(defaultValue = "10") int size) {
		PagedResponse<ParkingLotResponse> response = parkingLotService.findByParkingLotName(name,
				PageRequest.of(page, size));

		return ApiResponse.<PagedResponse<ParkingLotResponse>>builder()
				.code(200)
				.result(response)
				.message("Parking lots retrieved successfully")
				.build();
	}

	@GetMapping("/nearby")
	public ApiResponse<List<ParkingLotResponse>> findNearestParkingLot(@RequestParam double lat,
			@RequestParam double lon) {
		return ApiResponse.<List<ParkingLotResponse>>builder()
				.code(200)
				.result(parkingLotService.findNearestParkingLot(lat, lon))
				.message("Parking lots retrieved successfully")
				.build();
	}

	@GetMapping()
	public ApiResponse<PagedResponse<ParkingLotResponse>> getParkingLots(
			@RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size) {
		PagedResponse<ParkingLotResponse> response = parkingLotService.getAllParkingLot(PageRequest.of(page, size));
		return ApiResponse.<PagedResponse<ParkingLotResponse>>builder()
				.code(200)
				.result(response)
				.message("Parking lots retrieved successfully")
				.build();
	}

}
