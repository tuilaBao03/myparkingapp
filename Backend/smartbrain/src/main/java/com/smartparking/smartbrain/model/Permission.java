package com.smartparking.smartbrain.model;

import java.util.Set;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@Table(name = "permissions")
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Permission {
	@Id
	@NotNull(message = "Permission name cannot be null")
	String permissionName;
	String description;

	// Relationship with Role ManytoMany - Permissions can have many roles
	@ManyToMany(mappedBy = "permissions", fetch = FetchType.LAZY)
	Set<Role> roles;
}
