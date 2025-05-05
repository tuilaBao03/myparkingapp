package com.smartparking.smartbrain.dto.request.Image;

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
public class CreatedImageForUserRequest {
    @NotEmpty(message = "UserID can not Empty")
    String userID;
    @NotEmpty(message = "Image URL can not Empty")
    String imageURL;
    @NotEmpty(message = "ImageID can not Empty")
    String imagesID;
}

