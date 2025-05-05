package com.smartparking.smartbrain.dto.request.ParkingLot;

import java.util.Set;

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
public class LocationConfig {
    @NotEmpty(message = "Location name is required")
    String location;
    @NotEmpty(message = "Total Slot in this location is required")
    Integer totalSlot; // số lượng slot của khu vực hoặc tầng này
    @NotEmpty(message = "Vehicle Slot Config is required")
    Set<VehicleSlotConfig> vehicleSlotConfigs;
}
