// ignore_for_file: unused_import, avoid_print
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_bloc.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_event.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_state.dart';
import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';
import 'package:myparkingappadmin/screens/customer/ownerScreen.dart';
import 'package:myparkingappadmin/screens/general/app_dialog.dart';

import 'package:myparkingappadmin/screens/myprofile/myprofile_screen.dart';

import '../../controllers/menu_app_controller.dart';
import '../authentication/login_screen.dart';
import '../customer/customerScreen.dart';
import '../dashboard/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'components/side_menu.dart';
import '../../responsive.dart';

class MainScreen extends StatefulWidget {
  final bool isAuth;
  final Function(Locale) onLanguageChange;
  const MainScreen({super.key,
    required this.isAuth, required this.onLanguageChange,
});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late UserResponse selectedUsersLogin;
  int _currentTab = 1;
  @override
  void initState() {
    super.initState();
    context.read<MainAppBloc>()
        .add(initializationEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(onMenuTap: (int index) {
        setState(() {
          _currentTab = index;
        });
      }, isAuth: widget.isAuth,),
      body: BlocConsumer<MainAppBloc,MainAppState>(
        builder: (context,state){
          if(state is MainLoading){
            return Center(
          child: CircularProgressIndicator(),
             );
          }
          
          else if(state is MainAppLoadedState){
            selectedUsersLogin = state.userResponse;
            return SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  Expanded(child: SideMenu(onMenuTap: (int index) {
                    setState(() {
                      _currentTab = index;
                    });
                  }, isAuth: widget.isAuth,)),
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 8,
                  child: _getScreen(_currentTab),
                ),
              ],
            ),
          );
          }
        return Center(
          child: CircularProgressIndicator(),
        );
      }, listener: (context,state){
        if(state is MainAppErrorState){
          AppDialog.showErrorEvent(context, state.mess,onPress: () {
                context.read<MainAppBloc>()
                .add(initializationEvent());
          },);
          
        }
        else if(state is LogoutSuccess){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen( onLanguageChange: widget.onLanguageChange, ),
                
              ),
            );
        }
        else if(state is MainAppSuccessState){
          AppDialog.showSuccessEvent(context,state.mess,onPress: () {
                context.read<MainAppBloc>()
                .add(initializationEvent());
          },);
        }
        else if(state is ErrorQrScanner){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).translate(state.mess)),
            ),
          );
        }
        else if(state is SuccessQrScanner){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).translate(state.mess)),
            ),
          );
        }
      })
    );
  }
  Widget _getScreen(int tab) {
    switch (tab) {
      case 1:
        return DashboardScreen( user: selectedUsersLogin, onLanguageChange: widget.onLanguageChange);
        
      case 2:
        return CustomerScreen(
          user: selectedUsersLogin,
          onLanguageChange: widget.onLanguageChange,
        );
      case 3:
        return OwnerScreen(
          user: selectedUsersLogin,
          onLanguageChange: widget.onLanguageChange,
        );
      case 4:
        return MyprofileScreen(
          user: selectedUsersLogin,
          onLanguageChange: widget.onLanguageChange,
        );
      default:
        return DashboardScreen(
          user: selectedUsersLogin,
          onLanguageChange: widget.onLanguageChange,
        );
    }
  }
}

