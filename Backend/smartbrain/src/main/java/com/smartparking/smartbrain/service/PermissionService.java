package com.smartparking.smartbrain.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Permission.PermissionRequest;
import com.smartparking.smartbrain.dto.response.Permission.PermissionResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.PermissionMapper;
import com.smartparking.smartbrain.model.Permission;
import com.smartparking.smartbrain.repository.PermissionRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PermissionService {

	PermissionRepository permissionRepository;
	PermissionMapper permissionMapper;

	public PermissionResponse createPermission(PermissionRequest permissionRequest) {
		Permission permission = permissionMapper.toPermission(permissionRequest);
		permission = permissionRepository.save(permission);
		return permissionMapper.toPermissionResponse(permission);
	}

	public List<PermissionResponse> getAllPermissions() {
		var permissions = permissionRepository.findAll();
		return permissions.stream().map(permissionMapper::toPermissionResponse).toList();
	}

	public void deletePermission(String permissionName) {
		if (!permissionRepository.existsById(permissionName)) {
			throw new AppException(ErrorCode.PERMISSION_NOT_EXISTS);
		}
		permissionRepository.deleteById(permissionName);
	}

}
