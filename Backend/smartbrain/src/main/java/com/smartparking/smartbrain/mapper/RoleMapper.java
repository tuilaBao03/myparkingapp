package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.dto.request.Role.RoleRequest;
import com.smartparking.smartbrain.dto.response.Role.RoleResponse;
import com.smartparking.smartbrain.model.Role;

@Mapper(componentModel = "spring")
public interface RoleMapper {
	@Mapping(target = "users", ignore = true)
	@Mapping(target = "permissions", ignore = true)
	Role toRole(RoleRequest roleRequest);

	RoleResponse toRoleResponse(Role role);
}
