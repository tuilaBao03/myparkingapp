package com.smartparking.smartbrain.mapper;

import java.util.Set;
import java.util.stream.Collectors;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import com.smartparking.smartbrain.dto.request.User.UpdatedUserRequest;
import com.smartparking.smartbrain.dto.request.User.UserRegisterRequest;
import com.smartparking.smartbrain.dto.request.User.UserRequest;
import com.smartparking.smartbrain.dto.response.User.UserResponse;
import com.smartparking.smartbrain.dto.response.Vehicle.VehicleResponse;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.model.Vehicle;

@Mapper(componentModel = "spring", uses = { VehicleMapper.class })
public interface UserMapper {

	@Mapping(target = "roles", ignore = true) // need custom
	@Mapping(target = "password", ignore = true) // need custom
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "invoices", ignore = true)
	@Mapping(target = "monthlyTickets", ignore = true)
	@Mapping(target = "parkingLots", ignore = true)
	@Mapping(target = "transactions", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "userID", ignore = true)
	@Mapping(target = "vehicles", ignore = true)
	@Mapping(target = "wallets", ignore = true)
	@Mapping(target = "ratings", ignore = true)
	@Mapping(target = "status", ignore = true) // need custom
	@Mapping(target = "image", ignore = true)
	User fromCreateToUser(UserRequest userRequest);

	@Mapping(target = "roles", ignore = true) // need custom
	@Mapping(target = "password", ignore = true) // need custom
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "invoices", ignore = true)
	@Mapping(target = "monthlyTickets", ignore = true)
	@Mapping(target = "parkingLots", ignore = true)
	@Mapping(target = "transactions", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "userID", ignore = true)
	@Mapping(target = "vehicles", ignore = true)
	@Mapping(target = "wallets", ignore = true)
	@Mapping(target = "ratings", ignore = true)
	@Mapping(target = "status", ignore = true) // need custom
	@Mapping(target = "image", ignore = true)
	@Mapping(target = "homeAddress", ignore = true)
	@Mapping(target = "companyAddress", ignore = true)
	User fromRegisterToUser(UserRegisterRequest userRegisterRequest);

	@Mapping(target = "vehicles", expression = "java(filterDeletedVehicles(user.getVehicles()))")
	UserResponse toUserResponse(User user);

	@Mapping(target = "roles", ignore = true) // need custom
	@Mapping(target = "password", ignore = true) // need custom
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "invoices", ignore = true)
	@Mapping(target = "monthlyTickets", ignore = true)
	@Mapping(target = "parkingLots", ignore = true)
	@Mapping(target = "transactions", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "userID", ignore = true)
	@Mapping(target = "username", ignore = true)
	@Mapping(target = "vehicles", ignore = true)
	@Mapping(target = "wallets", ignore = true)
	@Mapping(target = "ratings", ignore = true)
	@Mapping(target = "image", ignore = true) // need custom
	void updateUserFromRequest(UpdatedUserRequest request, @MappingTarget User user);

	default Set<VehicleResponse> filterDeletedVehicles(Set<Vehicle> vehicles) {
		if (vehicles == null)
			return null;

		return vehicles.stream()
				.filter(vehicle -> !vehicle.isDeleted())
				.map(this::mapToVehicleResponse)
				.collect(Collectors.toSet());
	}

	VehicleResponse mapToVehicleResponse(Vehicle vehicle);

}
