package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.response.ParkingLot.ParkingLotResponse;
import com.smartparking.smartbrain.model.ParkingLot;

@Mapper(componentModel = "spring")
public interface ParkingLotMapper {
	@Mapping(target = "images", ignore = true)
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "parkingLotID", ignore = true)
	@Mapping(target = "parkingSlots", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "user", ignore = true)
	@Mapping(target = "discounts", ignore = true)
	@Mapping(target = "ratings", ignore = true)
	ParkingLot toParkingLot(CreatedParkingLotRequest createdParkingLotRequest);

	@Mapping(target = "userID", ignore = true)
	ParkingLotResponse toParkingLotResponse(ParkingLot parkingLot);
}
