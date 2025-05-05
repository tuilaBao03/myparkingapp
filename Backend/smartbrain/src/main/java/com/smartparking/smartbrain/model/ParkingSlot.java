package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.enums.VehicleType;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "parking_slots")
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class ParkingSlot {
	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name = "parking_slot_id", nullable = false, updatable = false)
	String slotID;
	String slotName;

	@Enumerated(EnumType.STRING)
	VehicleType vehicleType;

	@Enumerated(EnumType.STRING)
	@Builder.Default
	@Column(nullable = false, columnDefinition = "varchar(255) default 'AVAILABLE'")
	SlotStatus slotStatus = SlotStatus.AVAILABLE;
	@Column(nullable = false)
	BigDecimal pricePerHour;
	@Column(nullable = false)
	BigDecimal pricePerMonth;

	// Relationship
	@ManyToOne
	@JoinColumn(name = "parking_lot_id", nullable = false)
	ParkingLot parkingLot;
	@OneToMany(mappedBy = "parkingSlot")
	Set<Invoice> invoices;
	@OneToMany(mappedBy = "parkingSlot")
	Set<MonthlyTicket> monthlyTickets;

	// Timestamp
	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;
	@UpdateTimestamp
	@Column(name = "updated_at")
	Instant updatedAt;

}
