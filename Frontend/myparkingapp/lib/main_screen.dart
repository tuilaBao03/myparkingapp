import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/request/give_coordinates_request.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/screens/invoice/invoice_screen.dart';

import 'constants.dart';
import 'data/response/parking_lot_response.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  Coordinates? coordinates;
  MainScreen({super.key, this.coordinates});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Bydefault first one is selected
  int _selectedIndex = 0;
  List<ParkingLotResponse> parkinglots = parkingLotsDemoPage1;

  // List of nav items
  final List<Map<String, dynamic>> _navitems = [
    {"icon": "assets/icons/home.svg", "title": "Home"},
    {"icon": "assets/icons/search.svg", "title": "Search"},
    {"icon": "assets/icons/order.svg", "title": "Orders"},
    {"icon": "assets/icons/profile.svg", "title": "Profile"},
  ];
  late final List<Widget> _screens = [
    HomeScreen(coordinates: widget.coordinates,),
    SearchScreen(),
    InvoiceScreen(),
    ProfileScreen(),
  ];

// Screens


  @override
  Widget build(BuildContext context) {
    /// If you set your home screen as first screen make sure call [SizeConfig().init(context)]

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CupertinoTabBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        activeColor: primaryColor,
        inactiveColor: bodyTextColor,
        items: List.generate(
          _navitems.length,
          (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _navitems[index]["icon"],
              height: 30,
              width: 30,
              colorFilter: ColorFilter.mode(
                  index == _selectedIndex ? primaryColor : bodyTextColor,
                  BlendMode.srcIn),
            ),
            label: AppLocalizations.of(context).translate(_navitems[index]["title"]),
          ),
        ),
      ),
    );
  }
}
