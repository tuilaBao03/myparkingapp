package com.smartparking.smartbrain.dto.request.Authentication;

import jakarta.validation.constraints.NotNull;
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
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ResetPassRequest {
    @NotNull(message = "User token cannot be null")
    String userToken;
    @NotNull(message = "New password cannot be null")
    String newPassword;
    @NotNull(message = "Reset token cannot be null")
    String resetToken;
}
