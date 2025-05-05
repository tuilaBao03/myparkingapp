import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';
import 'package:myparkingapp/bloc/auth/auth_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/screens/onboarding/components/image_no_content.dart';
import '../../app/locallization/app_localizations.dart';
import 'reset_email_sent_screen.dart';

import '../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Forgot password")),
      ),
      body: BlocConsumer<AuthBloc,AuthState>(builder: (context,state) {
        if(state is AuthLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
        }
        return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageContent(illustration: "assets/Illustrations/register.svg",title: "Forgot password",text: "Enter your email address and we will \nsend you a reset instructions.",),
            SizedBox(height: defaultPadding),
            ForgotPassForm(),
          ],
        ),
      );
      }, listener: (context,state){
        if(state is GiveEmailSuccessState){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetEmailSentScreen( token: state.mess,)
            ),
          );
        }
        else if(state is GiveEmailErrorState){
          return AppDialog.showErrorEvent(context, AppLocalizations.of(context).translate( state.mess));
        }
      })
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            controller: _email,
            validator: emailValidator.call,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("Email Address")),
          ),
          const SizedBox(height: defaultPadding),

          // Reset password Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(giveEmail(_email.text));
              }
            },
            child: Text(AppLocalizations.of(context).translate("Reset password")),
          ),
        ],
      ),
    );
  }
}
