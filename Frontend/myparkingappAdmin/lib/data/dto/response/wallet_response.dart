
// ignore_for_file: non_constant_identifier_names

class WalletResponse {
  final String walletId;
  final String userId;
  final String name;
  final double balance;
  final bool status;
  final String currency;

  WalletResponse({
    required this.walletId,
    required this.userId,
    required this.name,
    required this.balance,
    required this.status,
    required this.currency,

  });

  /// **Chuyển từ JSON sang `Wallet` object**
  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      walletId: json["walletID"] ?? '',
      userId: json["userId"] ?? '',
      name: json["name"] ?? '',
      balance: (json["balance"] ?? 0).toDouble(),
      status: json["status"] ?? false,
      currency: json["currency"] ?? '',
    );
  }

  /// **Chuyển từ `Wallet` object sang JSON**
  Map<String, dynamic> toJson() {
    return {
      "walletId": walletId,
      "userId": userId,
      "name": name,
      "balance": balance,
      "status": status,
      "currency": currency,
    };
  }

  @override
  String toString() {
    return "Wallet(name: $name, balance: $balance, currency: $currency, status: $status)";
  }
}

