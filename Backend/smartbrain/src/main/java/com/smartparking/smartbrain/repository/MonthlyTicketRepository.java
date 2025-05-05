package com.smartparking.smartbrain.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.MonthlyTicket;

@Repository
public interface MonthlyTicketRepository extends JpaRepository<MonthlyTicket, String> {

	@Query("""
			    SELECT m FROM MonthlyTicket m
			    WHERE m.parkingSlot.slotID = :slotID
			    AND EXTRACT(YEAR FROM m.startedAt) = :year
			    AND EXTRACT(MONTH FROM m.startedAt) = :month
			""")
	List<MonthlyTicket> findAllByParkingSlot_SlotIDAndMonth(String slotID, int year, int month);

	@Query("SELECT m FROM MonthlyTicket m " +
			"WHERE FUNCTION('YEAR', m.startedAt) = :year " +
			"AND FUNCTION('MONTH', m.startedAt) = :month")
	List<MonthlyTicket> findAllByMonth(@Param("year") int year, @Param("month") int month);

}
