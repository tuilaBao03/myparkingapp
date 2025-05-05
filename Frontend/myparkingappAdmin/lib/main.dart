
// ignore_for_file: depend_on_referenced_packages, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/bloc/customer/customer_bloc.dart';
import 'package:myparkingappadmin/bloc/dashboard/dashboard_bloc.dart';
import 'package:myparkingappadmin/bloc/discount/discount_bloc.dart';
import 'package:myparkingappadmin/bloc/invoice/bloc.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_lot/lot_bloc.dart';
import 'package:myparkingappadmin/bloc/parking_slot/slot_bloc.dart';
import 'package:myparkingappadmin/bloc/transaction/tran_bloc.dart';
import 'package:myparkingappadmin/bloc/wallet/wallet_bloc.dart';
import 'package:myparkingappadmin/screens/authentication/login_screen.dart';
import 'package:provider/provider.dart';
import 'app/localization/app_localizations.dart';
import 'app/theme/app_theme.dart';
import 'bloc/auth/auth_bloc.dart';
import 'controllers/menu_app_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';




void main() {
  runApp(
    MultiProvider(
        providers: [
          MultiProvider( providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
            BlocProvider(create: (context)=>AuthBloc()),
            BlocProvider(create: (context)=>MainAppBloc()),
            BlocProvider(create: (context)=>CustomerBloc()),
            BlocProvider(create: (context)=>ParkingLotBloc()),
            BlocProvider(create: (context)=>ParkingSlotBloc()),
            BlocProvider(create: (context)=>WalletBloc()),
            BlocProvider(create: (context)=>DiscountBloc()),
            BlocProvider(create: (context)=>InvoiceBloc()),
            BlocProvider(create: (context)=>TransactionBloc()),
            BlocProvider(create: (context)=>DashboardBloc()),
          ]
          )
        ],
        child:MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Ngôn ngữ mặc định là tiếng Anh
  void _changeLanguage(Locale locale) {
    setState(() {
      print(locale);
      _locale = locale;
    });
  }
  // This widget is the root of your application.
  // UserResponse u = UserResponse(
  //   userId: '1',
  //   username: 'john_doe',
  //   password: 'password123',
  //   phoneNumber: '123-456-7890',
  //   homeAddress: '123 Main St',
  //   companyAddress: '456 Business Blvd',
  //   lastName: 'Doe',
  //   firstName: 'John',
  //   avatar: Images("", null, null),
  //   email: 'john.doe@example.com',
  //   roles: [], status: UserStatus.ACTIVE,
  // );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: AppTheme.lightTheme, // Áp dụng Light Theme
        darkTheme: AppTheme.darkTheme, // Áp dụng Dark Theme
        themeMode: ThemeMode.system,
        locale: _locale, // Áp dụng ngôn ngữ hiện tại
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('vi', ''), // Vietnamese
        ],
        home: LoginScreen( onLanguageChange: _changeLanguage)
        
    );
  }
}
