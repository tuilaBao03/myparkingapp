package com.smartparking.smartbrain.dto.request.ParkingLot;
import java.util.Set;

import com.smartparking.smartbrain.dto.request.Image.CreatedImageForParkingLotRequest;
import com.smartparking.smartbrain.validator.ValidParkingLotConfig;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import lombok.experimental.FieldDefaults;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@ValidParkingLotConfig
public class CreatedParkingLotRequest {
    @NotEmpty(message = "Parking Spot Name is required")
    String parkingLotName;        // Tên của Parking Spot
    
    String address;                // Địa chỉ
    
    @NotNull(message = "Latitude is required")
    Double latitude;   // Kinh độ
    
    @NotNull(message = "Longitude is required")
    
    Double longitude;              // Thông tin tọa độ (latitude, longitude)
    
    String status;               // Trạng thái (còn hoạt động hay không)
    
    Double rate;                // Số sao đánh giá
    
    String description;                   // Ghi chú
    
    @NotEmpty(message = "User ID is required")
    @Pattern(
        regexp = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
        message = "User ID must be a valid UUID"
    )
    String userID;
    
    @NotNull(message = "Total Slot is required")
    @Min(value = 1, message = "Total Slot must be greater than 0")
    Integer totalSlot;            // Số lượng slot của bãi đỗ

    CreatedImageForParkingLotRequest images;      // Danh sách ảnh

    Set<LocationConfig> locationConfigs; // Danh sách cấu hình khu vực
}
