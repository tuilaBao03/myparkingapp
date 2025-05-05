package com.smartparking.smartbrain.controller;

import java.text.ParseException;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import com.nimbusds.jose.JOSEException;
import com.smartparking.smartbrain.dto.request.Authentication.*;
import com.smartparking.smartbrain.dto.request.User.UserRegisterRequest;
import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.AuthenticationResponse;
import com.smartparking.smartbrain.dto.response.ChangePasswordResponse;
import com.smartparking.smartbrain.dto.response.IntrospectResponse;
import com.smartparking.smartbrain.service.AuthenticationSevice;
import com.smartparking.smartbrain.service.UserService;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@RestController
@RequestMapping("myparkingapp/auth")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationController {
	AuthenticationSevice authenticationService;
	UserService userService;

	@PostMapping("/login")
	ApiResponse<AuthenticationResponse> login(@RequestBody @Valid AuthenticationRequest request) {
		var result = authenticationService.authenticate(request);
		return ApiResponse.<AuthenticationResponse>builder()
				.code(200)
				.message("Login successfully")
				.result(result)
				.build();
	}

	@PostMapping("/register")
	public ApiResponse<Void> createRequestUser(@RequestBody @Valid UserRegisterRequest request) {
		userService.registerUser(request);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("User register successfully")
				.build();

	}

	@PostMapping("/introspect")
	ApiResponse<IntrospectResponse> introspect(@RequestBody @Valid IntrospectRequest request)
			throws JOSEException, ParseException {
		var result = authenticationService.introspect(request);
		return ApiResponse.<IntrospectResponse>builder()
				.code(200)
				.message("Introspect successfully")
				.result(result)
				.build();
	}

	@PostMapping("/logout")
	ApiResponse<Void> logout(@RequestBody LogoutRequest request)
			throws JOSEException, ParseException {
		authenticationService.logout(request);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("Logout successfully")
				.build();
	}

	@PostMapping("/refresh")
	ApiResponse<AuthenticationResponse> refresh(@RequestBody @Valid RefreshRequest request)
			throws ParseException, JOSEException {
		var result = authenticationService.refreshToken(request);
		return ApiResponse.<AuthenticationResponse>builder()
				.code(200)
				.result(result)
				.message("Refresh token successfully")
				.build();
	}

	@GetMapping("/principal")
	public Object getPrincipal(@AuthenticationPrincipal Object principal) {
		System.out.println(
				"🔹 Principal Class: " + (principal != null ? principal.getClass().getName() : "null"));
		return principal;
	}

	@PostMapping("/forgot-password")
	public ApiResponse<ChangePasswordResponse> forgotPassword(
			@RequestBody @Valid ForgotPassRequest request) {
		var result = authenticationService.forgotPassword(request.getEmail());
		return ApiResponse.<ChangePasswordResponse>builder()
				.code(200)
				.result(result)
				.message("Send email successfully")
				.build();
	}

	@PostMapping("/reset-password")
	public ApiResponse<Void> resetPassword(@RequestBody @Valid ResetPassRequest request) {
		authenticationService.resetPassword(request);
		return ApiResponse.<Void>builder()
				.code(200)
				.message("Reset password successfully, please check the new password in your email")
				.build();
	}

	@GetMapping("/error")
	public ApiResponse<Void> error() {
		return ApiResponse.<Void>builder()
				.code(200)
				.message("Has error occur")
				.build();
	}
}
