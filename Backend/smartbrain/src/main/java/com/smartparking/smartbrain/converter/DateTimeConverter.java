package com.smartparking.smartbrain.converter;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

import org.mapstruct.Named;
import org.springframework.stereotype.Component;

@Component
public class DateTimeConverter {

	private static final List<DateTimeFormatter> SUPPORTED_FORMATS = List.of(
			DateTimeFormatter.ofPattern("dd/MM/yyyy"),
			DateTimeFormatter.ofPattern("yyyy-MM-dd"),
			DateTimeFormatter.ofPattern("yyyy/MM/dd"),
			DateTimeFormatter.ofPattern("MM-dd-yyyy"),
			DateTimeFormatter.ofPattern("MM/dd/yyyy"),
			DateTimeFormatter.ofPattern("dd-MM-yyyy"),
			DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"),
			DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS"),
			DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss"),
			DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"),
			DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"),
			DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss"),
			DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS"),
			DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSSSS"),
			DateTimeFormatter.ISO_INSTANT);

	@Named("fromStringToInstant")
	public Instant fromStringToInstant(String dateStr) {
		for (DateTimeFormatter formatter : SUPPORTED_FORMATS) {
			try {
				if (formatter == DateTimeFormatter.ISO_INSTANT) {
					return Instant.parse(dateStr); // ISO_INSTANT phải dùng parse của Instant
				} else if (dateStr.contains("T")) {
					return LocalDateTime.parse(dateStr, formatter)
							.atZone(ZoneId.of("UTC")).toInstant();
				} else {
					return LocalDate.parse(dateStr, formatter)
							.atStartOfDay(ZoneId.of("UTC")).toInstant();
				}
			} catch (DateTimeParseException ignored) {
			}
		}
		throw new RuntimeException("Invalid date format: " + dateStr);
	}

	@Named("fromInstantToString")
	public String fromInstantToString(Instant instant) {
		return instant == null ? null
				: DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss")
						.format(instant.atZone(ZoneId.of("UTC")));
	}
}
