package com.smartparking.smartbrain.model;

import java.time.Instant;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Getter
@Table(name = "ratings")
@Setter
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Rating {
	@Id
	@Column(name = "rating_id", nullable = false, updatable = false)
	@GeneratedValue(strategy = GenerationType.UUID)
	String ratingID;
	int ratingValue;
	String comment;

	// relationship
	@ManyToOne
	@JoinColumn(name = "parking_lot_id", nullable = false)
	ParkingLot parkingLot;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	User user;
	// Timestamp
	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;
	@UpdateTimestamp
	@Column(name = "updated_at")
	Instant updatedAt;

}
