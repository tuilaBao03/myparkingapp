// ignore_for_file: depend_on_referenced_packages, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/booking/booking_bloc.dart';
import 'package:myparkingapp/bloc/home/home_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_bloc.dart';
import 'package:myparkingapp/bloc/location/location_bloc.dart';
import 'package:myparkingapp/bloc/lot/lot_detail_bloc.dart';
import 'package:myparkingapp/bloc/payment/payment_bloc.dart';
import 'package:myparkingapp/bloc/transaction/transaction_bloc.dart';
import 'package:myparkingapp/bloc/user/user_bloc.dart';
import 'package:myparkingapp/bloc/wallet/wallet_bloc.dart';
import 'package:myparkingapp/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'app/locallization/app_localizations.dart';
import 'app/theme/app_theme.dart';
import 'bloc/search/search_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          BlocProvider(create: (context)=> HomeBloc()),
          BlocProvider(create: (context)=> SearchBloc()),
          BlocProvider(create: (context)=> LotDetailBloc()),
          BlocProvider(create: (context)=> BookingBloc()),
          BlocProvider(create: (context)=> InvoiceBloc()),
          BlocProvider(create: (context)=> UserBloc()),
          BlocProvider(create: (context)=> WalletBloc()),
          BlocProvider(create: (context)=> TransactionBloc()),
          BlocProvider(create: (context)=> AuthBloc()),
          BlocProvider(create: (context)=> LocationBloc()),
          BlocProvider(create: (context)=> PaymentBloc())
    ],
    child: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('vi');
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Parking App',
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
      home: OnboardingScreen(changeLanguage: _changeLanguage));// Thay thế bằng widget của bạn;
  }
}
