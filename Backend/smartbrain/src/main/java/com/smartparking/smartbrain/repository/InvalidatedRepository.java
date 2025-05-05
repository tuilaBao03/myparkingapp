package com.smartparking.smartbrain.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smartparking.smartbrain.model.InvalidToken;

@Repository
public interface InvalidatedRepository extends JpaRepository<InvalidToken, String> {
}
