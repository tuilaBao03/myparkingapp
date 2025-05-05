package com.smartparking.smartbrain.validator;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import com.smartparking.smartbrain.dto.request.ParkingLot.CreatedParkingLotRequest;
import com.smartparking.smartbrain.dto.request.ParkingLot.LocationConfig;
import com.smartparking.smartbrain.dto.request.ParkingLot.VehicleSlotConfig;

public class ParkingLotValidator implements ConstraintValidator<ValidParkingLotConfig, CreatedParkingLotRequest> {

    @Override
    public boolean isValid(CreatedParkingLotRequest request, ConstraintValidatorContext context) {
        if (request == null || request.getLocationConfigs() == null) {
            return true; // Nếu request null, để validator khác xử lý
        }

        int totalLocationSlots = 0;

        for (LocationConfig location : request.getLocationConfigs()) {
            int totalVehicleSlots = 0;

            // Tổng số slot ở mỗi khu vực
            totalLocationSlots += location.getTotalSlot();

            // Tổng số slot theo từng loại xe trong khu vực
            for (VehicleSlotConfig vehicleSlot : location.getVehicleSlotConfigs()) {
                totalVehicleSlots += vehicleSlot.getNumberOfSlot();
            }

            // Kiểm tra tổng slot của từng loại xe có khớp với tổng slot của khu vực không
            if (totalVehicleSlots != location.getTotalSlot()) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate(
                        "Total vehicle slots (" + totalVehicleSlots + ") in location '" + location.getLocation() + 
                        "' does not match total slots in location (" + location.getTotalSlot() + ").")
                        .addConstraintViolation();
                return false;
            }
        }

        // Kiểm tra tổng số slot ở tất cả các khu vực có bằng tổng số slot của bãi không
        if (totalLocationSlots != request.getTotalSlot()) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate(
                    "Total slots in locations (" + totalLocationSlots + ") does not match total slots in the parking lot (" + 
                    request.getTotalSlot() + ").")
                    .addConstraintViolation();
            return false;
        }

        return true;
    }
}
