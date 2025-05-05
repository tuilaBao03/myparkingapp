package com.smartparking.smartbrain.exception;

import lombok.Getter;

@Getter
public enum ErrorCode {
    // System errors
    ERROR_NOT_FOUND(1, "Error special"),
    NOT_REFRESH_TOKEN(2, "Not refresh token"),
    NOT_ACCESS_TOKEN(3, "Not access token"),
    INVALID_TOKEN(4, "Invalid token"),
    SLOT_NOT_VALID_WITH_VEHICLE_TYPE(5, "Slot not valid with vehicle type"),
    INVALID_DATE_TIME_FORMAT(6, "Invalid date time format"),

    // User errors
    USER_NOT_FOUND(1001, "User not found"),
    USER_ALREADY_EXISTS(1002, "User already exists"),
    PASSWORD_NOT_MATCH(1003, "Password not match"),
    PASSWORD_NOT_VALID(1004, "Password not valid"),
    INVALID_CREDENTIALS(1005, "Invalid credentials"),
    UNAUTHORIZED(1006, "Unauthorized"),
    INVALID_REQUEST(1007, "Invalid request"),
    INTERNAL_SERVER_ERROR(1008, "Internal server error"),
    USER_NOT_EXISTS(1009, "User not exists"),
    TOKEN_EXPIRED(1010, "Token expired"),
    EMAIL_NOT_FOUND(1011, "Email not found"),

    // ParkingLot errors
    PARKING_LOT_NOT_FOUND(2001, "Parking lot not found"),
    PARKING_LOT_ALREADY_EXISTS(2002, "Parking lot alrealy exitst"),
    PARKING_LOT_NOT_EXISTS(2003, "Parking lot not exists"),
    FALSE_UPDATE_STATUS_LOT(2004, "Updating lot status false"),

    // Image errors
    IMAGE_NOT_FOUND(3001, "Image not found"),
    IMAGE_ALREADY_EXISTS(3002, "Image alrealy exitst"),
    IMAGE_NOT_EXISTS(3003, "Image not exists"),
    IMAGE_UPDATE_STATUS_SLOT(3004, "Updating image status false"),

    // ParkingSlot errors
    PARKING_SLOT_NOT_FOUND(4001, "Slot not found"),
    PARKING_SLOT_ALREADY_EXISTS(4002, "Slot alrealy exitst"),
    PARKING_SLOT_NOT_EXISTS(4003, "Slot not exists"),
    FALSE_UPDATE_STATUS_SLOT(4004, "Updating slot status false"),
    TOTAL_SLOT_EXCEED(4005, "Total slot exceed, can't use auto create slot, please create slot manually"),
    SLOT_NOT_AVAILABLE(4006, "Slot not available"),
    SLOT_ALREADY_RESERVED_THIS_MONTH(4007, "Slot already reserved this month"),

    // Wallet errors
    WALLET_NOT_FOUND(5001, "Wallet not found"),
    INVALID_CURRENCY(5002, "Invalid currency"),
    CURRENCY_MISMATCH(5003, "Currency mismatch"),
    WALLET_NOT_BELONG_TO_USER(5004, "Wallet not belong to user"),
    WALLET_NOT_ENOUGH_MONEY(5005, "Wallet not enough money"),
    INSUFFICIENT_BALANCE(5006, "Insufficient balance"),

    // Permission errors
    PERMISSION_NOT_FOUND(6001, "Permission not found"),
    PERMISSION_ALREADY_EXISTS(6002, "Permission already exists"),
    PERMISSION_NOT_EXISTS(6003, "Permission not exists"),

    // Promotion errors
    DISCOUNT_NOT_FOUND(7001, "Discount not found"),
    DISCOUNT_NOT_EXISTS(7002, "Discount not exists"),
    DISCOUNT_NOT_BELONG_TO_PARKING_SLOT(7003, "Discount not belong to parking slot"),
    // Vehicle errors
    VEHICLE_NOT_FOUND(8001, "Vehicle not found"),
    VEHICLE_ALREADY_EXISTS(8002, "Vehicle already exists"),
    VEHICLE_NOT_EXISTS(8003, "Vehicle not exists"),
    // Role errors
    ROLE_NOT_FOUND(9001, "Role not found"),
    ROLE_ALREADY_EXISTS(9002, "Role already exists"),
    ROLE_NOT_EXISTS(9003, "Role not exists"),
    // Invoice errors
    INVOICE_NOT_FOUND(65, "Invoice not found"),
    INVOICE_ALREADY_EXISTS(66, "Invoice already exists"),
    INVOICE_NOT_EXISTS(67, "Invoice not exists"),
    INVOICE_NOT_DEPOSIT(68, "Invoice not deposit"),
    INVOICE_QR_NOT_EXISTS(69, "Invoice qr not exists"),
    // Transaction errors
    TRANSACTION_NOT_FOUND(129, "Transaction not found"),
    TRANSACTION_ALREADY_EXISTS(130, "Transaction already exists"),
    TRANSACTION_NOT_EXISTS(131, "Transaction not exists"),
    TRANSACTION_TYPE_NOT_EXIST(132, "Transaction type not exists"),
    // Monthly ticket errors
    MONTHLY_TICKET_NOT_FOUND(193, "Monthly ticket not found"),
    MONTHLY_TICKET_ALREADY_EXISTS(194, "Monthly ticket already exists"),
    MONTHLY_TICKET_NOT_EXISTS(195, "Monthly ticket not exists"),
    // Entry
    YOUR_VEHICLE_HAS_LEFT_PARKING_LOT(201,"Your vehicle has left the parking lot"),
    YOUR_VEHICLE_HAS_ENTERED_PARKING_LOT(201,"Your vehicle has entered the parking lot")

;
    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
    final int code;
    final String message;
}
