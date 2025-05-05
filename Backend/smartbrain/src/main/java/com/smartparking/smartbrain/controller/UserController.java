package com.smartparking.smartbrain.controller;

import java.util.List;

import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.service.UserService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/myparkingapp/users")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserController {
	UserService userService;

	@PostMapping
	public ApiResponse<UserResponse> createRequestUser(@RequestBody @Valid UserRequest request) {
		return ApiResponse.<UserResponse>builder()
				.result(userService.createReqUser(request))
				.code(200)
				.message("User register successfully")
				.build();
	}

	@GetMapping
	ApiResponse<List<UserResponse>> getAllUser() {
		return ApiResponse.<List<UserResponse>>builder()
				.result(userService.getAllUser())
				.code(200)
				.message("user fetched sucessfully")
				.build();
	}

	@GetMapping("/profile")
	ApiResponse<UserResponse> getMe() {
		return ApiResponse.<UserResponse>builder()
				.code(200)
				.message("user fetched sucessfully")
				.result(userService.getMe())
				.build();
	}

	@GetMapping("/{id}")
	ApiResponse<UserResponse> getUserById(@PathVariable String id) {
		return ApiResponse.<UserResponse>builder()
				.code(200)
				.message("user fetched sucessfully")
				.result(userService.getUserById(id))
				.build();
	}

	@DeleteMapping("/{id}")
	ApiResponse<Void> deleteUser(@PathVariable String id) {
		userService.deleteUser(id);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("Deleted user successfully")
				.build();
	}

	@PutMapping("/{id}")
	ApiResponse<UserResponse> updateUser(@PathVariable String id, @RequestBody @Valid UpdatedUserRequest request) {
		return ApiResponse.<UserResponse>builder()
				.code(200)
				.message("User updated sucessfully")
				.result(userService.updateInfoUser(id, request))
				.build();
	}
}
