package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.request.Vehicle.VehicleRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Vehicle.VehicleResponse;
import com.smartparking.smartbrain.service.VehicleService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/vehicles")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class VehicleController {

	VehicleService vehicleService;

	@PostMapping
	public ApiResponse<VehicleResponse> createVehicle(@RequestBody @Valid VehicleRequest request) {
		return ApiResponse.<VehicleResponse>builder()
				.code(200)
				.message("Vehicle created successfully")
				.result(vehicleService.createVehicle(request))
				.build();
	}

	@GetMapping("/{UserID}")
	public ApiResponse<List<VehicleResponse>> getVehicleByUser(@PathVariable String UserID) {
		return ApiResponse.<List<VehicleResponse>>builder()
				.result(vehicleService.getVehicleByUserID(UserID))
				.code(200)
				.message("Vehicle fetched successfully")
				.build();
	}

	@PatchMapping("/{VehicleID}")
	public ApiResponse<Void> deleteVehicle(@PathVariable String VehicleID) {
		vehicleService.deletedByID(VehicleID);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("Vehicle deleted successfully")
				.build();
	}

}
