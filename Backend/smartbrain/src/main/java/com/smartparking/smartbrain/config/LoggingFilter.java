package com.smartparking.smartbrain.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

import java.io.IOException;

@Component
public class LoggingFilter extends OncePerRequestFilter {
    private static final Logger logger = LoggerFactory.getLogger(LoggingFilter.class);
    private static final ObjectWriter prettyPrinter = new ObjectMapper().writerWithDefaultPrettyPrinter();

    @SuppressWarnings("null")
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        long startTime = System.currentTimeMillis();

        // Bọc request & response để đọc được nội dung nhiều lần
        ContentCachingRequestWrapper wrappedRequest = new ContentCachingRequestWrapper(request);
        ContentCachingResponseWrapper wrappedResponse = new ContentCachingResponseWrapper(response);

        // Tiếp tục filter chain
        filterChain.doFilter(wrappedRequest, wrappedResponse);

        // Đọc body từ request
        String requestBody = new String(wrappedRequest.getContentAsByteArray(), wrappedRequest.getCharacterEncoding());
        // Đọc body từ response
        String responseBody = new String(wrappedResponse.getContentAsByteArray(),
                wrappedResponse.getCharacterEncoding());

        long duration = System.currentTimeMillis() - startTime;

        String prettyRequestBody = formatJson(requestBody);
        String prettyResponseBody = formatJson(responseBody);

        logger.info("\nREQUEST: [{} {}]\nBody:\n{}",
                request.getMethod(),
                request.getRequestURI(),
                prettyRequestBody);

        logger.info("\nRESPONSE: [{} {}] \nStatus: {}, Time: {}ms\nBody:\n{}",
                request.getMethod(),
                request.getRequestURI(),
                response.getStatus(),
                duration,
                prettyResponseBody);

        // Rất quan trọng: Ghi body về lại response cho client đọc
        wrappedResponse.copyBodyToResponse();

    }

    public static String formatJson(String json) {
        try {
            Object jsonObj = new ObjectMapper().readValue(json, Object.class);
            return prettyPrinter.writeValueAsString(jsonObj);
        } catch (Exception e) {
            // Nếu không phải JSON (ví dụ text, XML, hoặc malformed JSON), trả về nguyên bản
            return json;
        }
    }

}
