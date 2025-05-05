package com.smartparking.smartbrain.dto.request.User;

import java.util.Set;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
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
public class UserRegisterRequest {
    @NotEmpty(message = "Username is required")
    @Size(min = 6, max = 20, message = "Username must be between 3 and 20 characters")
    String username;
    @Size(min = 6, message = "Password must be at least 6 characters")
    @NotEmpty(message = "Password is required")
    String password;
    @NotEmpty(message = "First name is required")
    String firstName;
    @NotEmpty(message = "Last name is required")
    String lastName;
    @NotEmpty(message = "Email is required")
    String email;
    @NotEmpty(message = "Phone number is required")
    String phone;
    Set<String> roles;
}

