import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_bloc.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_state.dart';
import 'package:myparkingapp/data/response/parking_slots_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/parking_lot_response.dart';

import '../../app/locallization/app_localizations.dart';
import '../../bloc/lot/lot_detail_event.dart';
import '../../components/app_dialog.dart';
import '../../constants.dart';
import 'components/featured_items.dart';
import 'components/iteams.dart';
import 'components/lot_info.dart';

class DetailsScreen extends StatefulWidget {
  final UserResponse user;
  final ParkingLotResponse parkingLot;
  const DetailsScreen({super.key, required this.parkingLot, required this.user});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> floorNames = [];
  String selectedFloor = "";
  List<DataOnFloor> floorData = [];

  @override
  void initState() {
    super.initState();
    context.read<LotDetailBloc>().add(LotDetailScreenInitialEvent(widget.parkingLot));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: SvgPicture.asset("assets/icons/share.svg"),
        //     onPressed: () {
        //
        //     },
        //   ),
        // ],
      ),
      body: BlocConsumer<LotDetailBloc, LotDetailState>(
        builder: (context, state) {
          if (state is LoadingLotDetailState) {
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent, size: 25));
          } else if (state is LoadedLotDetailState) {
            // Chỉ gán dữ liệu vào floorNames và floorData khi LoadedLotDetailState được nhận
            floorNames = state.dataOnFloor[0].floorNames;
            floorData = state.dataOnFloor;
            selectedFloor = selectedFloor.isEmpty ? floorNames[0] : selectedFloor;

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding / 2),
                    ParkingLotInfo(lot: widget.parkingLot),
                    SizedBox(height: defaultPadding),
                    FeaturedItems(images: widget.parkingLot.images),
                    DefaultTabController(
                      length: floorNames.length,
                      child: Column(
                        children: [
                          // TabBar cho các tầng
                          TabBar(
                            isScrollable: true,
                            unselectedLabelColor: titleColor,
                            labelStyle: Theme.of(context).textTheme.titleLarge,
                            onTap: (index) {
                              setState(() {
                                selectedFloor = floorNames[index];
                              });
                            },
                            tabs: floorNames.map((name) => Tab(text: name)).toList(), // Tạo tab cho mỗi tầng
                          ),
                          // TabBarView chứa nội dung của mỗi tầng
                          SizedBox(
                            height: Get.height,
                            child: TabBarView(
                              children: floorNames.map((name) {
                                // Tìm tầng tương ứng và truyền dữ liệu cho `Items`
                                final floor = floorData.firstWhere((e) => e.floorName == name); // Lọc dữ liệu theo tên tầng
                                return Items(
                                  slots: floor.lots, // Truyền các slots của tầng vào Items
                                  lot: widget.parkingLot, // Truyền parkingLot vào Items
                                  user: widget.user, // Truyền user vào Items
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent, size: 25));
        },
        listener: (context, state) {
          if (state is LotDetailErrorScreen) {
            AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess));
          }
        },
      ),
    );
  }
}

