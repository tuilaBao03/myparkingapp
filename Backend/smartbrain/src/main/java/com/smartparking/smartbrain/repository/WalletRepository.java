package com.smartparking.smartbrain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.model.Wallet;

public interface WalletRepository extends JpaRepository<Wallet, String> {
	List<Wallet> findByUser(User user);

	@EntityGraph(attributePaths = { "user" })
	@Query("SELECT w FROM Wallet w WHERE w.walletID = :walletID")
	Optional<Wallet> findByIdWithUser(@Param("walletID") String walletID);
}
