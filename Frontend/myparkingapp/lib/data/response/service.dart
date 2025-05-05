import 'package:flutter/material.dart';

class Service {
  final String image;
  final String name;
  final String description;
  final double version;
  final VoidCallback press; // Sự kiện nhấn, dùng để Navigator.push

  Service({
    required this.image,
    required this.name,
    required this.description,
    required this.version,
    required this.press, // Bắt buộc truyền function khi khởi tạo
  });
}


