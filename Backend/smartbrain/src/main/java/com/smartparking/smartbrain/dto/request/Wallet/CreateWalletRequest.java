package com.smartparking.smartbrain.dto.request.Wallet;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class CreateWalletRequest {

    @NotNull(message = "User ID is required")
    String userId;

    @NotBlank(message = "Currency is required")
    
    String currency; // USD, EUR, VND, ...

    @Builder.Default
    BigDecimal balance = BigDecimal.ZERO; // Default value: 0

    @NotBlank(message = "Name of wallet is required")
    String name;
}
