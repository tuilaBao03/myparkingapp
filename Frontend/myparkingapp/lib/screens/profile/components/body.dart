// ignore_for_file: deprecated_member_use, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/repository/auth_repository.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/screens/auth/sign_in_screen.dart';
import 'package:myparkingapp/screens/profile/components/update_password_screen.dart';
import 'package:myparkingapp/screens/profile/components/update_user_screen.dart';
import 'package:myparkingapp/screens/wallet/wallet_screen.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate("Choose Language")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("EN"),
              onTap: () {
                Get.updateLocale(const Locale('en')); // hoặc Locale('en')
                print("en");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("VI"),
              onTap: () {
                Get.updateLocale(const Locale('vi')); // hoặc Locale('en')
                print("vi");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              
              Text(AppLocalizations.of(context).translate("Account Settings"),
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(
                AppLocalizations.of(context).translate("Update your settings like notifications, payments, profile edit etc."),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ProfileMenuCard(
                svgSrc: "assets/icons/profile.svg",
                title: AppLocalizations.of(context).translate("Profile Information"),
                subTitle: AppLocalizations.of(context).translate("Change your account information"),
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                },
              ),
              ProfileMenuCard(
                svgSrc: "assets/icons/lock.svg",
                title: AppLocalizations.of(context).translate("Change Password"),
                subTitle: AppLocalizations.of(context).translate("Change your password"),
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword()));
                },
              ),
              ProfileMenuCard(
                svgSrc: "assets/icons/card.svg",
                title: AppLocalizations.of(context).translate("Payment Methods"),
                subTitle: AppLocalizations.of(context).translate("Add your credit & debit cards"),
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()));
                },
              ),
              ProfileMenuCard(
                svgSrc: "assets/icons/marker.svg",
                title: AppLocalizations.of(context).translate("Language"),
                subTitle: AppLocalizations.of(context).translate("Change your language"),
                press: () {
                  _showLanguageDialog();
                },
              ),
              ProfileMenuCard(
                svgSrc: "assets/icons/logout.svg",
                title: AppLocalizations.of(context).translate("Logout"),
                subTitle: AppLocalizations.of(context).translate("Return login screen"),
                press: () {
                  AuthRepository auth = AuthRepository();
                  auth.logout();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>SignInScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    this.title,
    this.subTitle,
    this.svgSrc,
    this.press,
  });

  final String? title, subTitle, svgSrc;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SvgPicture.asset(
                svgSrc!,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  titleColor.withOpacity(0.64),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subTitle!,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: titleColor.withOpacity(0.54),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
