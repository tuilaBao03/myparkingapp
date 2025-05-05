class Coordinates {
  double longitude;
  double latitude;

  Coordinates({required this.longitude, required this.latitude});

  // Chuyển từ đối tượng Coordinates sang JSON
  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
