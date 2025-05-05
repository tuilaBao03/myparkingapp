package com.smartparking.smartbrain.mapper;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.converter.EntityConverter;
import com.smartparking.smartbrain.dto.request.Image.CreatedImageForParkingLotRequest;
import com.smartparking.smartbrain.dto.request.Image.CreatedImageForUserRequest;
import com.smartparking.smartbrain.dto.response.Image.ImageResponse;
import com.smartparking.smartbrain.model.Image;

@Mapper(componentModel = "spring", uses = { EntityConverter.class })
public interface ImageMapper {
	@Mapping(source = "userID", target = "user", qualifiedByName = "mapUser")
	@Mapping(source = "imageURL", target = "url")
	@Mapping(target = "imagesID", source = "imagesID")
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "parkingLot", ignore = true)
	Image fromUserRequestToImage(CreatedImageForUserRequest request);

	@Mapping(source = "imageURL", target = "url")
	@Mapping(target = "imagesID", ignore = true)
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(source = "parkingLotID", target = "parkingLot", qualifiedByName = "mapParkingLot")
	@Mapping(target = "user", ignore = true)
	Image from(String imageURL, String parkingLotID);

	default List<Image> fromParkingLotRequestToImage(CreatedImageForParkingLotRequest request) {
		if (request == null || request.getImageURLs() == null) {
			return Collections.emptyList();
		}
		return request.getImageURLs().stream()
				.map(url -> from(url, request.getParkingLotID()))
				.collect(Collectors.toList());
	}

	ImageResponse fromImageToImageResponse(Image image);
}