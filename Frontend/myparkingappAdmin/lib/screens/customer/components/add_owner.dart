// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:myparkingappadmin/bloc/customer/customer_bloc.dart';
import 'package:myparkingappadmin/bloc/customer/customer_event.dart';
import 'package:myparkingappadmin/data/dto/request/admin_request/create_parking_owner_request.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';
import 'package:provider/provider.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';

import '../../../../constants.dart';

class AddOwner extends StatefulWidget {

  AddOwner({
    super.key,
  });

  @override
  State<AddOwner> createState() => _AddOwnerState();
}

class _AddOwnerState extends State<AddOwner> {
  final TextEditingController _userNameController = TextEditingController(text: "bao2003@");
  final TextEditingController _passwordController = TextEditingController(text: "123456789");
  final TextEditingController _lastnameController = TextEditingController(text: "HaGia");
  final TextEditingController _firstnameController= TextEditingController(text: "Bao");
  final TextEditingController _emailController = TextEditingController(text: "hagiabao980@gmail.com");
  final TextEditingController _numberPhoneController = TextEditingController(text: "0888379199");
  final TextEditingController _roleController = TextEditingController(text: "PARKING_OWNER");
  final TextEditingController _statusController = TextEditingController(text: UserStatus.ACTIVE.toString());
  Uint8List? _imageBytes;// URL từ Cloudinary
  final String publicId =  DateTime.now().millisecondsSinceEpoch.toString();
  final String defaultImageUrl =
      "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _lastnameController.dispose();
    _firstnameController.dispose();
    _emailController.dispose();
    _numberPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ❌ Không hiển thị nút back
        title: Text(
          AppLocalizations.of(context).translate("Create User"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final CreateParkingOwnerRequest request = CreateParkingOwnerRequest (
                username: _userNameController.text,
                password: _passwordController.text,
                phone: _numberPhoneController.text,
                lastName: _lastnameController.text,
                firstName: _firstnameController.text,
                email: _emailController.text,
              );
              context.read<CustomerBloc>().add(
                    CreateParkingOwnerEvent(request)
                  );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: defaultPadding),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: _imageBytes != null
                      ? Image.memory(_imageBytes!, fit: BoxFit.scaleDown)
                      : Image.network(defaultImageUrl, fit: BoxFit.scaleDown),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: TextFieldCustom(
                      editController: _roleController,
                      title: "Role",
                      isEdit: false,
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: TextFieldCustom(
                      editController: _statusController,
                      title: "Status",
                      isEdit: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(child: TextFieldCustom(title: 'UserName', editController: _userNameController, isEdit: true),),
                  SizedBox(width: defaultPadding),
                  Expanded(child: TextFieldCustom(title: 'Password', editController: _passwordController, isEdit: true),),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(child: TextFieldCustom(title: 'LastName', editController: _lastnameController, isEdit: true),),
                  SizedBox(width: defaultPadding),
                  Expanded(child: TextFieldCustom(title: 'FirstName', editController: _firstnameController, isEdit: true),),
                ],
              ),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'Email', editController: _emailController, isEdit: true),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'Phone', editController: _numberPhoneController, isEdit: true),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
