class EntryRequest {
  String objectEncrypt;
  EntryRequest(this.objectEncrypt);
  Map<String, dynamic> toJson() {
    return {
      "objectEncrypt":objectEncrypt
    };
  }

  @override
  String toString() {
    return "objectEncrypt : $objectEncrypt";
  }
}