import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_bloc.dart';
import 'package:myparkingappadmin/bloc/main_app/main_app_event.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';

class QRScannerPage extends StatefulWidget {
  final bool isEntry;
  const QRScannerPage({super.key, required this.isEntry});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String scannedCode = 'Chưa quét thành công hoặc mã qr sai';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widget.isEntry ? Text('QR SCAN - ENTRY') : Text('QR SCAN - LEAVE')),
      body: Column(
        children: [
          SizedBox(
            height: Get.height/2,
            child: MobileScanner(
              onDetect: (capture) {
                for (final barcode in capture.barcodes) {
                  final code = barcode.rawValue;
                  if (code != null ) {
                    setState(() {
                      scannedCode = code;
                      if(code.length > 128){
                        if(widget.isEntry){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Open the barrier!'),
                              duration: Duration(seconds: 2), // Thời gian hiển thị
                            ),
                          );
                         context.read<MainAppBloc>().add(ScannerEvent(scannedCode,true));
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Close the barrier!'),
                              duration: Duration(seconds: 2), // Thời gian hiển thị
                            ),
                          );
                          context.read<MainAppBloc>().add(ScannerEvent(scannedCode,false));
                        }
                      }
                    });
                    break; // Exit loop after processing the first valid barcode
                  }
                }
              },
            ),
          ),
          Center(child: scannedCode.length > 128
          ?Text("${AppLocalizations.of(context).translate("DATA IN QR")} : $scannedCode")
          : Text("${AppLocalizations.of(context).translate("QR INVALIDED ( LEAST THAN 128 CHARACTERS )")} : $scannedCode")
           ),
        ],
      ),
    );
  }
}