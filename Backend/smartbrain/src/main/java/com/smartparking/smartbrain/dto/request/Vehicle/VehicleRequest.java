package com.smartparking.smartbrain.dto.request.Vehicle;

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
public class VehicleRequest {
    @NotEmpty(message = "User ID can not empty")
    String userID;
    @NotEmpty(message = "Vehicle type can not empty")
    String vehicleType;
    @NotEmpty(message = "License plate can not empty")
    String licensePlate;
    String description;
}
