package com.smartparking.smartbrain.dto.request.Discount;


import java.math.BigDecimal;

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
public class DiscountParkingLotRequest {
    @NotEmpty(message = "Parking lot id can not empty")
    String parkingLotID;
    @NotEmpty(message = "Discount code can not empty")
    String discountCode;
    @NotEmpty(message = "Discount type can not empty")
    String discountType;
    @NotEmpty(message="Discount value can not empty")
    String discountValue;
    String description;
    @NotEmpty(message = "Expired time can not empty")
    String expiredAt;
    BigDecimal maxValue;
}
