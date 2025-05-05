package com.smartparking.smartbrain.model;
import java.time.Instant;
import java.util.Set;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.smartparking.smartbrain.enums.LotStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;


@Entity
@Getter
@Table(name = "parking_lots")
@Setter
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ParkingLot {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "parking_lot_id", nullable = false, updatable = false)
    String parkingLotID;

    String parkingLotName;
    String address;
    double latitude;   // Kinh độ
    double longitude;  // Vĩ độ

    int totalSlot;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false,columnDefinition = "varchar(255) default 'ON'")
    LotStatus status;
    @Column(columnDefinition = "double precision default 5",nullable = false)
    Double rate;
    String description;

    // Định nghĩa quan hệ ManyToOne
	@ManyToOne(fetch = FetchType.LAZY)
	@JsonIgnore
	@JoinColumn(name = "user_id", nullable = false) // Tên cột trong cơ sở dữ liệu
	User user;
    @OneToMany(mappedBy = "parkingLot",fetch = FetchType.LAZY)
    @JsonIgnore
    Set<ParkingSlot> parkingSlots;
    @OneToMany(mappedBy = "parkingLot",fetch = FetchType.LAZY)
    @JsonIgnore
    Set<Image> images;
    @OneToMany(mappedBy="parkingLot",fetch = FetchType.LAZY)
    @JsonIgnore
    Set<Discount> discounts;
    @OneToMany(mappedBy = "parkingLot",fetch = FetchType.LAZY)
    @JsonIgnore
    Set<Rating> ratings;

    // Timestamp
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    Instant createdAt;
    @UpdateTimestamp
    @Column(name = "updated_at")
    Instant updatedAt;
}
