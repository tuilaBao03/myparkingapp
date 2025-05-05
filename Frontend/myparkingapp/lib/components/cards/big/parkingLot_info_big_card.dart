// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/location/location_bloc.dart';
import 'package:myparkingapp/bloc/location/location_event.dart';
import 'package:myparkingapp/bloc/location/location_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';

import '../../../constants.dart';
import '../../../screens/details_parkinglot/details_screen.dart';
import '../../vehicle_type_list.dart';
import '../../rating_with_counter.dart';
import '../../small_dot.dart';
import 'big_card_image_slide.dart';

class ParkingLotInfoBigCard extends StatefulWidget {
  final UserResponse user; 
  final ParkingLotResponse parkingLot;
  final VoidCallback press;

  const ParkingLotInfoBigCard({
    super.key,
    required this.parkingLot,
    required this.press, required this.user,
  });

  @override
  State<ParkingLotInfoBigCard> createState() => _ParkingLotInfoBigCardState();
}

class _ParkingLotInfoBigCardState extends State<ParkingLotInfoBigCard> {
  @override
  void initState() {
    super.initState();
    LatLng location = LatLng(widget.parkingLot.latitude, widget.parkingLot.longitude);
    context.read<LocationBloc>().add(GetCurrentDistance(location));
  }
  double distance = 2;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc,LocationState>(
        builder: (context,state){
          if(state is LocationLoading){
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
          }
          if(state is LoadingDistanceState){
            distance = state.distance;
          }
          return InkWell(
            onTap: widget.press,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // pass list of images here
                BigCardImageSlide(images: widget.parkingLot.images.map((image)=>image.url).toList(), active: widget.parkingLot.status.name.toString(), isBanner: false,),
                const SizedBox(height: defaultPadding / 2),
                Text(widget.parkingLot.parkingLotName, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: defaultPadding / 4),
                VehicleTypeList(typeList: ["vehicle","car"]),
                const SizedBox(height: defaultPadding / 4),
                Row(
                  children: [
                    RatingWithCounter(rating: widget.parkingLot.rate, numOfRating: 10000),
                    const SizedBox(width: defaultPadding / 2),
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$distance km",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                      child: SmallDot(),
                    ),
                    const SizedBox(width: 8),

                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        }, listener: (context,state){
        if(state is LocationSuccessState){
          return AppDialog.showSuccessEvent(context, AppLocalizations.of(context).translate(state.mess));
        }
        else if(state is LocationErrorState){
          return AppDialog.showErrorEvent(context, AppLocalizations.of(context).translate(state.mess));
        }
      }); }
}

class ParkingLotList extends StatefulWidget {
  final List<ParkingLotResponse> lots;
  final UserResponse user;


  const ParkingLotList({super.key, required this.lots, required this.user});

  @override
  State<ParkingLotList> createState() => _ParkingLotListState();
}

class _ParkingLotListState extends State<ParkingLotList> {
  late List<ParkingLotResponse> displayLots;

  @override
  void initState() {
    super.initState();
    displayLots = widget.lots; // init ban đầu
  }

  @override
  void didUpdateWidget(covariant ParkingLotList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lots != widget.lots) {
      setState(() {
        displayLots = widget.lots; // cập nhật khi widget.lots đổi
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        displayLots.length,
            (index) {
          final lot = displayLots[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, defaultPadding),
            child: ParkingLotInfoBigCard(
              user: widget.user,
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(parkingLot: lot, user: widget.user),
                ),
              ),
              parkingLot: lot,
            ),
          );
        },
      ),
    );
  }
}



