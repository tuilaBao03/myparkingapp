package com.smartparking.smartbrain.mapper;

import org.hibernate.proxy.HibernateProxy;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.converter.EntityConverter;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedDailyRequest;
import com.smartparking.smartbrain.dto.request.Invoice.InvoiceCreatedMonthlyRequest;
import com.smartparking.smartbrain.dto.response.Invoice.InvoiceResponse;
import com.smartparking.smartbrain.model.Invoice;
import com.smartparking.smartbrain.model.MonthlyTicket;

@Mapper(componentModel = "spring", uses = { DateTimeConverter.class, EntityConverter.class })
public interface InvoiceMapper {

	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "invoiceID", ignore = true)
	@Mapping(target = "monthlyTicket", ignore = true)
	@Mapping(target = "status", ignore = true)
	@Mapping(target = "totalAmount", ignore = true)
	@Mapping(target = "transactions", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(source = "vehicleID", target = "vehicle", qualifiedByName = "mapVehicle")
	@Mapping(source = "userID", target = "user", qualifiedByName = "mapUser")
	@Mapping(source = "parkingSlotID", target = "parkingSlot", qualifiedByName = "mapParkingSlot")
	@Mapping(source = "discountCode", target = "discount", qualifiedByName = "mapDiscount")
	Invoice toDailyInvoice(InvoiceCreatedDailyRequest request);

	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "invoiceID", ignore = true)
	@Mapping(target = "monthlyTicket", ignore = true)
	@Mapping(target = "status", ignore = true)
	@Mapping(target = "totalAmount", ignore = true)
	@Mapping(target = "transactions", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(source = "vehicleID", target = "vehicle", qualifiedByName = "mapVehicle")
	@Mapping(source = "userID", target = "user", qualifiedByName = "mapUser")
	@Mapping(source = "parkingSlotID", target = "parkingSlot", qualifiedByName = "mapParkingSlot")
	@Mapping(source = "discountCode", target = "discount", qualifiedByName = "mapDiscount")
	Invoice toMonthlyInvoice(InvoiceCreatedMonthlyRequest request);

	@Mapping(source = "discount", target = "discount")
	@Mapping(source = "parkingSlot.slotName", target = "parkingSlotName")
	@Mapping(source = "user.userID", target = "userID")
	@Mapping(source = "vehicle", target = "vehicle")
	@Mapping(source = "monthlyTicket", target = "isMonthlyTicket", qualifiedByName = "mapIsMonthlyTicket")
	@Mapping(source = "parkingSlot.parkingLot.parkingLotName", target = "parkingLotName")
	@Mapping(target = "objectDecrypt", ignore = true)
	@Mapping(target = "parkingSlotID", source = "parkingSlot.slotID")
	InvoiceResponse toInvoiceResponse(Invoice invoice);

	// Named mapper
	@Named("mapIsMonthlyTicket")
	default boolean mapIsMonthlyTicket(MonthlyTicket monthlyTicket) {
		if (monthlyTicket == null ||
				monthlyTicket instanceof HibernateProxy
						&& !((HibernateProxy) monthlyTicket).getHibernateLazyInitializer().isUninitialized()) {
			return false;
		}
		return true;
	}


}
