// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';

import '../../../constants.dart';

class RequiredSectionTitle extends StatelessWidget {
  const RequiredSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context).translate(title),
          maxLines: 2,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding / 2,
            vertical: defaultPadding / 4,
          ),
          decoration: BoxDecoration(
              color: accentColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Text(AppLocalizations.of(context).translate("Required").toUpperCase()
            ,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: accentColor),
          ),
        )
      ],
    );
  }
}
