package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;

import com.smartparking.smartbrain.enums.DiscountType;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "discounts")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Discount {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name = "discount_id", nullable = false, updatable = false)
	String discountID;
	@Column(unique = true)
	String discountCode;
	@Enumerated(EnumType.STRING)
	DiscountType discountType;
	double discountValue;
	BigDecimal maxValue;
	String description;
	@Builder.Default
	Boolean isGlobalDiscount = true;

	// Relationship
	@OneToMany(mappedBy = "discount")
	Set<Invoice> invoices;

	@ManyToOne
	@JoinColumn(name = "parking_lot_id", nullable = true)
	ParkingLot parkingLot;

	// Timestamp
	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;

	@Column(name = "expired_at")
	Instant expiredAt;

}
