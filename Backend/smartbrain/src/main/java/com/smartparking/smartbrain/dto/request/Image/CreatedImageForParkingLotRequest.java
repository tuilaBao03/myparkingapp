package com.smartparking.smartbrain.dto.request.Image;

import java.util.List;

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
public class CreatedImageForParkingLotRequest {
    List<String> imageURLs;
    String parkingLotID;
    List<String> imageIDs;
}

