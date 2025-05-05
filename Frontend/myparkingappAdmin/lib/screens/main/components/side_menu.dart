import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/localization/app_localizations.dart';

class SideMenu extends StatelessWidget {
  final bool isAuth;
  final Function(int) onMenuTap;
  

  const SideMenu({super.key, required this.onMenuTap, required this.isAuth});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: isAuth?ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () => onMenuTap(1),
          ),
          DrawerListTile(
            title: AppLocalizations.of(context).translate("Customer"),
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => onMenuTap(2),
          ),
          DrawerListTile(
            title: AppLocalizations.of(context).translate("Owner"),
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => onMenuTap(3),
          ),
          DrawerListTile(
            title: AppLocalizations.of(context).translate("My Profile"),
            svgSrc: "assets/icons/menu_profile.svg",
            press: () => onMenuTap(4),
          ),
        ],
      ):ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: AppLocalizations.of(context).translate("AboutUs"),
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () => onMenuTap(1),
          ),
          DrawerListTile(
            title: AppLocalizations.of(context).translate("Contact & Help"),
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => onMenuTap(2),
          ),
          DrawerListTile(
            title: AppLocalizations.of(context).translate("Setting"),
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => onMenuTap(3),
          ),
        ],
      )
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
