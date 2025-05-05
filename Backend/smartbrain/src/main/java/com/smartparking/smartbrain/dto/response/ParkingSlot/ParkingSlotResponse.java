package com.smartparking.smartbrain.dto.response.ParkingSlot;

import java.math.BigDecimal;

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
public class ParkingSlotResponse {
    String slotID;
    String slotName;
    String vehicleType;
    String slotStatus;
    BigDecimal pricePerHour;
    BigDecimal pricePerMonth;
}
