package com.smartparking.smartbrain.repository;

import com.smartparking.smartbrain.model.InvoiceQR;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface InvoiceQRRepository extends JpaRepository<InvoiceQR, String> {
    Optional<InvoiceQR> findByInvoiceIDAndIsActiveTrue(String invoiceID);
}
