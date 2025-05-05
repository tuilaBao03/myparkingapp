import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import '../constants.dart';

class WelcomeText extends StatelessWidget {
  final String title, text;

  const WelcomeText({super.key, required this.title, required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        Text(
          AppLocalizations.of(context).translate(title),
          style:Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.white)
              
        ),
        const SizedBox(height: defaultPadding / 2),
        Text(AppLocalizations.of(context).translate(text), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
