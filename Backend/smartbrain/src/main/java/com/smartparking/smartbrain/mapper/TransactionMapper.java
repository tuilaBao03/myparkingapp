package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.smartparking.smartbrain.dto.response.Wallet.TransactionResponse;
import com.smartparking.smartbrain.model.Transaction;

@Mapper(componentModel = "spring")
public interface TransactionMapper {
    @Mapping(target = "currentBalance", source = "wallet.balance")
    @Mapping(target = "timestamp", source = "createdAt")
    @Mapping(target = "walletID", source = "wallet.walletID")
    TransactionResponse toTransactionResponse(Transaction transaction);
}
