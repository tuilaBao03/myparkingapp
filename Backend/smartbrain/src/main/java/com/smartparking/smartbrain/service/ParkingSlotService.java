package com.smartparking.smartbrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.ParkingSlot.CreatedParkingSlotRequest;
import com.smartparking.smartbrain.dto.response.ParkingSlot.ParkingSlotResponse;
import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.ParkingSlotMapper;
import com.smartparking.smartbrain.model.ParkingLot;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.repository.ParkingLotRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ParkingSlotService {
	ParkingSlotRepository parkingSlotRepository;
	ParkingSlotMapper parkingSlotMapper;
	ParkingLotRepository parkingLotRepository;

	public ParkingSlotResponse createParkingSlot(CreatedParkingSlotRequest request) {
		ParkingLot parkingLot = parkingLotRepository.findById(request.getParkingLotID())
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_FOUND));

		ParkingSlot parkingSlot = parkingSlotMapper.toParkingSlot(request);
		parkingSlot.setParkingLot(parkingLot);
		parkingSlot = parkingSlotRepository.save(parkingSlot);
		return parkingSlotMapper.toParkingSlotResponse(parkingSlot);
	}

	public void updateParkingSlotStatus(String parkingSlotID, SlotStatus status) {
		ParkingSlot parkingSlot = parkingSlotRepository.findById(parkingSlotID)
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_FOUND));
		parkingSlot.setSlotStatus(status);
		parkingSlotRepository.save(parkingSlot);
	}

	public ParkingSlotResponse getParkingSlot(String parkingSlotID) {
		ParkingSlot parkingSlot = parkingSlotRepository.findById(parkingSlotID)
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_SLOT_NOT_FOUND));
		return parkingSlotMapper.toParkingSlotResponse(parkingSlot);
	}

	public List<ParkingSlotResponse> getAllParkingSlotByParkingLotID(String parkingLotID) {
		List<ParkingSlot> parkingSlots = parkingSlotRepository.findByParkingLot_ParkingLotID(parkingLotID);
		return parkingSlots.stream().map(parkingSlotMapper::toParkingSlotResponse).toList();
	}

}
