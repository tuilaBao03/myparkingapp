class MonthlyTicketResponse {
  String monthlyTicketID;
  String parkingSlotID;
  String userID;
  String invoiceID;
  String createdAt;
  String updateAt;
  String expiredAt;

  MonthlyTicketResponse({
    required this.monthlyTicketID,
    required this.parkingSlotID,
    required this.userID,
    required this.invoiceID,
    required this.createdAt,
    required this.updateAt,
    required this.expiredAt
  });

  factory MonthlyTicketResponse.fromJson(Map<String, dynamic> json) {
    return MonthlyTicketResponse(
      monthlyTicketID: json['monthlyTicketId'],
      userID: json['userId'],
      invoiceID: json['invoiceId'], parkingSlotID: json['parkingSlotID'], createdAt: '', updateAt: '', expiredAt: '',
    );
  }

  @override
  String toString() {
    return 'MonthlyTicket(monthlyTicketId: $monthlyTicketID, slotId: $parkingSlotID, userId: $userID, invoiceId: $invoiceID)';
  }
}
final MonthlyTicketResponse monthlyTicketDemo = MonthlyTicketResponse(
  monthlyTicketID: "MT001",
  userID: "U001",
  invoiceID: "INV001", parkingSlotID: '', createdAt: '', updateAt: '', expiredAt: '',
);
