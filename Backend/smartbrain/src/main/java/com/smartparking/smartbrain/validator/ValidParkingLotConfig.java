package com.smartparking.smartbrain.validator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = ParkingLotValidator.class)
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidParkingLotConfig {
    String message() default "Invalid slot configuration: Total slots mismatch.";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
