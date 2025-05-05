package com.smartparking.smartbrain.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "invoiceQR")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InvoiceQR {
    @Id
    String invoiceID;
    @Column(columnDefinition = "TEXT")
    String objectToken;
    boolean isActive;
}
