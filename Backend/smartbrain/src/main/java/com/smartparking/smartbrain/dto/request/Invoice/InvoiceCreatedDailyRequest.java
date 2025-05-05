package com.smartparking.smartbrain.dto.request.Invoice;

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
public class InvoiceCreatedDailyRequest {
    @NotEmpty(message = "Vehicle can not be null")
    String vehicleID;
    String description;
    @NotEmpty(message = "User can not be null")
    String userID;
    String discountCode;
    @NotEmpty(message = "Parking slot can not be null")
    String parkingSlotID;
    @NotEmpty(message = "Wallet can not be null")
    String walletID;
}
