import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/service.dart';

import '../../data/response/parking_lot_response.dart';
import 'components/body.dart';

class FeaturedScreen extends StatelessWidget {
  final UserResponse user;
  final String title;
  final List<ParkingLotResponse> lots;
  final List<Service> services;
  final bool isLot;
  const FeaturedScreen({super.key, required this.lots, required this.services, required this.isLot, required this.title, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate(title)),
      ),
      body: Body(lots: lots, services: services, isLot: isLot, user: user,),
    );
  }
}
