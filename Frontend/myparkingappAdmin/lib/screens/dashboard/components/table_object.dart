
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../app/localization/app_localizations.dart';
import '../../../constants.dart';


class TableObject extends StatelessWidget {

  final List<dynamic> object;
  final String title;
  final HashSet<String> objectColumnName;

  const TableObject({
    super.key, required this.object, required this.objectColumnName, required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).translate(title),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              columns: objectColumnName.map((name) => DataColumn(
                label: 
                Text(name,overflow: TextOverflow.ellipsis,
                maxLines: 1,
                ))
                ).toList(),
              rows: List.generate(
                object.length,
                (index) => recentFileDataRow(object[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
DataRow recentFileDataRow(dynamic fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
              child: Text(fileInfo.name),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date.toString())),
      DataCell(Text(fileInfo.amount)),
      DataCell(Text(fileInfo.typeMoney)),
      DataCell(Text(fileInfo.type?"Nạp":"Rút"))
    ],
  );
}


