// ignore_for_file: constant_identifier_names

enum TransactionType { TOP_UP, PAYMENT,DEPOSIT,RETURN_DEPOSIT }
enum TransactionStatus { COMPLETED, PENDING, FAILED }

class TransactionResponse {
  String transactionId;
  double currentBalance;
  String description;
  TransactionType type;
  String walletId;
  DateTime createAt;

  TransactionResponse({
    required this.transactionId,
    required this.currentBalance,
    required this.description,
    required this.type,
    required this.walletId,
    required this.createAt,
  });

  /// **Chuyển từ JSON sang `TransactionResponse` object**
  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      transactionId: json["transactionID"] ?? '',
      currentBalance: (json["currentBalance"] ?? 0.0).toDouble(),
      description: json["description"] ?? '',
      type: _parseTransactionType(json["type"]),
      walletId: json["walletID"] ?? '',
      createAt: DateTime.tryParse(json["timestamp"] ?? '') ?? DateTime.now(), // Corrected field name
    );
  }


  @override
  String toString() {
    return 'TransactionResponse{transactionId: $transactionId, currentBalance: $currentBalance, description: $description, type: $type, walletId: $walletId, createAt: $createAt}';
  }

  /// **Chuyển `String` thành `TransactionType`**
  static TransactionType _parseTransactionType(String? type) {
    switch (type?.toUpperCase()) {
      case "TOP_UP":
        return TransactionType.TOP_UP;
      case "PAYMENT":
        return TransactionType.PAYMENT;
      default:
        return TransactionType.PAYMENT; // Mặc định nếu dữ liệu sai
    }
  }

  /// **Chuyển `String` thành `TransactionStatus`**
  static TransactionStatus _parseTransactionStatus(String? status) {
    switch (status?.toUpperCase()) {
      case "COMPLETED":
        return TransactionStatus.COMPLETED;
      case "PENDING":
        return TransactionStatus.PENDING;
      case "FAILED":
        return TransactionStatus.FAILED;
      default:
        return TransactionStatus.PENDING; // Mặc định nếu dữ liệu sai
    }
  }
}
