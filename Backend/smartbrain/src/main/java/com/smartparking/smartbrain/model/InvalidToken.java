package com.smartparking.smartbrain.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "invalid_tokens")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InvalidToken {
	@Id
	@Column(name = "token_id")
	String tokenID;
	Date expiryTime;
}
