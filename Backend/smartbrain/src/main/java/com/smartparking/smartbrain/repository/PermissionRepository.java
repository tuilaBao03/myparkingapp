package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Permission;

@Repository
public interface PermissionRepository extends JpaRepository<Permission, String> {
}
