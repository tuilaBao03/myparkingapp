package com.smartparking.smartbrain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.enums.InvoiceStatus;
import com.smartparking.smartbrain.model.Invoice;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoice,String> {

    Page<Invoice> findByUser_UserID(String userID, Pageable pageable);
    @Query(value = "SELECT * FROM invoices WHERE user_id = :userId AND status = 'DEPOSIT'", nativeQuery = true)
    Page<Invoice> findUnpaidInvoicesByUser(@Param("userId") String userId, Pageable pageable);
    @EntityGraph() // Không fetch quan hệ nào
    @Query("SELECT i FROM Invoice i WHERE i.invoiceID = :invoiceID")
    Optional<Invoice> findByIdWithoutRelations(@Param("invoiceID") String invoiceID);
    @Modifying
    @Query("UPDATE Invoice s SET s.status = :status WHERE s.invoiceID = :id")
    void updateInvoiceStatus(@Param("id") String invoiceID, @Param("status") InvoiceStatus status);
    
    @Query(
    value = """
        SELECT i.*
        FROM invoices i
        LEFT JOIN monthly_tickets m ON i.invoice_id = m.invoice_id
        WHERE i.user_id = :userID
        AND i.status IN ('DEPOSIT', 'PAID')
        AND (
                (
                    m.started_at <= NOW()
                    AND m.expired_at >= NOW()
                )
                OR (
                    m.invoice_id IS NULL
                    AND DATE(i.created_at) = CURRENT_DATE
                )
        )
        """,
    nativeQuery = true
    )
    List<Invoice> findAllActiveInvoiceByUser(@Param("userID") String userID);

    @Query("SELECT i FROM Invoice i WHERE i.parkingSlot.parkingLot.parkingLotID = :parkingLotId")
    List<Invoice> findAllInvoiceByParkingLotId(@Param("parkingLotId") String parkingLotId);

}
