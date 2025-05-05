import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/screens/onboarding/components/image_no_content.dart';
import '../../app/locallization/app_localizations.dart';
import '../sign_up/components/sign_up_form.dart';
import '../../constants.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void gotoSignInScreent(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: BlocConsumer<AuthBloc,AuthState>(builder: (context,state){
        if(state is AuthLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
        }
        return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageContent(illustration: "assets/Illustrations/register.svg",title: "Create Account",text: "Enter your Name, Email and Password \nfor sign up.",),
                  // Sign Up Form
                  const SignUpForm(),
                  const SizedBox(height: defaultPadding),

                  // Already have account
                  Center(
                    child: Text.rich(
                      TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w500),
                        text: AppLocalizations.of(context).translate("Already have account? "),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context).translate("Sign In"),
                            style: const TextStyle(color: primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).translate("By Signing up you agree to our Terms \nConditions & Privacy Policy."),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          );
    
      }, listener: (context,state){
        if(state is RegisterSuccessState){
          return AppDialog.showSuccessEvent(context,AppLocalizations.of(context).translate( state.mess), onPress: gotoSignInScreent);
        }
        else if(state is RegisterErrorState){
          return AppDialog.showErrorEvent(context,AppLocalizations.of(context).translate( state.mess));
        }
      })
    );
  }
}
