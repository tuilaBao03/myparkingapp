// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/components/welcome_text.dart';
import 'package:myparkingapp/data/response/wallet_response.dart';

class WalletItem extends StatelessWidget {
  final VoidCallback detailCard;
  final VoidCallback showTransaction;
  final void Function(WalletResponse wallet) depositMoney;
  final WalletResponse wallet;
  final void Function(WalletResponse wallet) lockWallet;

  const WalletItem({
    super.key,
    required this.detailCard,
    required this.showTransaction,
    required this.depositMoney,
    required this.wallet, required this.lockWallet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
          style: BorderStyle.solid
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        image: DecorationImage(
          image: AssetImage(
            wallet.balance > 100000000
                ? "assets/images/image_card_credit/diamond_credit.png"
                : wallet.balance >= 50000000 && wallet.balance <100000000
                    ? "assets/images/image_card_credit/golden_credit.png"
                    : "assets/images/image_card_credit/silver_credit.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex:4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 10.0, // Đặt độ nâng (bóng)
                  color: Colors.black.withOpacity(0.5), // Màu nền
                  borderRadius: BorderRadius.circular(8), // Bo góc nếu cần
                  child: Container(
                    width: Get.width/2,
                    padding: EdgeInsets.all(8),
                    child: WelcomeText(
                      text: wallet.name,
                      title: wallet.balance.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        
          Expanded(
            flex:3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(10.0),
                    backgroundColor:  WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.4)), // ✅ Đúng,
                  ),
                  onPressed: detailCard,
                  child:  Row(
                    children: [
                      Text(AppLocalizations.of(context).translate("Detail"),style: TextStyle(color: Colors.white),),
                      Spacer(),
                      Icon(Icons.details_outlined, color: Colors.green),
                    ],
                  ),
                ),
                SizedBox(height:10),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(10.0),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.4)),
                  ),
                  onPressed: showTransaction,
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context).translate("History"),style: TextStyle(color: Colors.white),),
                      Spacer(),

                      Icon(Icons.money, color: Colors.yellow),
                    ],
                  ),
                ),
                SizedBox(height:10),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(10.0),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.4)),
                  ),
                  onPressed: () => depositMoney(wallet),
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context).translate('Recharge'),style: TextStyle(color: Colors.white),),
                      Spacer(),
                      Icon(Icons.monetization_on_outlined, color: Colors.amberAccent),
                    ],
                  ),
                ),
                SizedBox(height:10),
                ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(10.0),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black.withOpacity(0.4)),
                  ),
                  onPressed: () => depositMoney(wallet),
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context).translate('Lock'),style: TextStyle(color: Colors.white),),
                      Spacer(),
                      Icon(Icons.lock, color: Colors.red),
                    ],
                  ),
                ),
            
              ],
            ),
          ),
        
        ],
      ),
    );
  }
}
