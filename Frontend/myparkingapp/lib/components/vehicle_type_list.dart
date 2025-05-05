import 'package:flutter/material.dart';
import '../components/small_dot.dart';

import '../constants.dart';

class VehicleTypeList extends StatelessWidget {
  const VehicleTypeList({
    super.key,
    this.priceRange = "\$\$",
    required this.typeList,
  });

  final String priceRange;
  final List<String> typeList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(priceRange, style: Theme.of(context).textTheme.bodyMedium),
        ...List.generate(
          typeList.length,
          (index) => Row(
            children: [
              buildSmallDot(),
              Text(typeList[index],
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Padding buildSmallDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      child: SmallDot(),
    );
  }
}
