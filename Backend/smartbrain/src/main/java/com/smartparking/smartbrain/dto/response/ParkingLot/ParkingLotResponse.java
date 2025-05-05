package com.smartparking.smartbrain.dto.response.ParkingLot;

import java.util.Set;

import com.smartparking.smartbrain.dto.response.Image.ImageResponse;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level=AccessLevel.PRIVATE)
public class ParkingLotResponse {
    String parkingLotID;
    String parkingLotName;
    String address;
    Double latitude;
    Double longitude;
    int totalSlot;
    String status;
    Double rate;
    String description;
    String userID;
    Set<ImageResponse> images;
}
