package com.smartparking.smartbrain.dto.request.ParkingLot;

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
public class EnterParkingLotRequest {
    @NotEmpty(message = "Invoice ID can not be null")
    String invoiceID;
}
