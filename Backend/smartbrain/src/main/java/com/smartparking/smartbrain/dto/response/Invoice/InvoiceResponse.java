package com.smartparking.smartbrain.dto.response.Invoice;
import java.math.BigDecimal;
import java.time.Instant;
import com.smartparking.smartbrain.dto.response.Discount.DiscountResponse;
import com.smartparking.smartbrain.dto.response.Vehicle.VehicleResponse;
import com.smartparking.smartbrain.enums.InvoiceStatus;
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
public class InvoiceResponse {
    String invoiceID;
    BigDecimal totalAmount;
    InvoiceStatus status;
    String description;
    String userID;
    DiscountResponse discount;
    String parkingSlotName;
    String parkingSlotID;
    String parkingLotName;
    VehicleResponse vehicle;
    Boolean isMonthlyTicket;
    Instant createdAt;
    String objectDecrypt;
}
