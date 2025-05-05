package com.smartparking.smartbrain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Discount;

@Repository
public interface DiscountRepository extends JpaRepository<Discount, String> {
	List<Discount> findAllByParkingLot_ParkingLotID(String parkingLotID);

	List<Discount> findByParkingLotIsNull();

	Optional<Discount> findByDiscountCode(String discountCode);

	boolean existsByDiscountCode(String discountCode);

	@EntityGraph(attributePaths = {}) // Không fetch quan hệ nào
	@Query("SELECT d FROM Discount d WHERE d.discountID = :discountID")
	Optional<Discount> findDiscountWithoutRelations(@Param("discountID") String discountID);

}
