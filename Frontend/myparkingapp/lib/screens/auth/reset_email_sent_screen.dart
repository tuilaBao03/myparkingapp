import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';
import 'package:myparkingapp/bloc/auth/auth_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/screens/auth/sign_in_screen.dart';
import 'package:myparkingapp/screens/onboarding/components/image_no_content.dart';


import '../../constants.dart';



class ResetEmailSentScreen extends StatefulWidget {
  final String token;
  
  const ResetEmailSentScreen({super.key, required this.token});

  @override
  State<ResetEmailSentScreen> createState() => _ResetEmailSentScreenState();
}

class _ResetEmailSentScreenState extends State<ResetEmailSentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot password"),
      ),
      body: BlocConsumer<AuthBloc,AuthState>(builder: (context,state) {
        if(state is AuthLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
        }
        return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child:Form(
            key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageContent(illustration: "assets/Illustrations/give_email.svg",
            title: "Reset email sent",
            text: "We have sent a instructions email to \ntheflutterway@email.com.",),
            const SizedBox(height: defaultPadding),

            TextFormField(
              controller: _passwordController,
            obscureText: _obscureText,
            validator: passwordValidator.call,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(

              hintText: "Password",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: bodyTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Confirm Password Field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _confirmPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Confirm Password",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: bodyTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState!.save();
                context
                    .read<AuthBloc>()
                    .add(
                      giveRePassWord(_passwordController.text, widget.token)
                    );
              }
              },
              child: Text(AppLocalizations.of(context).translate( "Send again")),
            ),
          ],
        ) ),
      );
    
      }, listener: (context,state){
        if(state is GiveRePassSuccessState){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen()
            ),
          );
        }
        else if(state is GiveRePassErrorState){
          return AppDialog.showErrorEvent(context, AppLocalizations.of(context).translate(state.mess));
        }
      })
      );
  }
}
