// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../rating.dart';
import '../../small_dot.dart';

class ServiceInfoMediumCard extends StatelessWidget {
  const ServiceInfoMediumCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.version,
    required this.press, // Thêm hành động khi nhấn
  });

  final String image, name, description;
  final double version; // Nếu muốn String thì sửa thành String
  final VoidCallback press; // Hàm callback điều hướng

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press, // Gọi hàm khi nhấn
      borderRadius: BorderRadius.circular(10), // Thêm hiệu ứng bo góc khi nhấn
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300], // Ảnh lỗi sẽ có nền xám
                    child: const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: defaultPadding / 4),
            Text(
              description,
              maxLines: 2, // Cho phép tối đa 2 dòng mô tả
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Rating(rating: version), // Hiển thị rating
                const SizedBox(width: 4),
                const SmallDot(), // Dot trang trí (tuỳ ý)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
