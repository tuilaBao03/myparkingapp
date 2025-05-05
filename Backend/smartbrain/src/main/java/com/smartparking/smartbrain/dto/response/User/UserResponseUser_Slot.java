package com.smartparking.smartbrain.dto.response.User;

import java.util.List;
import java.util.Set;

import com.smartparking.smartbrain.enums.UserStatus;
import com.smartparking.smartbrain.model.ParkingLot;

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
public class UserResponseUser_Slot
 {
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String homeAddress;
    private String companyAddress;
    private Set<String> roles;
    private UserStatus status;
    private String avatar;
    private List<ParkingLot> parkingLot;
}
