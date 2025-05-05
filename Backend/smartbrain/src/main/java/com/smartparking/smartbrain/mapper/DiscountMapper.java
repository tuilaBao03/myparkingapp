package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.dto.request.Discount.DiscountGlobalRequest;
import com.smartparking.smartbrain.dto.request.Discount.DiscountParkingLotRequest;
import com.smartparking.smartbrain.dto.response.Discount.DiscountResponse;
import com.smartparking.smartbrain.model.Discount;

@Mapper(componentModel = "spring", uses = DateTimeConverter.class)
public interface DiscountMapper {

	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "discountID", ignore = true)
	@Mapping(target = "invoices", ignore = true)
	@Mapping(target = "parkingLot", ignore = true)
	@Mapping(target = "isGlobalDiscount", ignore = true)
	@Mapping(source = "expiredAt", target = "expiredAt", qualifiedByName = "fromStringToInstant")
	public Discount toDiscount(DiscountParkingLotRequest request);

	public DiscountResponse toDiscountResponse(Discount discount);

	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "discountID", ignore = true)
	@Mapping(target = "invoices", ignore = true)
	@Mapping(target = "parkingLot", ignore = true)
	@Mapping(target = "isGlobalDiscount", ignore = true)
	@Mapping(source = "expiredAt", target = "expiredAt", qualifiedByName = "fromStringToInstant")
	public Discount toDiscountGlobal(DiscountGlobalRequest request);

}
