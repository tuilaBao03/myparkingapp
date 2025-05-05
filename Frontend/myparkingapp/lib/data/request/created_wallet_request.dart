class CreatedWalletRequest {
  double balance;
  String currency;
  String name;
  String userId;

  CreatedWalletRequest({
    required this.balance,
    required this.currency,
    required this.name,
    required this.userId,
  });
  // Convert Wallet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'currency': currency,
      'name': name,
      'userId':userId
    };
  }
}

class TopUpRequest {

  double  amount;
  String currency; // Optional
  String description; // Optional
  String walletID;

  TopUpRequest(this.amount, this.currency, this.description, this.walletID);

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'description': description,
      'walletID':walletID
    };
  }


}