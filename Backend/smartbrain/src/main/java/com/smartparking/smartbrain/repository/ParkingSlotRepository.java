package com.smartparking.smartbrain.repository;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.enums.SlotStatus;
import com.smartparking.smartbrain.model.ParkingSlot;

@Repository
public interface ParkingSlotRepository extends JpaRepository<ParkingSlot, String> {

	List<ParkingSlot> findByParkingLot_ParkingLotID(String parkingLotID);

	@EntityGraph(attributePaths = {}) // Không fetch quan hệ nào
	@Query("SELECT p FROM ParkingSlot p WHERE p.slotID = :slotID")
	Optional<ParkingSlot> findParkingSlotWithoutRelations(@Param("slotID") String slotID);

	@Query("""
			    SELECT DISTINCT s FROM ParkingSlot s
			    LEFT JOIN FETCH s.invoices i
			    WHERE s.slotStatus = 'RESERVED'
			    AND EXISTS (
			        SELECT inv FROM Invoice inv
			        WHERE inv MEMBER OF s.invoices AND inv.status = 'DEPOSIT'
			    )
			    AND s.createdAt <= :threshold
			""")
	List<ParkingSlot> findExpiredReservedSlots(@Param("threshold") Instant threshold);

	@Modifying
	@Query("UPDATE ParkingSlot s SET s.slotStatus = :status WHERE s.id = :id")
	void updateSlotStatus(@Param("id") String id, @Param("status") SlotStatus status);

}
