class WalletResponse {
  String walletId;
  double balance;
  String currency;
  String name;

  WalletResponse({
    required this.walletId,
    required this.balance,
    required this.currency,
    required this.name,
  });

  // Convert JSON to Wallet object
  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      walletId: json['walletID'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      name: json['name'] as String,
    );
  }

  // Convert Wallet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'walletId': walletId,
      'balance': balance,
      'currency': currency,
      'name': name,
    };
  }
}

List<WalletResponse> walletdemo =[
    WalletResponse(
      walletId: "W001",
      balance: 150.75,
      currency: "USD",
      name: "Main Wallet",
    ),
    WalletResponse(
      walletId: "W002",
      balance: 50.00,
      currency: "USD",
      name: "Secondary Wallet",
    ),
  ];