// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/user/user_bloc.dart';
import 'package:myparkingapp/bloc/user/user_event.dart';
import 'package:myparkingapp/bloc/user/user_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/constants.dart';
import 'package:myparkingapp/data/response/user_response.dart';

class UpdatePassword extends StatelessWidget {
  UpdatePassword({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController _olderPass = TextEditingController();
    TextEditingController _newPass = TextEditingController();
    TextEditingController _renewPass = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Edit Profile")),
        backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
      ),
      body: BlocConsumer<UserBloc,UserState>(
        builder: (context,state){
          if(state is UserLoadingState){
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Divider(),
                Form(
                  child: Column(
                    children: [
                      UserInfoEditField(
                        text: "Older Password",
                        child: TextFormField(
                          controller: _olderPass,
                          validator: passwordValidator.call,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),

                      UserInfoEditField(
                        text: "New Password",
                        child: TextFormField(
                          controller: _newPass,
                          validator: passwordValidator.call,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      UserInfoEditField(
                        text: "Re Enter Password",
                        child: TextFormField(
                          controller: _renewPass,
                          validator: passwordValidator.call,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF00BF6D).withOpacity(0.05),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(width: 16.0),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BF6D),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          context.read<UserBloc>().add(ChangePassword(_newPass.text, _olderPass.text));
                          
                        },
                        child: Text(AppLocalizations.of(context).translate("Save Update")),
                      ),
                    ),
                  ],
                ),
            )],
            ),
          );

        },
        listener: (context,state){
          if(state is UserSuccessState){
            AppDialog.showSuccessEvent(context,AppLocalizations.of(context).translate( state.mess));
          }
          else if(state is UserErrorState){
            AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess));
          }
        })
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(AppLocalizations.of(context).translate(text)),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
