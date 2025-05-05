import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';
import 'package:myparkingapp/data/request/register_user_request.dart';

import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController(text: "Bao");
  final TextEditingController _lastNameController = TextEditingController(text: "Ha Bao");
  final TextEditingController _userNameController = TextEditingController(text:"bbbbbbbbb");
  final TextEditingController _passwordController = TextEditingController(text: "123456789");
  final TextEditingController _confirmPasswordController = TextEditingController(text: "123456789");
  final TextEditingController _phoneController = TextEditingController(text:"0888379199");
  final TextEditingController _emailController = TextEditingController(text:"hagiabao980@gmail.com");

  bool _obscureText = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "First Name"),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: _lastNameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "Last Name"),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: _userNameController,
            validator: userNameValidator.call,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "User Name"),
          ),
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
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
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
          TextFormField(
            controller: _phoneController,
            validator: phoneNumberValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: "Phone Number"),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: _emailController,
            validator: emailValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final request = RegisterUserRequest(
                  username: _userNameController.text.trim(),
                  password: _passwordController.text,
                  firstName: _firstNameController.text.trim(),
                  lastName: _lastNameController.text.trim(),
                  email: _emailController.text.trim(),
                  phone: _phoneController.text.trim(),
                );
                context.read<AuthBloc>().add(RegisterEvent(request));
                print("---------------------------------------------------");
              }
            },
            child: Text(AppLocalizations.of(context).translate("Sign Up")),
          ),
        ],
      ),
    );
  }
}
