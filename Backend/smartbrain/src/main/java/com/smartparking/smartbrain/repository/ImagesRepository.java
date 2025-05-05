package com.smartparking.smartbrain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.Image;

@Repository
public interface ImagesRepository extends JpaRepository<Image, String> {
	Optional<Image> findByUser_UserID(String userID);

	Optional<List<Image>> findByParkingLot_ParkingLotID(String parkingLotID);
}