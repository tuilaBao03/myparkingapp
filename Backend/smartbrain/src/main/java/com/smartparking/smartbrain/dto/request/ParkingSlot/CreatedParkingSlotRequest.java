package com.smartparking.smartbrain.dto.request.ParkingSlot;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

import jakarta.validation.constraints.*;
import lombok.AccessLevel;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreatedParkingSlotRequest {
    @NotEmpty(message = "Slot name is required")
    String slotName;

    @NotEmpty(message = "Vehicle type is required")
    String vehicleType;

    String slotStatus;

    @NotEmpty(message = "Price per hour is required")
    @Min(value = 0, message = "Price per hour must be greater than 0")
    BigDecimal pricePerHour;

    @NotEmpty(message = "Price per month is required")
    @Min(value = 0, message = "Price per month must be greater than 0")
    BigDecimal pricePerMonth;
    
    String parkingLotID;
}
