package com.smartparking.smartbrain.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.ParkingLot;

@Repository
public interface ParkingLotRepository extends JpaRepository<ParkingLot, String> {
    @Query(value = """
    SELECT p.*,
           6371 * acos(
               cos(radians(:lat)) * cos(radians(p.latitude)) *
               cos(radians(p.longitude) - radians(:lon)) +
               sin(radians(:lat)) * sin(radians(p.latitude))
           ) AS distance
    FROM parking_lots p
    ORDER BY distance
    LIMIT 5
""", nativeQuery = true)
    List<ParkingLot> findNearestParkingLots(@Param("lat") double latitude, @Param("lon") double longitude);

    @Query("SELECT p FROM ParkingLot p WHERE p.parkingLotName LIKE %:parkingLotName%")
    Page<ParkingLot> searchByParkingLotName(String parkingLotName, Pageable pageable);
    
    @Query("SELECT p FROM ParkingLot p")
    Page<ParkingLot> findAllPage(Pageable pageable);

   List<ParkingLot> findByUser_UserID(String userID);
}