import 'dart:typed_data';

class Images {
  String imageID;
  String? url;
  Uint8List? imageBytes;

  Images(this.imageID, this.url, this.imageBytes);

  // Hàm chuyển đối tượng thành Map (dùng để lưu trữ hoặc gửi lên server)
  Map<String, dynamic> toJson() {
    return {
      'imageID': imageID,
      'url': url,
    };
  }

  // Hàm tạo đối tượng từ Map (ví dụ từ JSON khi nhận về từ server)
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      json['imageID'] as String? ?? '',
      json['url'] as String? ?? '',
      null

    );
  }
}
