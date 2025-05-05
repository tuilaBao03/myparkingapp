// ignore_for_file: file_names

class MonthlyTicketResponse {
  String monthlyTicketId;
  String userId;
  String invoiceId;
  String parkingSlotId;
  DateTime createAt;
  DateTime expireAt;

  MonthlyTicketResponse({
    required this.monthlyTicketId,
    required this.userId,
    required this.invoiceId,
    required this.parkingSlotId,
    required this.createAt,
    required this.expireAt,
  });

  /// **Chuyển từ JSON sang `MonthlyTicket` object**
  factory MonthlyTicketResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyTicketResponse(
      monthlyTicketId: json["monthlyTicketId"] ?? '',
      userId: json["userId"] ?? '',
      invoiceId: json["invoiceId"] ?? '',
      parkingSlotId: json["parkingSlotId"] ?? '',
      createAt: DateTime.fromMillisecondsSinceEpoch(json["createAt"]),  // Chuyển đổi timestamp
      expireAt: DateTime.fromMillisecondsSinceEpoch(json["expireAt"]),  // Chuyển đổi timestamp
    );
  }

  /// **Chuyển từ `MonthlyTicket` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "monthlyTicketId": monthlyTicketId,
      "userId": userId,
      "invoiceId": invoiceId,
      "parkingSlotId": parkingSlotId,
      "createAt": createAt.millisecondsSinceEpoch,  // Chuyển ngược thành timestamp
      "expireAt": expireAt.millisecondsSinceEpoch,  // Chuyển ngược thành timestamp
    };
  }

  @override
  String toString() {
    return "MonthlyTicket(monthlyTicketId: $monthlyTicketId, createAt: $createAt, expireAt: $expireAt)";
  }
}
