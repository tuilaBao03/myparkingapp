package com.smartparking.smartbrain.controller;

import org.springframework.web.bind.annotation.*;

import com.smartparking.smartbrain.dto.response.ApiResponse;
import com.smartparking.smartbrain.dto.response.PagedResponse;
import com.smartparking.smartbrain.dto.response.Wallet.TransactionResponse;
import com.smartparking.smartbrain.service.TransactionService;

import jakarta.websocket.server.PathParam;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

import org.springframework.data.domain.PageRequest;

@RestController
@RequestMapping("/myparkingapp/transactions")
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class TransactionController {
    TransactionService transactionService;

    @GetMapping("/user/{userID}")
    public ApiResponse<PagedResponse<TransactionResponse>> getAllTransactionByUser(
            @PathVariable String userID,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "1000") int size) {
        PagedResponse<TransactionResponse> response = transactionService
                .getTransactionByUser(userID, PageRequest.of(page, size));
        return ApiResponse.<PagedResponse<TransactionResponse>>builder()
                .code(200)
                .result(response)
                .message("Parking lots retrieved successfully")
                .build();
    }
    @GetMapping("/all")
    public ApiResponse<PagedResponse<TransactionResponse>> getAllTransaction(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "1000") int size,
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam String type
            ) {
        PagedResponse<TransactionResponse> response = transactionService
                .getAllTransaction(startDate,endDate,type,PageRequest.of(page, size));
        return ApiResponse.<PagedResponse<TransactionResponse>>builder()
                .code(200)
                .result(response)
                .message("Parking lots retrieved successfully")
                .build();
    }

    @GetMapping("/date")
    public ApiResponse<PagedResponse<TransactionResponse>> getAllTransactionByDate(
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "1000") int size) {
        PagedResponse<TransactionResponse> response = transactionService
                .getTransactionByTime(startDate, endDate, PageRequest.of(page, size));

        return ApiResponse.<PagedResponse<TransactionResponse>>builder()
                .code(200)
                .result(response)
                .message("Parking lots retrieved successfully")
                .build();
    }

    @GetMapping("/wallet/{walletID}")
    public ApiResponse<PagedResponse<TransactionResponse>> getAllTransactionByWallet(
            @PathVariable String walletID,
            @RequestParam String type,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "1000") int size) {
        PagedResponse<TransactionResponse> response = transactionService
                .getTransactionByWallet(walletID,type, PageRequest.of(page, size));

        return ApiResponse.<PagedResponse<TransactionResponse>>builder()
                .code(200)
                .result(response)
                .message("Parking lots retrieved successfully")
                .build();
    }
}
