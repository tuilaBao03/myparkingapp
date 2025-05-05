package com.smartparking.smartbrain.service;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.SignedJWT;
import com.smartparking.smartbrain.config.JwtTokenProvider;
import com.smartparking.smartbrain.dto.request.Authentication.*;
import com.smartparking.smartbrain.dto.response.AuthenticationResponse;
import com.smartparking.smartbrain.dto.response.ChangePasswordResponse;
import com.smartparking.smartbrain.dto.response.IntrospectResponse;
import com.smartparking.smartbrain.encoder.AESEncryption;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.model.InvalidToken;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.InvalidatedRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthenticationSevice {
    final UserRepository userRepository;
    final PasswordEncoder passwordEncoder;
    final JwtTokenProvider jwtTokenProvider;
    final InvalidatedRepository invalidatedRepository;
    // final EmailService emailService;

	@Value("${jwt.signerKey}")
	protected String SECRET_KEY;

	public IntrospectResponse introspect(IntrospectRequest request)
			throws JOSEException, ParseException {
		boolean isValid = true;
		String message = "Token is valid";
		try {
			verifyToken(request.getToken(), "access");
		} catch (AppException e) {
			isValid = false;
			message = e.getMessage();
		}
		return IntrospectResponse.builder()
				.valid(isValid)
				.message(message)
				.build();
	}

	public AuthenticationResponse authenticate(AuthenticationRequest request) {
		User user = userRepository.findByUsername(request.getUsername()).orElseThrow(
				() -> new AppException(ErrorCode.USER_NOT_FOUND));

		boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPassword());
		if (!authenticated)
			throw new AppException(ErrorCode.INVALID_CREDENTIALS);
		return AuthenticationResponse.builder()
				.accessToken(jwtTokenProvider.generateAccessToken(user))
				.refreshToken(jwtTokenProvider.generateRefreshToken(user))
				.authenticated(true)
				.build();
	}

	private SignedJWT verifyToken(String token, String type) throws ParseException, JOSEException {

		JWSVerifier verifier = new MACVerifier(SECRET_KEY.getBytes());
		SignedJWT signedJWT = SignedJWT.parse(token);
		Object tokenTypeClaim = signedJWT.getJWTClaimsSet().getClaim("token-type");
		if (type.equals("refresh") && (tokenTypeClaim == null || !"refresh".equals(tokenTypeClaim.toString()))) {
			throw new AppException(ErrorCode.NOT_REFRESH_TOKEN);
		}

		Object scopeClaim = signedJWT.getJWTClaimsSet().getClaim("scope");
		if (type.equals("access") && (scopeClaim == null || scopeClaim.toString().isEmpty())) {
			throw new AppException(ErrorCode.NOT_ACCESS_TOKEN);
		}

		Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
		boolean isVerified = signedJWT.verify(verifier);
		if (invalidatedRepository.existsById(signedJWT.getJWTClaimsSet().getJWTID())) {
			throw new AppException(ErrorCode.TOKEN_EXPIRED);
		}
		if (!isVerified || !expirationTime.after(new Date())) {
			System.out.println("Token is invalid");
			System.out.println("isVerified: " + isVerified);
			System.out.println("expirationTime: " + expirationTime);
			throw new AppException(ErrorCode.UNAUTHORIZED);
		}
		return signedJWT;
	}

	public void logout(LogoutRequest request) throws JOSEException, ParseException {
		var signedJWT = verifyToken(request.getToken(), "access");
		String id = signedJWT.getJWTClaimsSet().getJWTID();
		Date expiryTime = signedJWT.getJWTClaimsSet().getExpirationTime();
		InvalidToken invalidToken = InvalidToken.builder()
				.tokenID(id)
				.expiryTime(expiryTime)
				.build();
		invalidatedRepository.save(invalidToken);
	}

	public AuthenticationResponse refreshToken(RefreshRequest request) throws ParseException, JOSEException {
		// verify the refresh token and invalidate it
		var signedJWT = verifyToken(request.getRefreshToken(), "refresh");
		String id = signedJWT.getJWTClaimsSet().getJWTID();
		Date expiryTime = signedJWT.getJWTClaimsSet().getExpirationTime();
		InvalidToken invalidRefreshToken = InvalidToken.builder()
				.tokenID(id)
				.expiryTime(expiryTime)
				.build();
		invalidatedRepository.save(invalidRefreshToken);
		// generate a new access token
		User user = userRepository.findById(signedJWT.getJWTClaimsSet().getClaim("userId").toString()).orElseThrow(
				() -> new AppException(ErrorCode.USER_NOT_FOUND));

		return AuthenticationResponse.builder()
				.accessToken(jwtTokenProvider.generateAccessToken(user))
				.refreshToken(jwtTokenProvider.generateRefreshToken(user))
				.authenticated(true)
				.build();

	}

	public ChangePasswordResponse forgotPassword(String email) {
		User user = userRepository.findByEmail(email)
				.orElseThrow(() -> new AppException(ErrorCode.EMAIL_NOT_FOUND));
		try {
			String objectEncrypt = AESEncryption.encryptObject(user, SECRET_KEY);
			// send mail for password reset
			Map<String, Object> variables = new HashMap<>();
			variables.put("name", user.getFirstName());
			String newPassword = UUID.randomUUID().toString();
			variables.put("newPassword", newPassword);
			// emailService.sendResetPasswordEmail(user.getEmail(), variables);
			user.setPassword(passwordEncoder.encode(newPassword));
			userRepository.save(user);
			return ChangePasswordResponse.builder()
					.userToken(objectEncrypt)
					.build();
		} catch (Exception e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Error occur when send email");
		}
	}

	public void resetPassword(ResetPassRequest request) {
		if (invalidatedRepository.existsById(request.getResetToken())) {
			throw new AppException(ErrorCode.TOKEN_EXPIRED);
		} else {
			String resetToken = AESEncryption.hashToUUID(request.getUserToken());
			InvalidToken invalidToken = InvalidToken.builder()
					.tokenID(resetToken)
					.expiryTime(new Date())
					.build();
			invalidatedRepository.save(invalidToken);
		}
		try {
			User user = AESEncryption.decryptObject(request.getUserToken(), SECRET_KEY, User.class);
			if (user == null) {
				throw new AppException(ErrorCode.ERROR_NOT_FOUND, "User not found");
			} else {
				User user1 = userRepository.findById(user.getUserID()).orElseThrow(
						() -> new AppException(ErrorCode.USER_NOT_FOUND));
				user1.setPassword(passwordEncoder.encode(request.getNewPassword()));
				userRepository.save(user1);
			}
		} catch (Exception e) {
			throw new AppException(ErrorCode.ERROR_NOT_FOUND, "Error occur when decrypt user");
		}
	}

}
