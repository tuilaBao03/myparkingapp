package com.smartparking.smartbrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Image.CreatedImageForParkingLotRequest;
import com.smartparking.smartbrain.dto.request.Image.CreatedImageForUserRequest;
import com.smartparking.smartbrain.dto.response.Image.ImageResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.ImageMapper;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.repository.ImagesRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ImageSevice {
	ImagesRepository imagesRepository;
	ImageMapper imageMapper;

	public ImageResponse addImageForUser(CreatedImageForUserRequest request) {
		Image image = imagesRepository.save(imageMapper.fromUserRequestToImage(request));
		return imageMapper.fromImageToImageResponse(image);
	}

	public void addImagesForParkingLot(CreatedImageForParkingLotRequest request) {
		List<Image> image = imageMapper.fromParkingLotRequestToImage(request);
		imagesRepository.saveAll(image);
	}

	public ImageResponse getImageOfUser(String userID) {
		Image image = imagesRepository.findByUser_UserID(userID)
				.orElseThrow(() -> new AppException(ErrorCode.IMAGE_NOT_FOUND));
		return imageMapper.fromImageToImageResponse(image);
	}

	public List<ImageResponse> getImageOfParkingLot(String parkingLotID) {
		List<Image> images = imagesRepository.findByParkingLot_ParkingLotID(parkingLotID)
				.orElseThrow(() -> new AppException(ErrorCode.IMAGE_NOT_FOUND));
		return images.stream()
				.map(imageMapper::fromImageToImageResponse)
				.toList();
	}
}
