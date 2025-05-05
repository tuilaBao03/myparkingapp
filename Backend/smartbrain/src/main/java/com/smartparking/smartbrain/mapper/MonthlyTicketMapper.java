package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.dto.request.MonthlyTicket.CreatedMonthlyTicketRequest;
import com.smartparking.smartbrain.dto.response.MonthlyTicket.MonthlyTicketResponse;
import com.smartparking.smartbrain.model.MonthlyTicket;

@Mapper(componentModel = "spring", uses = DateTimeConverter.class)
public interface MonthlyTicketMapper {

	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "invoice", ignore = true)
	@Mapping(target = "monthlyTicketID", ignore = true)
	@Mapping(target = "parkingSlot", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "user", ignore = true)
	@Mapping(source = "expiredAt", target = "expiredAt", qualifiedByName = "fromStringToInstant")
	@Mapping(source = "startedAt", target = "startedAt", qualifiedByName = "fromStringToInstant")
	MonthlyTicket toMonthlyTicket(CreatedMonthlyTicketRequest request);

	@Mapping(source = "invoice.invoiceID", target = "invoiceID")
	@Mapping(source = "parkingSlot.slotID", target = "parkingSlotID")
	@Mapping(source = "user.userID", target = "userID")
	MonthlyTicketResponse toMonthlyTicketResponse(MonthlyTicket monthlyTicket);
}
