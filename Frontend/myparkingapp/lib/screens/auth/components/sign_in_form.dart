import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';
import '../../../app/locallization/app_localizations.dart';

import '../../../constants.dart';
import '../forgot_password_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String userName = "admin1";
  String passWord = "admin123";

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: userNameValidator.call,
            onSaved: (value) {
              userName = value ?? '';
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("UserName")),
          ),
          const SizedBox(height: defaultPadding),

          // Password Field
          TextFormField(
            obscureText: _obscureText,
            validator: passwordValidator.call,
            onSaved: (value) {
              passWord = value ?? '';
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).translate("Password"),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: bodyTextColor)
                    : const Icon(Icons.visibility, color: bodyTextColor),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Forget Password
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotPasswordScreen(),
              ),
            ),
            child: Text(
              AppLocalizations.of(context).translate("Forget Password?")
              ,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Sign In Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // just for demo
                context.read<AuthBloc>().add(LoginEvent(userName, passWord));
              }
            },
            child:  Text(AppLocalizations.of(context).translate("Sign in")),
          ),
        ],
      ),
    );
  }
}
