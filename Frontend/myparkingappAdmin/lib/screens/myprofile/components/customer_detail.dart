// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_bloc.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_event.dart';
import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';
import 'package:provider/provider.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';

import '../../../../constants.dart';

class UserDetail extends StatefulWidget {
  final UserResponse user;
  VoidCallback? onEdit;

  UserDetail({
    super.key,
    required this.user,
    this.onEdit,
  });

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  bool isEdit = false;
  late TextEditingController _userNameController;
  late TextEditingController _lastnameController;
  late TextEditingController _firstnameController;
  late TextEditingController _emailController;
  late TextEditingController _homeAddressController;
  late TextEditingController _companyAddressController;
  late TextEditingController _numberPhoneController;
  late TextEditingController _roleController;
  late TextEditingController _statusController;
  Uint8List? _imageBytes;
  String uploadedImageUrl = ""; // URL từ Cloudinary
  String publicId = "";
  final String defaultImageUrl =
      "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg";



  @override
  void initState() {
    super.initState();
    if(widget.user.avatar.url != null){
    uploadedImageUrl = widget.user.avatar.url!;
    publicId = widget.user.avatar.imageID;
  }
  else{
    publicId = DateTime.now().millisecondsSinceEpoch.toString();
  }
    _initializeFields();
  }


  void _initializeFields() {
    _userNameController = TextEditingController(text: widget.user.username);
    _lastnameController = TextEditingController(text: widget.user.lastName);
    _firstnameController = TextEditingController(text: widget.user.firstName);
    _emailController = TextEditingController(text: widget.user.email);
    _homeAddressController = TextEditingController(text: widget.user.homeAddress);
    _companyAddressController = TextEditingController(text: widget.user.companyAddress);
    _numberPhoneController = TextEditingController(text: widget.user.phone);
    _roleController = TextEditingController(text: widget.user.roles.join(", "));
    _statusController = TextEditingController(text: widget.user.status.name);
  }

  Future<void> _pickImage() async {
    final bytes = await ImagePickerWeb.getImageAsBytes();
    if (bytes != null) {
      setState(() {
        _imageBytes = bytes;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không có ảnh nào được chọn")),
      );
    }
  }
  @override
void didUpdateWidget(covariant UserDetail oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.user != oldWidget.user) {
    _initializeFields(); // cập nhật lại controller khi user thay đổi
  }
}

  @override
  void dispose() {
    _userNameController.dispose();
    _lastnameController.dispose();
    _firstnameController.dispose();
    _emailController.dispose();
    _homeAddressController.dispose();
    _companyAddressController.dispose();
    _numberPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ❌ Không hiển thị nút back
        title: Text(
          "${widget.user.username} / ${AppLocalizations.of(context).translate("User Detail")}",
        ),
        actions: [
          isEdit
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    Images image = Images(publicId, "", _imageBytes);
                    final UpdateInfoRequest request = UpdateInfoRequest(
                      username: _userNameController.text,
                      phoneNumber: _numberPhoneController.text,
                      homeAddress: _homeAddressController.text,
                      companyAddress: _companyAddressController.text,
                      lastName: _lastnameController.text,
                      firstName: _firstnameController.text,
                      avatar: image,
                      email: _emailController.text,
                    );

                    context.read<MainAppBloc>().add(
                          UpdatesUserInforEvent(widget.user.userId, request),
                        );
                    setState(() {
                      isEdit = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEdit = true;
                    });
                    widget.onEdit?.call();
                  },
                ),
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
                    if(isEdit)
                      TextButton.icon(
                          style: ButtonStyle(
                            iconColor: WidgetStateProperty.all(Colors.red),
                          ),
                          onPressed: () => _pickImage(),
                          icon: Icon(Icons.image),
                          label: Text(AppLocalizations.of(context).translate("Choose Image"), style: TextStyle(color: Colors.white)), 
                        ),
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
              TextFieldCustom(title: 'UserName', editController: _userNameController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'LastName', editController: _lastnameController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'FirstName', editController: _firstnameController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'HomeAddress', editController: _homeAddressController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'CompanyAddress', editController: _companyAddressController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'Email', editController: _emailController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
              TextFieldCustom(title: 'Phone', editController: _numberPhoneController, isEdit: isEdit),
              SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
