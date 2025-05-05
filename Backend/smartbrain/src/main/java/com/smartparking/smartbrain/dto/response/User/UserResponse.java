package com.smartparking.smartbrain.dto.response.User;

import java.util.Set;

import com.smartparking.smartbrain.dto.response.Image.ImageResponse;
import com.smartparking.smartbrain.dto.response.Role.RoleResponse;
import com.smartparking.smartbrain.dto.response.Vehicle.VehicleResponse;
import com.smartparking.smartbrain.enums.UserStatus;
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
public class UserResponse {
    String userID;
    String username;
    String firstName;
    String lastName;
    String email;
    String phone;
    String homeAddress;
    String companyAddress;
    Set<RoleResponse> roles;
    Set<VehicleResponse> vehicles;
    UserStatus status;
    ImageResponse image;
}
