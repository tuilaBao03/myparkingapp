package com.smartparking.smartbrain.dto.response.Wallet;

import java.math.BigDecimal;
import java.time.Instant;

import com.smartparking.smartbrain.enums.TransactionType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.AccessLevel;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TransactionResponse {
    String transactionID;    // Mã giao dịch
    String walletID;         // ID ví liên quan
    BigDecimal currentBalance;  // Số dư sau giao dịch
    BigDecimal amount;          // Số tiền giao dịch
    Instant timestamp;        // Thời gian giao dịch
    String description;         // Mô tả giao dịch
    TransactionType type;
}
