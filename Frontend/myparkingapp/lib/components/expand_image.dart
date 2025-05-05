import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showImageDialog(BuildContext context, String url) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Cho dialog trong suốt xung quanh
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            url,
            width: Get.width / 1.2,
            height: Get.width / 2,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/big_1.png',
                width: Get.width / 1.2,
                height: Get.width / 2,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      );
    },
  );
}
