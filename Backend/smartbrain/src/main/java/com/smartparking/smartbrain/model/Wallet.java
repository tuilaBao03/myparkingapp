package com.smartparking.smartbrain.model;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Currency;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@Table(name = "wallets")
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Wallet {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name = "wallet_id", nullable = false, updatable = false)
	String walletID;

	@Column(nullable = false)
	@NotNull(message = "Balance cannot be null")
	BigDecimal balance = BigDecimal.ZERO;

	@Column(nullable = false)
	@NotNull(message = "Currency cannot be null")
	Currency currency;

	@NotNull(message = "Name of wallet cannot be null")
	String name;

	// Relationship
	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	@NotNull(message = "User cannot be null")
	User user;

	@OneToMany(mappedBy = "wallet", cascade = CascadeType.ALL, orphanRemoval = true)
	Set<Transaction> transactions;
	// Timestamp
	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;
	@UpdateTimestamp
	@Column(name = "updated_at")
	Instant updatedAt;

}
