package com.smartparking.smartbrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Vehicle.VehicleRequest;
import com.smartparking.smartbrain.dto.response.Vehicle.VehicleResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.VehicleMapper;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.model.Vehicle;
import com.smartparking.smartbrain.repository.UserRepository;
import com.smartparking.smartbrain.repository.VehicleRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class VehicleService {
	VehicleRepository vehicleRepository;
	VehicleMapper vehicleMapper;
	UserRepository userRepository;

	public VehicleResponse createVehicle(VehicleRequest request) {
		User user = userRepository.findById(request.getUserID())
				.orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
		Vehicle vehicle = vehicleMapper.toVehicle(request);
		vehicle.setUser(user);
		vehicleRepository.save(vehicle);
		return vehicleMapper.toVehicleResponse(vehicle);
	}

	public List<VehicleResponse> getVehicleByUserID(String userID) {
		List<Vehicle> vehicles = vehicleRepository.findByUser_userIDAndIsDeletedFalse(userID);
		if (vehicles.isEmpty()) {
			throw new AppException(ErrorCode.VEHICLE_NOT_FOUND);
		}
		return vehicles.stream().map(vehicleMapper::toVehicleResponse).toList();
	}

	public void deletedByID(String vehicleID) {
		Vehicle vehicle = vehicleRepository.findById(vehicleID)
				.orElseThrow(() -> new AppException(ErrorCode.VEHICLE_NOT_FOUND));
		vehicle.setDeleted(true);
		vehicleRepository.save(vehicle);
	}

}
