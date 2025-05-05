
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';


import '../../../constants.dart';


class InforOfParkingLot extends StatelessWidget {
  const InforOfParkingLot({
    super.key,
    required this.info,
  });

  final ParkingLotResponse info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
                padding: EdgeInsets.all(2),
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  
                ),
                child: Image.network(
                  info.images.isEmpty ? "https://i.redd.it/4u7d077sznld1.png" : info.images[0].url!,
                  fit: BoxFit.cover,)
                ),
              
          Text(
            info.parkingLotName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // ProgressLine(
          //   color: info.color,
          //   percentage: info.percentage,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info.status.name.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white70),
                overflow: TextOverflow.ellipsis, // 👈 Hiển thị "..." nếu hết chỗ
                maxLines: 1, // 👈 Giới hạn số dòng là 1
              ),
              // Text(
              //   info.totalStorage!,
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodySmall!
              //       .copyWith(color: Colors.white),
              // ),
            ],
          )
        ],
      ),
    );
  }
}

// class ProgressLine extends StatelessWidget {
//   const ProgressLine({
//     Key? key,
//     this.color = primaryColor,
//     required this.percentage,
//   }) : super(key: key);
//
//   final Color? color;
//   final int? percentage;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 5,
//           decoration: BoxDecoration(
//             color: color!.withOpacity(0.1),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//         LayoutBuilder(
//           builder: (context, constraints) => Container(
//             width: constraints.maxWidth * (percentage! / 100),
//             height: 5,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
