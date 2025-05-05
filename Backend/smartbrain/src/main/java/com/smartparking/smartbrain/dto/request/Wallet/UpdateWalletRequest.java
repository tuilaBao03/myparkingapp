package com.smartparking.smartbrain.dto.request.Wallet;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class UpdateWalletRequest {
    String currency; // USD, EUR, VND, ...
    String name;
    @NotEmpty(message = "Wallet ID is required")
    String walletID;
}
