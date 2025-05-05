package com.smartparking.smartbrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Discount.DiscountGlobalRequest;
import com.smartparking.smartbrain.dto.request.Discount.DiscountParkingLotRequest;
import com.smartparking.smartbrain.dto.response.Discount.DiscountResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.DiscountMapper;
import com.smartparking.smartbrain.model.Discount;
import com.smartparking.smartbrain.model.ParkingLot;
import com.smartparking.smartbrain.repository.DiscountRepository;
import com.smartparking.smartbrain.repository.ParkingLotRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class DiscountService {
	DiscountMapper discountMapper;
	DiscountRepository discountRepository;
	ParkingLotRepository parkingLotRepository;

	public DiscountResponse createParkingLotDiscount(DiscountParkingLotRequest request) {
		ParkingLot parkingLot = parkingLotRepository.findById(request.getParkingLotID())
				.orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_FOUND));
		Discount discount = discountMapper.toDiscount(request);
		discount.setParkingLot(parkingLot);
		discount.setIsGlobalDiscount(false);
		discountRepository.save(discount);
		return discountMapper.toDiscountResponse(discount);
	}

	public DiscountResponse createGlobalDiscount(DiscountGlobalRequest request) {
		Discount discount = discountMapper.toDiscountGlobal(request);
		discountRepository.save(discount);
		return discountMapper.toDiscountResponse(discount);
	}

	public DiscountResponse getDiscount(String discountID) {
		Discount discount = discountRepository.findById(discountID)
				.orElseThrow(() -> new AppException(ErrorCode.DISCOUNT_NOT_FOUND));
		return discountMapper.toDiscountResponse(discount);
	}

	public List<DiscountResponse> getAllDiscountByParkingLotID(String parkingLotID) {
		List<Discount> discounts = discountRepository.findAllByParkingLot_ParkingLotID(parkingLotID);
		return discounts.stream().map(discountMapper::toDiscountResponse).toList();
	}

	public List<DiscountResponse> getAllGlobalDiscount() {
		List<Discount> discounts = discountRepository.findByParkingLotIsNull();
		return discounts.stream().map(discountMapper::toDiscountResponse).toList();
	}

	public void deleteDiscount(String discountID) {
		if (!discountRepository.existsById(discountID)) {
			throw new AppException(ErrorCode.DISCOUNT_NOT_EXISTS);
		}
		discountRepository.deleteById(discountID);
	}
}
