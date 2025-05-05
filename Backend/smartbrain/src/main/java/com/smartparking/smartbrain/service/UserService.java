package com.smartparking.smartbrain.service;

import java.util.HashSet;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Image.CreatedImageForUserRequest;
import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.dto.request.User.UserRegisterRequest;
import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.Image.ImageResponse;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.ImageMapper;
import com.smartparking.smartbrain.mapper.UserMapper;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.ImagesRepository;
import com.smartparking.smartbrain.repository.RoleRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserService {
	UserRepository userRepository;
	RoleRepository roleRepository;
	PasswordEncoder passwordEncoder;
	ImagesRepository imagesRepository;
	UserMapper userMapper;
	ImageSevice imageSevice;
	ImageMapper imageMapper;

	public UserResponse createReqUser(UserRequest request) {
		if (userRepository.existsByUsername(request.getUsername())) {
			throw new AppException(ErrorCode.USER_ALREADY_EXISTS);
		}
		if (request.getPassword() == null || request.getPassword().length() < 6) {
			throw new AppException(ErrorCode.PASSWORD_NOT_VALID);
		}
		User user = userMapper.fromCreateToUser(request);
		// Encoded Password
		user.setPassword(passwordEncoder.encode(request.getPassword()));
		// Set roles for user
		var roles = roleRepository.findAllById(request.getRoles());
		System.out.println(roles);
		if (roles.isEmpty()) {
			throw new AppException(ErrorCode.ROLE_NOT_FOUND);
		}
		imageSevice.addImageForUser(request.getImages());
		ImageResponse imageResponse = ImageResponse.builder()
				.imagesID(request.getImages().getImagesID())
				.url(request.getImages().getImageURL())
				.build();
		user.setRoles(new HashSet<>(roles));
		userRepository.save(user);
		UserResponse userResponse = userMapper.toUserResponse(user);
		userResponse.setImage(imageResponse);
		return userResponse;
	}

	public UserResponse getMe() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = (String) authentication.getName(); // Lấy userId từ authentication (JWT token)
		log.info("User ID: {}", userId);
		User user = userRepository.findById(userId)
				.orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
		return userMapper.toUserResponse(user);
	}

	public void registerUser(UserRegisterRequest request) {
		if (userRepository.existsByUsername(request.getUsername())) {
			throw new AppException(ErrorCode.USER_ALREADY_EXISTS);
		}
		if (request.getPassword() == null || request.getPassword().length() < 6) {
			throw new AppException(ErrorCode.PASSWORD_NOT_VALID);
		}
		User user = userMapper.fromRegisterToUser(request);
		// Encoded Password
		user.setPassword(passwordEncoder.encode(request.getPassword()));
		// Set roles for user
		var roles = roleRepository.findAllById(request.getRoles());
		System.out.println(roles);
		if (roles.isEmpty()) {
			throw new AppException(ErrorCode.ROLE_NOT_FOUND);
		}
		user.setRoles(new HashSet<>(roles));
		userRepository.save(user);
	}

	@PreAuthorize("hasRole('ADMIN')")
	public List<UserResponse> getAllUser() {
		return userRepository.findAll().stream()
				.map(userMapper::toUserResponse)
				.toList();
	}

	@PreAuthorize("#id == authentication.token.claims['userId'] or hasRole('ADMIN')")
	public UserResponse getUserById(String id) {
		User user = userRepository.findById(id)
				.orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
		return userMapper.toUserResponse(user);
	}

	@PreAuthorize("#name == authentication.name or hasRole('ADMIN')")
	public UserResponse getUserByName(String name) {
		User user = userRepository.findByUsername(name)
				.orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
		return userMapper.toUserResponse(user);
	}

	@PreAuthorize("#id == authentication.token.claims['userId'] or hasRole('ADMIN')")
	public void deleteUser(String id) {
		if (!userRepository.existsById(id)) {
			throw new AppException(ErrorCode.USER_NOT_FOUND);
		}
		userRepository.deleteById(id);
	}

	@PreAuthorize("#id == authentication.token.claims['userId'] or hasRole('ADMIN')")
	public UserResponse updateInfoUser(String id, UpdatedUserRequest request) {
		User user = userRepository.findById(id)
				.orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
		userMapper.updateUserFromRequest(request, user);
		Image avatar = imagesRepository.findByUser_UserID(user.getUserID())
				.orElse(null);
		ImageResponse imageResponse = null;
		if (avatar == null) {
			CreatedImageForUserRequest imageRequest = request.getAvatar();
			imageRequest.setUserID(id);
			imageResponse = imageSevice.addImageForUser(imageRequest);
		} else {
			if (request.getAvatar().getImageURL() == "") {
				imageResponse = imageMapper.fromImageToImageResponse(avatar);
			} else {
				avatar.setUrl(request.getAvatar().getImageURL());
				imageResponse = imageMapper.fromImageToImageResponse(imagesRepository.save(avatar));
			}
		}
		userRepository.save(user);
		UserResponse response = userMapper.toUserResponse(user);
		response.setImage(imageResponse);
		return response;
	}

}
