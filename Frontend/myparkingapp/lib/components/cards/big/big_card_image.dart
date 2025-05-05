import 'package:flutter/material.dart';

class BigCardImage extends StatelessWidget {
  const BigCardImage({
    super.key,
    required this.image,
    required this.isBanner
  });

  final String image;
  final bool isBanner;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: !isBanner ? Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/featured _items_1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
      ): Image. asset(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      )
      ,
    );
  }
}
