// ignore_for_file: avoid_print, non_constant_identifier_names, unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../app/localization/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../constants.dart';
import '../general/header.dart';
import '../../responsive.dart';
import '../main/components/side_menu.dart';
class ForgetPassWordScreen extends StatefulWidget {
  final bool isAuth;
  final Function(Locale) onLanguageChange;
  const ForgetPassWordScreen({super.key,
    required this.isAuth, required this.onLanguageChange,
});
  @override
  State<ForgetPassWordScreen> createState() => _ForgetPassWordScreenState();
}
class _ForgetPassWordScreenState extends State<ForgetPassWordScreen> {
  final TextEditingController _usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc,AuthState>(
        builder: (context,state){
          return
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 6,
                    child: SingleChildScrollView(
                      primary: false,
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          Header(title: AppLocalizations.of(context).translate("Login"),onLanguageChange: widget.onLanguageChange),
                          SizedBox(height: defaultPadding),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child:
                                Container(
                                  height: Get.height/1.1,
                                  padding: EdgeInsets.all(defaultPadding),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            if (!Responsive.isMobile(context))
                                              Expanded(
                                                flex: 3,

                                                child:
                                                Center(
                                                  child: Image.asset("assets/images/image_Login.png",
                                                    height: Get.height/2,
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                  height: Responsive.isDesktop(context) == true ? Get.height/1.2:Get.height/1.1,
                                                  width: Responsive.isDesktop(context) == true ? Get.width/3 :Get.width/2,
                                                  padding: EdgeInsets.all(defaultPadding),
                                                  decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                      color: Theme.of(context).colorScheme.primary
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Center(
                                                        child: CircleAvatar(
                                                          radius: Get.width / 20, // Đặt kích thước avatar
                                                          backgroundColor: Colors.grey, // Màu nền
                                                          child: Icon(
                                                            Icons.person, // Icon hiển thị bên trong
                                                            size: Get.width / 15, // Kích thước icon
                                                            color: Colors.white, // Màu icon
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: Get.width/30,),
                                                      Column(
                                                        children: [
                                                          TextField(
                                                            controller: _usernameController,
                                                            decoration: InputDecoration(
                                                              labelText: AppLocalizations.of(context).translate("Email"),
                                                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                                              border: OutlineInputBorder(),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary), // Viền khi focus
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: defaultPadding),
                                                          ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      foregroundColor: Theme.of(context).colorScheme.secondary,
                                                                      backgroundColor: Theme.of(context).colorScheme.onPrimary, // Màu chữ trên nền chính
                                                                    ),
                                                                    onPressed: () {
                                                                      // context.read<AuthBloc>().add(AuthenticateEvent(_usernameController.text, _passwordController.text));
                                                                    },
                                                                    child: Text(AppLocalizations.of(context).translate("Login")),
                                                                  ),
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ),

                                          ]
                                      )
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          );
        },       listener: (context, state) {
        if (state is AuthError) {
          // Hiển thị AlertDialog khi có lỗi
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(state.message), // Hiển thị thông báo lỗi
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();// Đóng hộp thoại
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng hộp thoại và thoát
                      // Có thể thêm logic thoát ứng dụng ở đây nếu cần
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      ),
    );
  }
}

