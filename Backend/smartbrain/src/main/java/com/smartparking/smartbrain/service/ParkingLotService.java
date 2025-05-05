package com.smartparking.smartbrain.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.dto.request.Image.CreatedImageForParkingLotRequest;
import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.request.ParkingLot.LocationConfig;
import com.smartparking.smartbrain.dto.request.ParkingLot.VehicleSlotConfig;
import com.smartparking.smartbrain.dto.response.PagedResponse;
import com.smartparking.smartbrain.dto.response.ParkingLot.ParkingLotResponse;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.ParkingLotMapper;
import com.smartparking.smartbrain.model.Image;
import com.smartparking.smartbrain.model.ParkingSlot;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.ImagesRepository;
import com.smartparking.smartbrain.repository.ParkingLotRepository;
import com.smartparking.smartbrain.repository.ParkingSlotRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ParkingLotService {

    ParkingLotRepository parkingLotRepository;
    ParkingLotMapper parkingLotMapper;
    UserRepository userRepository;
    ImagesRepository imagesRepository;
    ParkingSlotRepository parkingSlotRepository;

    public ParkingLotResponse createParkingLot(@Valid CreatedParkingLotRequest createdParkingLotRequest) {
        // check user exist
        User user = userRepository.findById(createdParkingLotRequest.getUserID())
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        var parkingLot = parkingLotMapper.toParkingLot(createdParkingLotRequest);
        parkingLot.setUser(user);
        parkingLotRepository.save(parkingLot);

        // create list of image and save to database
        CreatedImageForParkingLotRequest imagesRequest = createdParkingLotRequest.getImages();
        List<String> imageIDs = imagesRequest.getImageIDs();
        List<String> imageURLs = imagesRequest.getImageURLs();

        // Optional: Validate input
        if (imageIDs == null || imageURLs == null || imageIDs.size() != imageURLs.size()) {
            throw new IllegalArgumentException("Image IDs and URLs must be non-null and of the same size");
        }

        Set<Image> images = new HashSet<>();
        for (int i = 0; i < imageIDs.size(); i++) {
            Image image = new Image();
            image.setImagesID(imageIDs.get(i));
            image.setUrl(imageURLs.get(i));
            image.setParkingLot(parkingLot);
            images.add(image);
        }

        imagesRepository.saveAll(images);
        parkingLot.setImages(images);

        // create list of slot and save to database

        for (LocationConfig location : createdParkingLotRequest.getLocationConfigs()) {
            AtomicInteger slotCounter = new AtomicInteger(0); // Reset số đếm theo từng Location
            for (VehicleSlotConfig vehicleSlotConfig : location.getVehicleSlotConfigs()) {
                int numSlots = vehicleSlotConfig.getNumberOfSlot(); // Số lượng slot cho loại xe này
                for (int i = 0; i < numSlots; i++) {
                    // Định dạng số slot theo A00, A01, ..., A99 rồi tiếp tục A100 nếu cần
                    String slotName = String.format("%s%02d", "(" + location.getLocation() + ")",
                            slotCounter.getAndIncrement());
                    ParkingSlot parkingSlot = ParkingSlot.builder()
                            .slotName(slotName)
                            .parkingLot(parkingLot)
                            .pricePerHour(vehicleSlotConfig.getPricePerHour())
                            .pricePerMonth(vehicleSlotConfig.getPricePerMonth())
                            .vehicleType(vehicleSlotConfig.getVehicleType())
                            .build();
                    parkingSlotRepository.save(parkingSlot);
                }
            }
        }

        // create reponse
        ParkingLotResponse response = parkingLotMapper.toParkingLotResponse(parkingLot);
        response.setUserID(parkingLot.getUser().getUserID());
        return response;
    }

    public ParkingLotResponse getParkingLotByID(String parkingLotID) {
        var parkingLot = parkingLotRepository.findById(parkingLotID)
                .orElseThrow(() -> new AppException(ErrorCode.PARKING_LOT_NOT_FOUND));
        ParkingLotResponse response = parkingLotMapper.toParkingLotResponse(parkingLot);
        response.setUserID(parkingLot.getUser().getUserID());
        return response;
    }

    public List<ParkingLotResponse> getAllParkingLot() {

        return parkingLotRepository.findAll().stream().map(parkingLot -> {
            ParkingLotResponse response = parkingLotMapper.toParkingLotResponse(parkingLot);
            response.setUserID(parkingLot.getUser().getUserID());
            return response;
        }).collect(Collectors.toList());
    }

    public void deleteParkingLot(String parkingLotID) {
        if (!parkingLotRepository.existsById(parkingLotID)) {
            throw new AppException(ErrorCode.PARKING_LOT_NOT_EXISTS);
        }
        parkingLotRepository.deleteById(parkingLotID);
    }

    public PagedResponse<ParkingLotResponse> findByParkingLotName(String name, Pageable pageable) {
        var page = parkingLotRepository.searchByParkingLotName(name, pageable);

        if (page.isEmpty()) {
            throw new AppException(ErrorCode.PARKING_LOT_NOT_FOUND);
        }

        List<ParkingLotResponse> content = page.getContent().stream()
                .map(parkingLot -> {
                    ParkingLotResponse response = parkingLotMapper.toParkingLotResponse(parkingLot);
                    response.setUserID(parkingLot.getUser().getUserID());
                    return response;
                }).collect(Collectors.toList());

        return new PagedResponse<>(
                content,
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.isLast());
    }

    public List<ParkingLotResponse> findNearestParkingLot(double lat, double lon) {
        var parkingLotList = parkingLotRepository.findNearestParkingLots(lat, lon);
        if (parkingLotList.isEmpty()) {
            throw new AppException(ErrorCode.PARKING_LOT_NOT_FOUND);
        }
        return parkingLotList.stream().map(parkingLot -> {
            ParkingLotResponse response = parkingLotMapper.toParkingLotResponse(parkingLot);
            response.setUserID(parkingLot.getUser().getUserID());
            return response;
        }).collect(Collectors.toList());
    }

    public PagedResponse<ParkingLotResponse> getAllParkingLot(Pageable pageable) {
        var parkingLotPage = parkingLotRepository.findAllPage(pageable);
        List<ParkingLotResponse> parkingLotResponses = parkingLotPage.getContent().stream()
                .map(parkingLot -> {
                    ParkingLotResponse response = parkingLotMapper.toParkingLotResponse(parkingLot);
                    response.setUserID(parkingLot.getUser().getUserID());
                    return response;
                })
                .collect(Collectors.toList());
        return new PagedResponse<>(parkingLotResponses, parkingLotPage.getNumber(), parkingLotPage.getSize(),
                parkingLotPage.getTotalElements(), parkingLotPage.getTotalPages(), parkingLotPage.isLast());
    }
    public  List<ParkingLotResponse> findByUserID(String userID) {
        var parkingLots= parkingLotRepository.findByUser_UserID(userID);
        if (parkingLots.isEmpty()) {
            throw new AppException(ErrorCode.PARKING_LOT_NOT_FOUND);
        }
        return parkingLots.stream().map(parkingLot -> {
            ParkingLotResponse response = parkingLotMapper.toParkingLotResponse(parkingLot);
            response.setUserID(parkingLot.getUser().getUserID());
            return response;
        }).collect(Collectors.toList());
    }

}
