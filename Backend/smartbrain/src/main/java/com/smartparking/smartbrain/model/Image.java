package com.smartparking.smartbrain.model;

import java.time.Instant;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "images")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Image {
	@Id
	@Column(name = "image_id", nullable = false, updatable = false)
	String imagesID;
	String url;

	// Relationship
	@ManyToOne
	@JoinColumn(name = "parking_lot_id", nullable = true)
	ParkingLot parkingLot;

	@OneToOne
	@JoinColumn(name = "user_id", nullable = true)
	@JsonIgnore
	User user;
	// Timestamp
	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;
	@UpdateTimestamp
	@Column(name = "updated_at")
	Instant updatedAt;
}
