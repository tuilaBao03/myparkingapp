package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.request.Discount.DiscountGlobalRequest;
import com.smartparking.smartbrain.dto.request.Discount.DiscountParkingLotRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Discount.DiscountResponse;
import com.smartparking.smartbrain.service.DiscountService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/discounts")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class DiscountController {
	DiscountService discountService;

	@PostMapping("/parkinglot")
	public ApiResponse<DiscountResponse> createParkingLotDiscount(
			@RequestBody @Valid DiscountParkingLotRequest request) {
		return ApiResponse.<DiscountResponse>builder()
				.code(200)
				.result(discountService.createParkingLotDiscount(request))
				.message("Discount created successfully")
				.build();
	}

	@PostMapping("/global")
	public ApiResponse<DiscountResponse> createGlobalDiscount(
			@RequestBody @Valid DiscountGlobalRequest request) {
		return ApiResponse.<DiscountResponse>builder()
				.code(200)
				.result(discountService.createGlobalDiscount(request))
				.message("Discount created successfully")
				.build();
	}

	@GetMapping("/global")
	public ApiResponse<List<DiscountResponse>> getGlobalDiscount() {
		return ApiResponse.<List<DiscountResponse>>builder()
				.code(200)
				.result(discountService.getAllGlobalDiscount())
				.message("Discount retrieved successfully")
				.build();
	}

	@GetMapping("/{discountID}")
	public ApiResponse<DiscountResponse> getDiscountByID(@PathVariable String discountID) {
		return ApiResponse.<DiscountResponse>builder()
				.code(200)
				.result(discountService.getDiscount(discountID))
				.message("Discount retrieved successfully")
				.build();
	}

	@DeleteMapping("/{discountID}")
	public ApiResponse<Void> deletedDiscountByID(@PathVariable String discountID) {
		return ApiResponse.<Void>builder()
				.code(200)
				.message(" Discount has been deleted successfully")
				.build();
	}

}
