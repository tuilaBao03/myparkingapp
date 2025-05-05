
// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_bloc.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:provider/provider.dart';


import '../../app/localization/app_localizations.dart';
import '../../bloc/main_app/main_app_event.dart';
import '../../constants.dart';
import '../../controllers/menu_app_controller.dart';
import '../../responsive.dart';

class Header extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  UserResponse? user;
  final String title; // Thêm biến title vào class
  Header({
    super.key, required this.title, this.user, required this.onLanguageChange,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context) )
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Container(
          width: 200, // Giới hạn chiều rộng cho Container
          decoration: BoxDecoration(
            color: Colors.white60,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: double.infinity, // Đảm bảo ListTile chiếm toàn bộ chiều rộng có sẵn
            child: buildListTile(
              Icons.language,
              AppLocalizations.of(context).translate("App Language"),
              onTap: () {
                _showLanguageDialog();
              },
            ),
          ),
        ),

        if(widget.user != null)
          ProfileCard(user: widget.user!,),
        SizedBox(
          width: defaultPadding,
        ),
      ],
    );
  }

    ListTile buildListTile(IconData icon, String title,
      {required VoidCallback onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('Choose Language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context).translate('English')),
                onTap: () {
                  widget.onLanguageChange(const Locale('en'));
                  Navigator.pop(context); // Đóng dialog
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context).translate('Vietnamese')),
                onTap: () {
                  widget.onLanguageChange(const Locale('vi'));
                  Navigator.pop(context); // Đóng dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {

  final UserResponse user;
  const ProfileCard({
    super.key, required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary,),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(user.firstName, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,),),
            ),
          

          
          IconButton(
            onPressed: () => _showOptionsDialog(context),
            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ],
      ),
    );
    
  }
    void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  // Xử lý đăng xuất ở đây
                  context.read<MainAppBloc>().add(
                                              LogoutEvent()
                                          );
                  // Ví dụ: gọi một hàm đăng xuất hoặc reset token
                },
              ),
              ListTile(
                title: Text('Change Password'),
                onTap: () {
                  // Chuyển tới màn hình đổi mật khẩu
                  Navigator.pop(context);
                  // Ví dụ: Điều hướng tới màn hình đổi mật khẩu
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
