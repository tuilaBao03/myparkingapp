package com.smartparking.smartbrain.model;

import java.time.Instant;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.smartparking.smartbrain.enums.VehicleType;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "vehicles")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Vehicle {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name = "vehicle_id", nullable = false, updatable = false)
	String vehicleID;

	@Enumerated(EnumType.STRING)
	VehicleType vehicleType;

	String licensePlate;

	String description;

	// Relationship
	@ManyToOne(fetch = FetchType.LAZY)
	@JsonIgnore
	@JoinColumn(name = "user_id", nullable = false)
	User user;
	@OneToMany(mappedBy = "vehicle", fetch = FetchType.LAZY)
	@JsonIgnore
	Set<Invoice> invoices;

	// Timestamp
	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;
	@UpdateTimestamp
	@Column(name = "updated_at")
	Instant updatedAt;
	@Column(name = "is_deleted")
	@Builder.Default
	boolean isDeleted = false;

}
