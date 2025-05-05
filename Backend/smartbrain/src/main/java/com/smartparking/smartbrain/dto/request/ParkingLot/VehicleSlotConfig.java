package com.smartparking.smartbrain.dto.request.ParkingLot;

import java.math.BigDecimal;

import com.smartparking.smartbrain.enums.VehicleType;

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
public class VehicleSlotConfig {
    @NotEmpty(message = "Vehicle Type is required")
    VehicleType vehicleType;
    @NotEmpty(message = "Number of Slot is required")
    Integer numberOfSlot; // số lượng slot của loại xe này
    @NotEmpty(message = "Price Per Hour is required")
    BigDecimal pricePerHour;
    @NotEmpty(message = "Price Per Month is required")
    BigDecimal pricePerMonth;
}
