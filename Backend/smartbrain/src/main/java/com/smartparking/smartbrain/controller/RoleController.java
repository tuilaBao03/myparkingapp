package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.request.Role.RoleRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.Role.RoleResponse;
import com.smartparking.smartbrain.service.RoleService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/roles")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RoleController {
	RoleService RoleService;

	@PostMapping
	public ApiResponse<RoleResponse> createRole(@RequestBody RoleRequest RoleRequest) {
		return ApiResponse.<RoleResponse>builder()
				.code(200)
				.message("Role created successfully")
				.result(RoleService.createRole(RoleRequest))
				.build();

	}

	@GetMapping
	public ApiResponse<List<RoleResponse>> getAllRole() {
		return ApiResponse.<List<RoleResponse>>builder()
				.result(RoleService.getAllRoles())
				.code(200)
				.message("Roles retrieved successfully")
				.build();
	}

	@DeleteMapping("/{RoleName}")
	public ApiResponse<Void> deleteRole(@PathVariable String RoleName) {
		RoleService.deleteRole(RoleName);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("Role deleted successfully")
				.build();
	}

}
