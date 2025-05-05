import 'package:flutter/material.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

import '../../../components/cards/medium/lot_info_medium_card.dart';
import '../../../components/scalton/medium_card_scalton.dart';
import '../../../constants.dart';
import '../../details_parkinglot/details_screen.dart';

class ParkingLotCardList extends StatefulWidget {
  final UserResponse user;
  final List<ParkingLotResponse> lots;
  const ParkingLotCardList({super.key, required this.lots, required this.user});

  @override
  State<ParkingLotCardList> createState() => _ParkingLotCardListState();
}

class _ParkingLotCardListState extends State<ParkingLotCardList> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // only for demo
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 254,
          child: isLoading
              ? buildFeaturedPartnersLoadingIndicator()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.lots.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: (widget.lots.length - 1) == index ? defaultPadding : 0,
                    ),
                    child: LotInfoMediumCard(
                      image: widget.lots[index].images[0].url!,
                      name:  widget.lots[index].parkingLotName,
                      location:  widget.lots[index].address,
                      gotoTime: 25,
                      rating:  widget.lots[index].rate,
                      status: widget.lots[index].status,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(parkingLot: widget.lots[index], user: widget.user),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  SingleChildScrollView buildFeaturedPartnersLoadingIndicator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          2,
          (index) => const Padding(
            padding: EdgeInsets.only(left: defaultPadding),
            child: MediumCardScalton(),
          ),
        ),
      ),
    );
  }
}
