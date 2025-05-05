package com.smartparking.smartbrain.dto.request.MonthlyTicket;

import jakarta.validation.constraints.NotEmpty;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreatedMonthlyTicketRequest {
    @NotEmpty(message = "Parking slot can not empty")
    String parkingSlotID;
    @NotEmpty(message = "User can not empty")
    String userID;
    @NotEmpty(message = "Invoice can not empty")
    String invoiceID;
    @NotEmpty(message = "Expired time can not empty")
    String expiredAt;
    @NotEmpty(message = "Start time can not empty")
    String startedAt;
}
