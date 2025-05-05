// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/location/location_bloc.dart';
import 'package:myparkingapp/bloc/location/location_event.dart';
import 'package:myparkingapp/bloc/location/location_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/api_service/tomtom_map/map_widget.dart';

class MapWidgetScreen extends StatefulWidget {
  final LatLng endPoint;
  final String parkingLotName;

  const MapWidgetScreen({super.key, required this.endPoint, required this.parkingLotName});

  @override
  // ignore: library_private_types_in_public_api
  _MapWidgetScreenState createState() => _MapWidgetScreenState();
}

class _MapWidgetScreenState extends State<MapWidgetScreen> {
  LatLng currentLocation = LatLng(0, 0);
  List<LatLng> routePoints = [];
  MapWidget mapWidget = MapWidget(endPoint: LatLng(0, 0) );

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(GetRouterEvent(widget.endPoint));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate(widget.parkingLotName)),
              backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                      backgroundColor: Colors.black.withOpacity(0.5),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
            ),
            body: BlocConsumer<LocationBloc,LocationState>(
            builder: (context,state){
              if(state is LocationLoading){
                return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
              }
              else if(state is LocationLoadedState ){
                currentLocation = state.currentLocation;
                routePoints = state.routePoints;

                return mapWidget.buildRouteMap(currentLocation, routePoints);
              

              }
              return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
            }, listener: (context,state){
            if(state is LocationSuccessState){
              return AppDialog.showSuccessEvent(context, AppLocalizations.of(context).translate(state.mess),);
            }
            else if(state is LocationErrorState){
              return AppDialog.showErrorEvent(context, AppLocalizations.of(context).translate(state.mess));
            }
          })
            
            
            





          );
    
    
    
    
  }
}

