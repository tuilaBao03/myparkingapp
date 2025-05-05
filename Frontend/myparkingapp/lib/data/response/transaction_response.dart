// ignore_for_file: constant_identifier_names

class TransactionOnPage{
  List<TransactionResponse> trans;
  int page;
  int pageTotal;
  TransactionOnPage(this.trans,this.page,this.pageTotal);
}


enum TransactionType { TOP_UP, PAYMENT,DEPOSIT,
  RETURN_DEPOSIT }

class TransactionResponse {
  String transactionID;    // Mã giao dịch
  String walletID;         // ID ví liên quan
  double currentBalance;  // Số dư sau giao dịch
  double amount;          // Số tiền giao dịch
  DateTime createAt;        // Thời gian giao dịch
  String description;         // Mô tả giao dịch
  TransactionType type;


  TransactionResponse(this.transactionID, this.walletID, this.currentBalance,
      this.amount, this.createAt, this.description,
      this.type,);

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      json['transactionID'],
      json['walletID'],
      (json['currentBalance'] as num).toDouble(),
      (json['amount'] as num).toDouble(),
      DateTime.parse(json['timestamp']),
      json['description'],
      TransactionType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => TransactionType.values.first,
      )
    );
  }

  @override
  String toString() {
    return 'TransactionResponse{transactionID: $transactionID, walletID: $walletID, currentBalance: $currentBalance, amount: $amount, createAt: $createAt, description: $description, type: $type}';
  }


}

