package com.smartparking.smartbrain.encoder;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class AESEncryption {

	private static final String ALGORITHM = "AES";

	// Tạo SecretKey từ signerKey (Băm SHA-256 để lấy đúng 32 byte)
	private static SecretKeySpec getSecretKey(String signerKey) throws Exception {
		MessageDigest sha = MessageDigest.getInstance("SHA-256");
		byte[] keyBytes = sha.digest(signerKey.getBytes(StandardCharsets.UTF_8));
		return new SecretKeySpec(keyBytes, ALGORITHM);
	}

	// Mã hóa object thành chuỗi
	public static String encryptObject(Object obj, String signerKey) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper()
				.registerModule(new JavaTimeModule())
				.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS); // Hỗ trợ Java 8 Date/Time
		logObject("This object is", obj);
		String json = objectMapper.writeValueAsString(obj); // Chuyển object thành JSON
		return encrypt(json, signerKey);
	}

	// Giải mã chuỗi thành object
	public static <T> T decryptObject(String encryptedData, String signerKey, Class<T> clazz) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper()
				.registerModule(new JavaTimeModule())
				.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
		String decryptedJson = decrypt(encryptedData, signerKey);
		log.info("The object after decrypt: {}", decryptedJson);
		return objectMapper.readValue(decryptedJson, clazz);
	}

	// Hàm mã hóa chuỗi
	public static String encrypt(String data, String signerKey) throws Exception {
		SecretKeySpec secretKey = getSecretKey(signerKey);
		Cipher cipher = Cipher.getInstance(ALGORITHM);
		cipher.init(Cipher.ENCRYPT_MODE, secretKey);
		byte[] encryptedData = cipher.doFinal(data.getBytes(StandardCharsets.UTF_8));
		return Base64.getEncoder().encodeToString(encryptedData);
	}

	// Hàm giải mã chuỗi
	public static String decrypt(String encryptedData, String signerKey) throws Exception {
		try {
			log.info("Encrypted data received: {}", encryptedData);
			SecretKeySpec secretKey = getSecretKey(signerKey);
			Cipher cipher = Cipher.getInstance(ALGORITHM);
			cipher.init(Cipher.DECRYPT_MODE, secretKey);

			byte[] decodedBytes = Base64.getDecoder().decode(encryptedData);
			log.info("Decoded bytes: {}", Arrays.toString(decodedBytes));

			String decryptedString = new String(cipher.doFinal(decodedBytes), StandardCharsets.UTF_8);
			log.info("Decrypted string: {}", decryptedString);
			return decryptedString;
		} catch (Exception e) {
			log.error("Decryption failed! Error: ", e);
			throw e; // Bắn lại exception để debug
		}
	}

	public static void logObject(String message, Object object) {
		ObjectMapper objectMapper = new ObjectMapper()
				.registerModule(new JavaTimeModule())
				.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
		try {
			String json = objectMapper.writeValueAsString(object);
			log.info("{}: {}", message, json);
		} catch (Exception e) {
			log.error("Error serializing object: {}", e.getMessage());
		}
	}

	public static String hashToUUID(String input) {
		try {
			input = input + "parkingappBCP";
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hashBytes = digest.digest(input.getBytes(StandardCharsets.UTF_8));
			String hex = bytesToHex(hashBytes);

			// Format thành UUID
			return String.format("%s-%s-%s-%s-%s",
					hex.substring(0, 8),
					hex.substring(8, 12),
					hex.substring(12, 16),
					hex.substring(16, 20),
					hex.substring(20, 32));
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}
	}

	private static String bytesToHex(byte[] bytes) {
		StringBuilder sb = new StringBuilder();
		for (byte b : bytes) {
			sb.append(String.format("%02x", b));
		}
		return sb.toString();
	}

}
