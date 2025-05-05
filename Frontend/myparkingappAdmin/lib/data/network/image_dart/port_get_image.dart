// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, must_be_immutable

import 'dart:typed_data';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/repository/imageRepository.dart';

class ImageScreen extends StatefulWidget {
  Images? images;
  ImageScreen({super.key, this.images});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  ImageRepository imagerepository = ImageRepository();
  Uint8List? _imageBytes;
  String _uploadedImageUrl = ''; // URL từ Cloudinary
  String publicId = "";
  late final Cloudinary cloudinary;
  final String defaultImageUrl =
      "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg";

    @override
void initState() {
  super.initState();
  if(widget.images != null){
    _uploadedImageUrl = widget.images!.url!;
    publicId = widget.images!.imageID;
  }
  else{
    publicId = DateTime.now().millisecondsSinceEpoch.toString();
  }
  _initCloudinary(); // gọi mà không await
}

Future<void> _initCloudinary() async {
  cloudinary = await imagerepository.getApiCloud();
  setState(() {}); // nếu cần cập nhật UI
}


  Future<void> _pickImage() async {
    final bytes = await ImagePickerWeb.getImageAsBytes();
    if (bytes != null) {
      setState(() {
        _imageBytes = bytes;
        print(_imageBytes);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không có ảnh nào được chọn")),
      );
    }
  }

Future<void> _uploadImage() async {
  if (_imageBytes == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Chưa có ảnh để tải lên")),
    );
    return;
  }

  try {
    // Upload ảnh mới
    final uploadResponse = await imagerepository.uploadImage(
      cloudinary,
      _imageBytes!,
      "myparkingapp/parkinglots",
      publicId,
      publicId

    );

    if (uploadResponse.isSuccessful) {
      setState(() {
        _uploadedImageUrl = uploadResponse.url ?? '';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tải ảnh thành công")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tải ảnh thất bại")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Lỗi khi tải ảnh lên: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chọn ảnh")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[300],
              child: _imageBytes != null
                  ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                  : Image.network(defaultImageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text("Chọn ảnh"),
                ),
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: const Text("Thêm"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _uploadedImageUrl !='' ? Column(
              children: [
                const Text("Ảnh tải lên từ Cloudinary:"),
            const SizedBox(height: 10),
            Image.network(
                  _uploadedImageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ): SizedBox(height: 0,)
          ],
        ),
      ),
    );
  }
}
