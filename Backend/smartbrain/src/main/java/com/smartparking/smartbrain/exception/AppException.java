package com.smartparking.smartbrain.exception;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AppException extends RuntimeException {
	public AppException(ErrorCode errorCode) {
		super(errorCode.getMessage());
		this.errorCode = errorCode;
	}

	public AppException(ErrorCode errorCode, String message) {
		super(message); // Dùng message cụ thể từ introspect()
		this.errorCode = errorCode;
	}

	private ErrorCode errorCode;

}
