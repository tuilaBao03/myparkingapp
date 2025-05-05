import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/screens/qr_screen/qr_scan.dart';

class AppDialog {
  /// Hàm hiển thị dialog với nội dung truyền vào
  static void showErrorEvent(BuildContext context, String mess,
      {VoidCallback? onPress}) {
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
          onPress == null
              ? TextButton(
                  onPressed: () => Navigator.pop(context), // Đóng dialog
                  child: Text('OK'),
                )
              : TextButton(
                  onPressed: () => {onPress}, // Đóng dialog
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                )
        ],
      ),
    );
  }

  static void showSuccessEvent(BuildContext context, String mess,
      {VoidCallback? onPress}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info, color: Colors.blue),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context).translate("success")),
          ],
        ),
        content: Text(mess),
        actions: [
          onPress == null
              ? TextButton(
                  onPressed: () => Navigator.pop(context), // Đóng dialog
                  child: Text('OK'),
                )
              : TextButton(
                  onPressed: () => {onPress}, // Đóng dialog
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                )
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

  static void showImage(BuildContext context, Images image) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: SizedBox(
              height: Get.height / 1.5,
              width: Get.width / 1.5,
              child: Image.network(
                image.url!,
                fit: BoxFit.contain,
              ),
            )));
  }

  static void camera(BuildContext context, bool isEntry) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: SizedBox(
                height: Get.height / 1.2,
                width: Get.width / 1.5,
                child: QRScannerPage(
                  isEntry: isEntry,
                ))));
  }

  static void showInfo(BuildContext context, String mess, VoidCallback void1) {
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
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Đóng dialog
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey),
                ),
                onPressed: () => void1, // Đóng dialog
                child: const Text(
                  'Continute',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
