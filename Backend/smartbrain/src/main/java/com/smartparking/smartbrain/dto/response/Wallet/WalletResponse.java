package com.smartparking.smartbrain.dto.response.Wallet;
import java.math.BigDecimal;
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
public class WalletResponse {
    private String walletID;
    private String currency;
    private BigDecimal balance;
    private String name;
}