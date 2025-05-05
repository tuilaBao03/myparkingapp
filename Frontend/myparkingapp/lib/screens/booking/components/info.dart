import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import '../../../constants.dart';
import '../../../data/response/parking_slots_response.dart';

class Info extends StatelessWidget {
  final ParkingLotResponse lot;
  final ParkingSlotResponse slot;

  const Info({
    super.key, required this.lot, required this.slot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.33,
          child: Image.network(
            lot.images[0].url!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/big_1.png', // đổi thành đường dẫn asset của bạn
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${lot.parkingLotName}    -    ${slot.slotName}",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                lot.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "${AppLocalizations.of(context).translate("CostByMonth")} : ${slot.pricePerMonth} / USD",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "${AppLocalizations.of(context).translate("CostByHour")} : ${slot.pricePerHour} / USD",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
