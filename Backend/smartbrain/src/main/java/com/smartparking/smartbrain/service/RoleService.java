package com.smartparking.smartbrain.service;

import java.util.HashSet;
import java.util.List;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Role.RoleRequest;
import com.smartparking.smartbrain.dto.response.Role.RoleResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.RoleMapper;
import com.smartparking.smartbrain.model.Role;
import com.smartparking.smartbrain.repository.PermissionRepository;
import com.smartparking.smartbrain.repository.RoleRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RoleService {
	RoleRepository roleRepository;
	PermissionRepository permissionRepository;
	RoleMapper roleMapper;

	public RoleResponse createRole(RoleRequest roleRequest) {
		Role role = roleMapper.toRole(roleRequest);
		var permissions = permissionRepository.findAllById(roleRequest.getPermissions());
		role.setPermissions(new HashSet<>(permissions));
		role = roleRepository.save(role);
		return roleMapper.toRoleResponse(role);
	}

	public List<RoleResponse> getAllRoles() {
		return roleRepository.findAll()
				.stream()
				.map(roleMapper::toRoleResponse)
				.toList();
	}

	public void deleteRole(String roleName) {
		if (!roleRepository.existsById(roleName)) {
			throw new AppException(ErrorCode.ROLE_NOT_EXISTS);
		}
		roleRepository.deleteById(roleName);
	}
}
