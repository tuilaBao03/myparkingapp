package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.request.Permission.PermissionRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Permission.PermissionResponse;
import com.smartparking.smartbrain.service.PermissionService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/permissions")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PermissionController {
	PermissionService permissionService;

	@PostMapping
	public ApiResponse<PermissionResponse> createPermission(@RequestBody PermissionRequest permissionRequest) {
		return ApiResponse.<PermissionResponse>builder()
				.code(200)
				.result(permissionService.createPermission(permissionRequest))
				.message("Permission created successfully")
				.build();

	}

	@GetMapping
	public ApiResponse<List<PermissionResponse>> getAllPermission() {
		return ApiResponse.<List<PermissionResponse>>builder()
				.code(200)
				.result(permissionService.getAllPermissions())
				.message("Permissions retrieved successfully")
				.build();
	}

	@DeleteMapping("/{permissionName}")
	public ApiResponse<Void> deletePermission(@PathVariable String permissionName) {
		permissionService.deletePermission(permissionName);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("Permission deleted successfully")
				.build();
	}

}
