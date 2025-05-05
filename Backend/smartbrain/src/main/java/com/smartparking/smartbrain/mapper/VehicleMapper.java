package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.dto.request.Vehicle.VehicleRequest;
import com.smartparking.smartbrain.dto.response.Vehicle.VehicleResponse;
import com.smartparking.smartbrain.model.Vehicle;

@Mapper(componentModel = "spring")
public interface VehicleMapper {
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "invoices", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "user", ignore = true)
	@Mapping(target = "vehicleID", ignore = true)
	@Mapping(target = "isDeleted", ignore = true)
	Vehicle toVehicle(VehicleRequest request);

	VehicleResponse toVehicleResponse(Vehicle vehicle);

}
