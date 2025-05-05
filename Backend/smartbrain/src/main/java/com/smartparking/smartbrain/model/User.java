package com.smartparking.smartbrain.model;

import java.time.Instant;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.smartparking.smartbrain.enums.UserStatus;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@Entity
@Table(name = "users")
@ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name = "user_id", nullable = false, updatable = false)
	String userID;

	@Column(unique = true, nullable = false)
	@NotNull(message = "Username cannot be null")
	@Size(min = 3, max = 50, message = "Username must be between 3 and 50 characters")
	String username;

	@Column(nullable = false)
	@NotNull(message = "Password cannot be null")
	@Size(min = 8, message = "Password must be at least 8 characters long")
	String password;

	@Column(nullable = false)
	@NotNull(message = "First name cannot be null")
	String firstName;

	@Column(nullable = false)
	@NotNull(message = "Last name cannot be null")
	String lastName;

	@Column(unique = true, nullable = false)
	@Email(message = "Email should be valid")
	@NotNull(message = "Email cannot be null")
	String email;
	@Column(unique = true, nullable = false)
	String phone;
	String homeAddress;
	String companyAddress;

	@Column(nullable = false)
	@Builder.Default
	@Enumerated(EnumType.STRING)
	UserStatus status = UserStatus.ACTIVE;

	// Relationship
	@Column(nullable = false)
	@NotNull(message = "Role cannot be null")
	@JsonIgnore
	// Relationship with Role Many to Many - User can have multiple roles
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "user_roles", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_name"))
	Set<Role> roles;
	@JsonIgnore
	// Relationship One to Many
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY) // if the
																											// user is
																											// deleted
																											// then the
																											// related
																											// info will
																											// be also
																											// deleted
	Set<Wallet> wallets;
	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	Set<Transaction> transactions;
	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	Set<Invoice> invoices;
	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	Set<Vehicle> vehicles;
	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	Set<MonthlyTicket> monthlyTickets;
	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	Set<ParkingLot> parkingLots;
	@JsonIgnore
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	Set<Rating> ratings;
	@JsonIgnore
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	Image image;

	@CreationTimestamp
	@Column(name = "created_at", nullable = false, updatable = false)
	Instant createdAt;
	@UpdateTimestamp
	@Column(name = "updated_at")
	Instant updatedAt;
}
