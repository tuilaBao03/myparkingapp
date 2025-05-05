import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/data/request/created_transaction_request.dart';
import 'package:myparkingapp/data/response/discount_response.dart';
import 'package:myparkingapp/data/response/transaction_response.dart';
import 'package:myparkingapp/data/response/vehicle_response.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

class AppDialog {
  /// Hàm hiển thị dialog với nội dung truyền vào
  static void showErrorEvent(BuildContext context, String mess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate("error")),
          ],
        ),
        content: Text(mess),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Đóng dialog
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  static void showSuccessEvent(BuildContext context, String mess, {VoidCallback? onPress}) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 8),
                Text(AppLocalizations.of(context).translate("success")),
              ],
            ),
            content: Text(mess),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng dialog
                  if (onPress != null) onPress(); // Gọi hàm bên ngoài nếu có
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
  static void showMessage(BuildContext context, String mess) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate("info")),
          ],
        ),
        content: Text(mess),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Đóng dialog
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showDetailDiscount(BuildContext context, DiscountResponse discount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            Text("Discount Details"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(context, "DiscountCode", discount.discountCode),
            _buildInfoRow(context, "Discount Type", discount.discountType.name),
            _buildInfoRow(context, "Discount Value", discount.discountValue.toString()),
            _buildInfoRow(context, "Expire At", discount.expiredAt),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showDetailWallet(BuildContext context, WalletResponse wallet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
<<<<<<< HEAD
            Text(AppLocalizations.of(context).translate("Wallet Details")),
=======
            Text("Discount Details"),
>>>>>>> main
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(context, "Wallet Name", wallet.name),
            _buildInfoRow(context, "Balance", wallet.balance.toString()),
            _buildInfoRow(context, "Currency money", wallet.currency),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }


  static void showDetailTransaction(BuildContext context, TransactionResponse trans) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            Text("Transaction Details"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(context, "Current Balance", trans.currentBalance.toString()),
            _buildInfoRow(context, "Description", trans.description),
            _buildInfoRow(context, "Type", trans.type.toString().split('.').last),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showCreatedTransaction(BuildContext context, CreatedTransactionRequest trans) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate("Transaction Details")),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(context, "Current Balance", trans.currentBalance.toString()),
            _buildInfoRow(context, "Description", trans.description),
            _buildInfoRow(context, "Type", trans.type.toString().split('.').last),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showDetailVehicle(BuildContext context, VehicleResponse vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.directions_car, color: Colors.green),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate("Vehicle Details")),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(context, "Vehicle Type", vehicle.vehicleType.toString().split('.').last),
            _buildInfoRow(context, "License Plate", vehicle.licensePlate),
            _buildInfoRow(context, "Description", vehicle.description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppLocalizations.of(context).translate(label)}: ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).shadowColor),
          ),
          Expanded(
            child: Text(value, softWrap: true),
          ),
        ],
      ),
    );
  }


}




