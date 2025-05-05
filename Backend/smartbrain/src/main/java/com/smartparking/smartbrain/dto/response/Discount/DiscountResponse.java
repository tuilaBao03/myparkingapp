package com.smartparking.smartbrain.dto.response.Discount;
import com.smartparking.smartbrain.enums.DiscountType;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.time.Instant;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level=AccessLevel.PRIVATE)
public class DiscountResponse {
    String discountID;
    String discountCode;
    DiscountType discountType;
    double discountValue;
    String description;
    Instant expiredAt;
    Boolean isGlobalDiscount;
}
