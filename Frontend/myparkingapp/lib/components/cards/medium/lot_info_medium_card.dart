// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';

import '../../../constants.dart';
import '../../rating.dart';
import '../../small_dot.dart';

class LotInfoMediumCard extends StatelessWidget {
  const LotInfoMediumCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
    required this.gotoTime,
    required this.press, required this.status,

  });

  final String image, name, location;
  final double rating;
  final int gotoTime;
  final VoidCallback press;
  final LotStatus status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.4),
              color: Colors.transparent,
              child: AspectRatio(
                aspectRatio: 1.25,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
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
              location,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Rating(rating: rating),
                Text(
                  "$gotoTime min",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: titleColor.withOpacity(0.74)),
                ),
                const SmallDot(),
                Text(
                  status.name.toString().toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: titleColor.withOpacity(0.74)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
