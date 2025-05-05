import 'package:flutter/material.dart';

class PaginationButtons extends StatelessWidget {
  final int page; // Trang hiện tại
  final int pageTotal; // Tổng số trang
  final Function(int) onPageChanged; // Hàm callback khi đổi trang

  const PaginationButtons({
    super.key,
    required this.page,
    required this.pageTotal,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nút trang trước
        IconButton(
          onPressed: page > 1 ? () => onPageChanged(page - 1) : null,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        // Số trang hiện tại / tổng số trang
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Trang $page / $pageTotal',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        // Nút trang tiếp theo
        IconButton(
          onPressed: page < pageTotal ? () => onPageChanged(page + 1) : null,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
