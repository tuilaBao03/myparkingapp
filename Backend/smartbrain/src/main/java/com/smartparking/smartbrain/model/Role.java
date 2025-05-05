package com.smartparking.smartbrain.model;

import java.util.Set;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Getter
@Setter
@Table(name = "roles")
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class Role {
	@Id
	@NotNull(message = "Role name cannot be null")
	String roleName;
	String description;

	@ManyToMany(mappedBy = "roles", fetch = FetchType.LAZY)
	Set<User> users;

	// Relationship with Permission ManytoMany - Roles can have many permissions
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "role_permissions", joinColumns = @JoinColumn(name = "role_name"), inverseJoinColumns = @JoinColumn(name = "permission_name"))
	Set<Permission> permissions;
}
