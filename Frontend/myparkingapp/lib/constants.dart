// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// clolors that we use in our app
const titleColor = Color(0xFF010F07);
const primaryColor = Color(0xFF22A45D);
const accentColor = Color(0xFFEF9920);
const bodyTextColor = Color(0xFF868686);
const inputColor = Color(0xFFFBFBFB);

const double defaultPadding = 16;
const Duration kDefaultDuration = Duration(milliseconds: 250);

const TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const EdgeInsets kTextFieldPadding = EdgeInsets.symmetric(
  horizontal: defaultPadding,
  vertical: defaultPadding,
);

// Text Field Decoration
const OutlineInputBorder kDefaultOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(6)),
  borderSide: BorderSide(
    color: Color(0xFFF3F2F2),
  ),
);

const titleColorDark = Color(0xFFE0E0E0); // Màu chữ sáng hơn để dễ đọc
const primaryColorDark = Color(0xFF1B5E20); // Màu chính tối hơn
const accentColorDark = Color(0xFFFFA726); // Giữ màu accent nhưng sáng hơn
const bodyTextColorDark = Color(0xFFBDBDBD); // Màu chữ phụ sáng hơn
const inputColorDark = Color(0xFF424242); // Màu input tối hơn để phù hợp nền tối

const TextStyle kButtonTextStyleDark = TextStyle(
  color: Colors.black, // Chữ trên button cần tương phản
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const EdgeInsets kTextFieldPaddingDark = EdgeInsets.symmetric(
  horizontal: defaultPadding,
  vertical: defaultPadding,
);

// Text Field Decoration (Dark Mode)
const OutlineInputBorder kDefaultOutlineInputBorderDark = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(6)),
  borderSide: BorderSide(
    color: Color(0xFF616161), // Viền input tối hơn
  ),
);

const InputDecoration otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.zero,
  counterText: "",
  errorStyle: TextStyle(height: 0),
);

const kErrorBorderSide = BorderSide(color: Colors.red, width: 1);

// Validator
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
  // PatternValidator(r'(?=.*?[#?!@$%^&*-/])',
  //     errorText: 'Passwords must have at least one special character')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: 'Enter a valid email address')
]);

final requiredValidator =
    RequiredValidator(errorText: 'This field is required');
final matchValidator = MatchValidator(errorText: 'passwords do not match');

final phoneNumberValidator = MinLengthValidator(10,
    errorText: 'Phone Number must be at least 10 digits long');

final userNameValidator = MinLengthValidator(6, errorText: 'user name must be at least 6 digital long ');
// Common Text
final Center kOrText = Center(
    child: Text( "Or", style: TextStyle(color: titleColor.withOpacity(0.7))));
