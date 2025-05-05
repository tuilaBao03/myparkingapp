package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.dto.request.Permission.PermissionRequest;
import com.smartparking.smartbrain.dto.response.Permission.PermissionResponse;
import com.smartparking.smartbrain.model.Permission;

@Mapper(componentModel = "spring")
public interface PermissionMapper {
	@Mapping(target = "roles", ignore = true)
	Permission toPermission(PermissionRequest permissionRequest);

	PermissionResponse toPermissionResponse(Permission permission);
}
