import 'dart:typed_data';

class ImagesResponse {
  String imagesID;
  String? url;
  Uint8List? imageBytes;

  ImagesResponse(
    this.imagesID, this.url, this.imageBytes
  );

  // Convert from JSON
  factory ImagesResponse.fromJson(Map<String, dynamic> json) {
    return ImagesResponse(
      json['imagesID'] as String? ?? '',
      json['url'] as String? ?? 'https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
      null
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'imagesID': imagesID,
      'imageURL': url,
    };
  }
}
