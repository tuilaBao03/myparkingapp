import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';
import 'package:myparkingapp/bloc/auth/auth_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/screens/acceptLocation/loading_location_screen.dart';
import 'package:myparkingapp/screens/onboarding/components/image_no_content.dart';
import '../../constants.dart';
import 'sign_up_screen.dart';
import 'components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    void setGetUser(){
    context.read<AuthBloc>().add(GotoAcceptLocationScreenEvent());
  }
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
      ),
      body: BlocConsumer<AuthBloc,AuthState> 
      (builder: (context,state) {
        if(state is AuthLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
        }
        return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageContent(illustration: "assets/Illustrations/login.svg",
                  text: "Enter your username and password", title: 'Login',),
                  const SizedBox(height: defaultPadding),
                  
                  SignInForm(),
                  const SizedBox(height: defaultPadding),
                  kOrText,
                  const SizedBox(height: defaultPadding * 1.5),

                  Center(
                    child: Text.rich(
                      TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w600),
                        text: AppLocalizations.of(context).translate("Don’t have account?"),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context).translate("Create new account."),
                            style: const TextStyle(color: primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      
      );
        
      }, 
      listener: (context,state) {
        if(state is AuthSuccessState){
          return AppDialog.showSuccessEvent(context,AppLocalizations.of(context).translate( state.mess), onPress:  setGetUser);
        }
        else if(state is AuthErrorState){
          return AppDialog.showErrorEvent(context, state.mess);
        }
        else if(state is GotoAcceptLocationScreenState){
          Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AcceptLocationScreen(),
                  ),
                  (_) => true,
                );
        }


      })
    );
  }
}

