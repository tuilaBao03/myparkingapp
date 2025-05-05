// ignore_for_file: avoid_print, non_constant_identifier_names, unused_field, avoid_types_as_parameter_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/responsive.dart';
import '../../app/localization/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../constants.dart';
import '../general/header.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const LoginScreen({
    super.key,
    required this.onLanguageChange,
  });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(20),
              height: Get.height / 1.1,
              width: Get.width / 1.5,
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  Header(
                      title: AppLocalizations.of(context).translate(""),
                      onLanguageChange: widget.onLanguageChange),
                  SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      if(Responsive.isDesktop(context))
                        Expanded(
                            // It takes 5/6 part of the screen
                            flex: 2,
                            child: SizedBox(
                              height: Get.height / 1.5,
                              child: Image.asset(
                                "assets/images/login_banner.jpg",
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                      Expanded(
                        // It takes 5/6 part of the screen
                        flex: 3,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              height: Get.height / 1.5,
                              width: Get.width / 2,
                              color: Theme.of(context).colorScheme.secondary,
                              child: Column(
                                children: [
                                  SizedBox(height: Get.height/10),
                                  Center(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate("Login"),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                  Spacer(),
                                  TextField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)
                                          .translate("Email"),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary), // Viền khi focus
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: defaultPadding),
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)
                                          .translate("Password"),
                                      labelStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary), // Viền khi focus
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: defaultPadding),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          disabledForegroundColor: Theme.of(
                                                  context)
                                              .colorScheme
                                              .onPrimary, // Màu khi bị vô hiệu hóa
                                        ),
                                        onPressed: () {},
                                        child: Text(AppLocalizations.of(
                                                context)
                                            .translate("Forget Password")),
                                      ),
                                      if (Responsive.isDesktop(context))
                                    
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onPrimary, // Màu chữ trên nền chính
                                          ),
                                          onPressed: () {
                                            context.read<AuthBloc>().add(
                                                AuthenticateEvent(
                                                    _usernameController.text,
                                                    _passwordController.text));
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate("Login")),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: defaultPadding),
                                  if (!Responsive.isDesktop(context))
                                    ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary, // Màu chữ trên nền chính
                                            ),
                                            onPressed: () {
                                              context.read<AuthBloc>().add(
                                                  AuthenticateEvent(
                                                      _usernameController.text,
                                                      _passwordController.text));
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .translate("Login")),
                                          ),
                                  SizedBox(height: Get.height/10),
                                
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(
                        isAuth: true,
                        onLanguageChange: widget.onLanguageChange
                      )),
            );
          } else if (state is AuthError) {
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
                        Navigator.of(context).pop(); // Đóng hộp thoại
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
