package com.smartparking.smartbrain.dto.response.MonthlyTicket;

import java.time.Instant;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor
@NoArgsConstructor
public class MonthlyTicketResponse {
    String monthlyTicketID;
    String parkingSlotID;
    String userID;
    String invoiceID;
    Instant createdAt;
    Instant updatedAt;
    Instant startedAt;
    Instant expiredAt;
}
