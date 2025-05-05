
// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_types_as_parameter_names


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/myprofile/components/customer_detail.dart';


import '../../constants.dart';
import '../general/header.dart';


class MyprofileScreen extends StatefulWidget {

  final UserResponse user;
  final Function(Locale) onLanguageChange;
  const MyprofileScreen({super.key, required this.user, required this.onLanguageChange,});

  @override
  _MyprofileScreenState createState() => _MyprofileScreenState();
}

class _MyprofileScreenState extends State<MyprofileScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: AppLocalizations.of(context).translate("My Profile"),
            user: widget.user,
            onLanguageChange: widget.onLanguageChange,),
            SizedBox(height: defaultPadding),
            Container(
              height: Get.height,
              child: UserDetail(
                user: widget.user,),
            ),
            SizedBox(width: defaultPadding*2),
            
            
          
          ]
        ),
      ) 
    );
  }
}

