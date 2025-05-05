// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, file_names
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/customer/components/owner_list.dart';
import '../../constants.dart';
import '../general/header.dart';
import 'components/customer_list.dart';

class OwnerScreen extends StatefulWidget {
  final UserResponse user;
  final Function(Locale) onLanguageChange;
  const OwnerScreen(
      {super.key,
      required this.user,
      required this.onLanguageChange});

  @override
  _OwnerScreenState createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {

  bool SelectWalletList = false;
  bool SelectLotList = false;

  UserResponse user = UserResponse.empty();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Column(children: [
        Header(
            title: AppLocalizations.of(context).translate("owner").toUpperCase(),
            user: widget.user,
            onLanguageChange: widget.onLanguageChange),
        SizedBox(height: 10),
        Column(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: Theme.of(context).colorScheme.surface,
              child: OwnerList(user: widget.user,)
              ),
            SizedBox(height: defaultPadding),
          ],
        ),
      ]),
    ));
  }
}
