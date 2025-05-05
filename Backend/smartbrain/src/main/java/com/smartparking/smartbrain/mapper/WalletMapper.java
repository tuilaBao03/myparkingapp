package com.smartparking.smartbrain.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import com.smartparking.smartbrain.dto.request.Wallet.CreateWalletRequest;
import com.smartparking.smartbrain.dto.request.Wallet.UpdateWalletRequest;
import com.smartparking.smartbrain.dto.response.Wallet.WalletResponse;
import com.smartparking.smartbrain.model.Wallet;

@Mapper(componentModel = "spring")
public interface WalletMapper {

	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "transactions", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "user", ignore = true)
	@Mapping(target = "walletID", ignore = true)
	@Mapping(target = "currency", ignore = true)
	Wallet toWallet(CreateWalletRequest createWalletRequest);

	@Mapping(target = "balance", ignore = true)
	@Mapping(target = "createdAt", ignore = true)
	@Mapping(target = "transactions", ignore = true)
	@Mapping(target = "updatedAt", ignore = true)
	@Mapping(target = "user", ignore = true)
	@Mapping(target = "walletID", ignore = true)
	@Mapping(target = "currency", ignore = true)
	void updateWalletFromRequest(UpdateWalletRequest updateWalletRequest, @MappingTarget Wallet wallet);

	WalletResponse toWalletResponse(Wallet wallet);
}
