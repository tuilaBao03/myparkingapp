package com.smartparking.smartbrain.dto.response.Role;

import java.util.Set;

import com.smartparking.smartbrain.dto.response.Permission.PermissionResponse;

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
public class RoleResponse {
        
    String roleName;
    String description;
    Set<PermissionResponse> permissions;
}
