// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:cloudinary/cloudinary.dart';

class ImageRepository {
  Future<Cloudinary> getApiCloud() async {
    try {
      // ApiClient apiClient = ApiClient();
      // final response = await apiClient.getApiClound();
      // if (response.statusCode == 200) {
      //   final String apiKey =
      //       response.data["result"]['CLOUDINARY_API_KEY'] ?? '';
      //   final String apiSecret =
      //       response.data["result"]['CLOUDINARY_API_SECRET'] ?? '';
      //   final String cloudName =
      //       response.data["result"]['CLOUDINARY_CLOUD_NAME'] ?? '';
      //   Cloudinary cloudinary = Cloudinary.signedConfig(
      //     apiKey: apiKey,
      //     apiSecret: apiSecret,
      //     cloudName: cloudName,
      //   );
      //   return (cloudinary);
        
      // } else {
      //   throw Exception("Imagerepository_getApiCloud :");
      // }

      Cloudinary cloudinary = Cloudinary.signedConfig(
          apiKey: "459529728362519",
          apiSecret: "mb0tlF5Id1lHHe6LV0A6HY_2aw4",
          cloudName: "du1wawwby",
        );
        return (cloudinary);
    } catch (e) {
      throw Exception("ImageRepository_getApiCloud : $e");
    }
  }

  Future<CloudinaryResponse> uploadImage(Cloudinary cloud, Uint8List imageBytes,String folder, String fileName, String publicId) async {
    print("Đang gửi request upload lên Cloudinary...");
      final response = await cloud.upload(
        fileBytes: imageBytes,
        resourceType: CloudinaryResourceType.image,
        folder: folder,
        fileName: fileName,
        publicId: publicId,
        progressCallback: (count, total) {
          print('⏫ Uploading: $count/$total bytes');
        },
      );

      if (response.isSuccessful) {
        print("url : ${response.url}");
        print("publicId : ${response.publicId}");

        return response;
      } else {
        throw Exception(response.error);
      }
  }

  Future<CloudinaryResponse> deleteImage(Cloudinary cloud, String publicId, String url ) async {
    print("Đang gửi request upload lên Cloudinary...");
      final response = await
        cloud.destroy
        ( publicId,
          url: url,
        resourceType: CloudinaryResourceType.image,
        invalidate: false,
        );
      if (response.isSuccessful) {
        return response;
      } else {
        throw Exception(response.error);
      }
  }
}
