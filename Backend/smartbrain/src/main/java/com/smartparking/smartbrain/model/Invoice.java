package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.smartparking.smartbrain.enums.InvoiceStatus;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "invoices")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Invoice {
	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name = "invoice_id", nullable = false, updatable = false)
	String invoiceID;

	BigDecimal totalAmount;
	@Enumerated(EnumType.STRING)
	@Builder.Default
	InvoiceStatus status = InvoiceStatus.PENDING;
	String description;

	// Relationship
	@OneToMany(mappedBy = "invoice", fetch = FetchType.LAZY)
	@JsonIgnore
	Set<Transaction> transactions;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	@JsonIgnore
	User user;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "discount_id", nullable = true)
	@JsonIgnore
	Discount discount;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parking_slot_id", nullable = false)
	@JsonIgnore
	ParkingSlot parkingSlot;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "vehicle_id", nullable = false)
	@JsonIgnore
	Vehicle vehicle;

	@OneToOne(mappedBy = "invoice", fetch = FetchType.LAZY)
	@JsonIgnore
	MonthlyTicket monthlyTicket;

	// Timestamp
	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;
	@UpdateTimestamp
	@Column(name = "updated_at")
	Instant updatedAt;

}
