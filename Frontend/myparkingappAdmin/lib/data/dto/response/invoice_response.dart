enum InvoiceStatus { PENDING, PAID, CANCELLED }

class InvoiceResponse {
  String invoiceId;
  double totalAmount;
  InvoiceStatus status;
  String description;
  String parkingSlotId;
  String vehicle;
  String monthlyTicketId;
  DateTime updateAt;

  InvoiceResponse({
    required this.invoiceId,
    required this.totalAmount,
    required this.status,
    required this.description,
    required this.parkingSlotId,
    required this.vehicle,
    required this.monthlyTicketId,
    required this.updateAt,
  });

  /// **Chuyển từ JSON sang `InvoiceResponse` object**
  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
      invoiceId: json["invoiceId"] ?? '',
      totalAmount: (json["totalAmount"] ?? 0).toDouble(),
      status: _parseInvoiceStatus(json["status"]), // Sửa lỗi parsing status
      description: json["description"] ?? '',
      parkingSlotId: json["parkingSlotId"] ?? '',
      vehicle: json["vehicle"] ?? '',
      monthlyTicketId: json["monthlyTicketId"] ?? '',
      updateAt: DateTime.tryParse(json["updateAt"] ?? "") ?? DateTime.now(),
    );
  }

  /// **Chuyển từ `InvoiceResponse` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "invoiceId": invoiceId,
      "totalAmount": totalAmount,
      "status": status.name, // Chuyển enum thành string
      "description": description,
      "parkingSlotId": parkingSlotId,
      "vehicle": vehicle,
      "monthlyTicketId": monthlyTicketId,
      "updateAt": updateAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Invoice(invoiceId: $invoiceId, totalAmount: $totalAmount, status: $status)";
  }

  /// **Hàm hỗ trợ chuyển đổi `status` từ String sang `InvoiceStatus`**
  static InvoiceStatus _parseInvoiceStatus(String? status) {
    switch (status?.toUpperCase()) {
      case "PENDING":
        return InvoiceStatus.PENDING;
      case "PAID":
        return InvoiceStatus.PAID;
      case "CANCELLED":
        return InvoiceStatus.CANCELLED;
      default:
        return InvoiceStatus.PENDING; // Giá trị mặc định nếu sai
    }
  }
}
