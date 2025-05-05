package com.smartparking.smartbrain.service;

import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.smartparking.smartbrain.converter.DateTimeConverter;
import com.smartparking.smartbrain.dto.response.PagedResponse;
import com.smartparking.smartbrain.dto.response.Wallet.TransactionResponse;
import com.smartparking.smartbrain.enums.TransactionType;
import com.smartparking.smartbrain.exception.AppException;
import com.smartparking.smartbrain.exception.ErrorCode;
import com.smartparking.smartbrain.mapper.TransactionMapper;
import com.smartparking.smartbrain.repository.TransactionRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class TransactionService {
    TransactionMapper transactionMapper;
    TransactionRepository transactionRepository;
    DateTimeConverter dateTimeConverter;

    public PagedResponse<TransactionResponse> getTransactionByUser(String userID, Pageable pageable) {
        var page = transactionRepository.findAllByUser_UserID(userID, pageable);

        if (page.isEmpty()) {
            throw new AppException(ErrorCode.TRANSACTION_NOT_FOUND);
        }
        // convert page to TransactionResponse by transactionMapper
        List<TransactionResponse> content = page.getContent().stream()
                .map(transactionMapper::toTransactionResponse).collect(Collectors.toList());

        return new PagedResponse<>(
                content,
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.isLast());
    }

    public PagedResponse<TransactionResponse> getAllTransaction(String from,String to, String type,Pageable pageable) {
        Instant startDate;
        Instant endDate;
        try {
            startDate = dateTimeConverter.fromStringToInstant(from);
            endDate = dateTimeConverter.fromStringToInstant(to);
        } catch (Exception e) {
            throw new AppException(ErrorCode.INVALID_DATE_TIME_FORMAT);
        }
        if (type == null) {
            throw new AppException(ErrorCode.TRANSACTION_TYPE_NOT_EXIST);
        }
        TransactionType transactionType = TransactionType.valueOf(type);
        var page = transactionRepository.findAllByTimeAndType(startDate,endDate,transactionType,pageable);

        if (page.isEmpty()) {
            throw new AppException(ErrorCode.TRANSACTION_NOT_FOUND);
        }
        // convert page to TransactionResponse by transactionMapper
        List<TransactionResponse> content = page.getContent().stream()
                .map(transactionMapper::toTransactionResponse).collect(Collectors.toList());

        return new PagedResponse<>(
                content,
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.isLast());
    }

    public PagedResponse<TransactionResponse> getTransactionByTime(String from, String to, Pageable pageable) {
        Instant startDate;
        Instant endDate;
        try {
            startDate = dateTimeConverter.fromStringToInstant(from);
            endDate = dateTimeConverter.fromStringToInstant(to);
        } catch (Exception e) {
            throw new AppException(ErrorCode.INVALID_DATE_TIME_FORMAT);
        }
        var page = transactionRepository.findTransactionByTime(startDate, endDate, pageable);

        if (page.isEmpty()) {
            throw new AppException(ErrorCode.TRANSACTION_NOT_FOUND);
        }
        // convert page to TransactionResponse by transactionMapper
        List<TransactionResponse> content = page.getContent().stream()
                .map(transactionMapper::toTransactionResponse).collect(Collectors.toList());

        return new PagedResponse<>(
                content,
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.isLast());
    }

    public PagedResponse<TransactionResponse> getTransactionByWallet(String walletID, String type, Pageable pageable) {
        if (type == null) {
            throw new AppException(ErrorCode.TRANSACTION_TYPE_NOT_EXIST);
        }
        TransactionType transactionType = TransactionType.valueOf(type);
        var page = transactionRepository.findAllByWallet_WalletIDAndType(walletID, transactionType, pageable);

        if (page.isEmpty()) {
            throw new AppException(ErrorCode.TRANSACTION_NOT_FOUND);
        }
        // convert page to TransactionResponse by transactionMapper
        List<TransactionResponse> content = page.getContent().stream()
                .map(transactionMapper::toTransactionResponse).collect(Collectors.toList());

        return new PagedResponse<>(
                content,
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.isLast());
    }
}
