package com.smartparking.smartbrain.config;
import java.time.Instant;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.smartparking.smartbrain.enums.UserStatus;
import com.smartparking.smartbrain.model.Permission;
import com.smartparking.smartbrain.model.Role;
import com.smartparking.smartbrain.model.User;
import com.smartparking.smartbrain.repository.PermissionRepository;
import com.smartparking.smartbrain.repository.RoleRepository;
import com.smartparking.smartbrain.repository.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j

public class ApplicationInitConfig {

    PasswordEncoder passwordEncoder;
    RoleRepository roleRepository;
    PermissionRepository permissionRepository;
    UserRepository userRepository;

    @Bean
    ApplicationRunner applicationRunner() {
        return args -> {
            log.info("Initializing system roles and permissions...");

            // 1. Danh sách các quyền hạn mặc định
            List<String> permissionNames = List.of(
                "user.view", "user.create", "user.update", "user.delete",
                "parkinglot.view", "parkinglot.create", "parkinglot.update", "parkinglot.delete",
                "booking.view", "booking.create", "booking.cancel",
                "invoice.view", "invoice.refund",
                "wallet.view", "wallet.topup", "wallet.withdraw","wallet.transfer",
                "review.view", "review.delete", "comment.moderate", "review.create"
            );
            List<String> userPermissions = List.of(
                "booking.view", "booking.create", "booking.cancel",
                "invoice.view",
                "wallet.view", "wallet.topup", "wallet.withdraw", "wallet.transfer",
                "review.create", "review.view"
            );

            //2. Danh sách các role mặc định
            List<String> roleNames = List.of(
                "ADMIN", "USER", "PARKING_OWNER", "STAFF"
            );
            // 3. Tạo Role nếu chưa tồn tại
            roleNames.forEach(roleName -> {
                roleRepository.findById(roleName)
                    .orElseGet(() -> {
                        Role role = Role.builder()
                            .roleName(roleName)
                            .description("Role for " + roleName)
                            .build();
                        return roleRepository.save(role);
                    });
            });

            // 4. Tạo Permission nếu chưa tồn tại
            List<Permission> permissions = permissionNames.stream()
                .map(name -> permissionRepository.findById(name)
                    .orElseGet(() -> {
                        Permission permission = Permission.builder()
                            .permissionName(name)
                            .description("Permission for " + name)
                            .build();
                        return permissionRepository.save(permission);
                    }))
                .toList();
            log.info("Permissions initialized successfully!");
            // 4. Tạo Role ADMIN nếu chưa có
            Role adminRole = roleRepository.findById("ADMIN")
                .orElseGet(() -> {
                    Role role = Role.builder()
                        .roleName("ADMIN")
                        .description("Administrator Role")
                        .permissions(new HashSet<>(
                            permissions)) // Gán full quyền
                        .build();
                    return roleRepository.save(role);
                });
            log.info("Role 'ADMIN' initialized successfully!");
            // 5. Tạo Role USER và set quyền nếu chưa có
            Set<Permission> userPermissionSet = permissions.stream()
            .filter(p -> userPermissions.contains(p.getPermissionName()))
            .collect(Collectors.toSet());

            Role userRole = roleRepository.findById("USER")
            .orElseGet(() -> {
                Role role = Role.builder()
                .roleName("USER")
                .description("User Role")
                .permissions(new HashSet<>(userPermissionSet)) // Gán quyền ngay từ đầu
                .build();
                return roleRepository.save(role);
            });

            // Cập nhật lại permission nếu Role đã tồn tại
            userRole.setPermissions(userPermissionSet);
            roleRepository.save(userRole); // Lưu lại với danh sách permission mới

            log.info("Role 'USER' initialized successfully!");

            // 6. Kiểm tra xem user 'admin1' đã tồn tại chưa
            boolean userExists = userRepository.existsByUsername("admin1");
            if (!userExists) {
                log.warn("Admin user not found! Creating default admin user...");

                Set<Role> roles = new HashSet<>();
                roles.add(adminRole);

                User user = User.builder()
                    .username("admin1")
                    .password(passwordEncoder.encode("admin1"))
                    .roles(roles)
                    .firstName("Admin")
                    .lastName("User")
                    .email("admin@example.com")
                    .phone("1234567890")
                    .homeAddress("123 Admin St.")
                    .companyAddress("123 Admin St.")
                    .createdAt(Instant.now())
                    .updatedAt(Instant.now())
                    .status(UserStatus.ACTIVE)
                    .build();

                userRepository.save(user);
                log.warn("Default admin user 'admin1' has been created!");
            } else {
                log.info("User 'admin1' already exists. Skipping creation.");
            }
        };
    }
}

