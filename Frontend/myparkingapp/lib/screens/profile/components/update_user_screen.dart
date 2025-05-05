// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/user/user_bloc.dart';
import 'package:myparkingapp/bloc/user/user_event.dart';
import 'package:myparkingapp/bloc/user/user_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/request/update_user_request.dart';
import 'package:myparkingapp/data/response/add_vehicle_request.dart';
import 'package:myparkingapp/data/response/images_response.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';


class EditProfileScreen extends StatefulWidget {
  
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController homeAddressController;
  late TextEditingController companyAddressController;

  List<VehicleResponse> vehicles = [

  ];
  UserResponse user = demoUser;
  Uint8List? _imageBytes;
  String uploadedImageUrl = ""; // URL từ Cloudinary
  String publicId = "";

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUserDataEvent());
  }

  Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final bytes = await image.readAsBytes();
    setState(() {
      _imageBytes = bytes;
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Không có ảnh nào được chọn")),
    );
  }
}

  void _showVehicleAdd(BuildContext context, VehicleResponse? vehicle) {
    VehicleType selectedVehicleType = VehicleType.MOTORCYCLE;
    TextEditingController licensePlateController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate("Add Vehicle")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<VehicleType>(
              value: selectedVehicleType,
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() => selectedVehicleType = newValue);
                }
              },
              items: VehicleType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
            ),
            TextFormField(
              controller: licensePlateController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context).translate("License Plate")),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context).translate("Description")),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).translate("Cancel")),
          ),
          ElevatedButton(
            onPressed: () {
              CreateVehicleRequest request = CreateVehicleRequest(
                userId: user.userID, // Bạn có thể sinh ID mới nếu cần
                vehicleType: selectedVehicleType,
                licensePlate: licensePlateController.text,
                description: descriptionController.text,
              );
              // vehicles.add(request);
              context.read<UserBloc>().add(AddNewVehicle( request));
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context).translate("Save")),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Update Profile")),
        backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
                // ignore: deprecated_member_use
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.zero,
              ),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context)
            ),
          ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if(state is UserLoadingState){
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent, size: 18));
          }
          if (state is UserLoadedState) {
            user = state.user;
            vehicles = state.user.vehicles;
            usernameController = TextEditingController(text: user.username);
            firstNameController = TextEditingController(text: user.firstName);
            lastNameController = TextEditingController(text: user.lastName);
            emailController = TextEditingController(text: user.email);
            phoneController = TextEditingController(text: user.phone);
            homeAddressController = TextEditingController(text: user.homeAddress);
            companyAddressController = TextEditingController(text: user.companyAddress);
            if(user.avatar.url != null && user.avatar.imagesID != ""){
              uploadedImageUrl = user.avatar.url!;
              publicId = user.avatar.imagesID;
            }
            else{
              publicId = DateTime.now().millisecondsSinceEpoch.toString();
            }
            vehicles = state.user.vehicles;
            user = state.user;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: _imageBytes != null
                      ? Image.memory(_imageBytes!, fit: BoxFit.scaleDown)
                      : Image.network(user.avatar.url!, fit: BoxFit.scaleDown),
                    ),
                    SizedBox(height: 10),
                    TextButton.icon(
                        style: ButtonStyle(
                          iconColor: WidgetStateProperty.all(Colors.red),
                        ),
                        onPressed: () => _pickImage(),
                        icon: Icon(Icons.image),
                        label: Text(AppLocalizations.of(context).translate("Choose Image"), style: TextStyle(color: Colors.black)),
                      ),
                  ],
                ),
              ),
                  Divider(),
                  TextField(controller: usernameController,enabled: false, decoration: InputDecoration(border: OutlineInputBorder())),
                  ...[
                     firstNameController, lastNameController,
                    emailController, phoneController, homeAddressController, companyAddressController
                  ].map((controller) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
                  )),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context).translate("Vehicles:").toUpperCase()),
                  const SizedBox(height: 10),
                  Column(
                    children: vehicles.map((vehicle) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: ListTile(
                              title: Text(vehicle.licensePlate),
                            ),
                          ),
                          IconButton(onPressed: (){
                            context.read<UserBloc>().add(DeleteVehicle(vehicle.vehicleId));
                          }, icon: Icon(Icons.delete_forever)
                      )],
                      );
                    }).toList(),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showVehicleAdd(context, null),
                    icon: Icon(Icons.add_circle_outlined),
                    label: Text(AppLocalizations.of(context).translate("Add Vehicle")),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      UpdateUserRequest userUpdate = UpdateUserRequest(
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim(),
                        homeAddress: homeAddressController.text.trim(),
                        companyAddress: companyAddressController.text.trim(),
                        avatar: ImagesResponse(publicId, "", _imageBytes),
                      );
                      context.read<UserBloc>().add(UpdateUserInfo(user, userUpdate));
                    },
                    child: Text(AppLocalizations.of(context).translate("Save Update")),
                  ),
                ],
              ),
            );
          }
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent, size: 18));
        },
        listener: (context, state) {
          if (state is UserSuccessState) {
            AppDialog.showSuccessEvent(context,AppLocalizations.of(context).translate( state.mess),onPress: (){
              context.read<UserBloc>().add(LoadUserDataEvent());
              Navigator.pop(context);
            });
          } else if (state is UserErrorState) {
            context.read<UserBloc>().add(LoadUserDataEvent());
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
