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
public class PaymentDailyRequest {
    @NotEmpty(message = "Invoice can not be null")
    String invoiceID;
    @NotEmpty(message = "Wallet can not be null")
    String walletID;
    String parkingSlotID;
    String discountID;
}
