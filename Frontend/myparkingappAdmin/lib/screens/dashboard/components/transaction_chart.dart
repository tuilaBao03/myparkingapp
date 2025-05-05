import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';


class DailyTotals {
  int number;
  double budget;
  String times;
  DailyTotals(this.number, this.budget, this.times);
}

class TransactionBarChartWidget extends StatefulWidget {
  final List<TransactionResponse> data;
  final TransactionType type;

  const TransactionBarChartWidget({super.key, required this.data, required this.type});

  @override
  State<TransactionBarChartWidget> createState() => _TransactionBarChartWidgetState();
}

class _TransactionBarChartWidgetState extends State<TransactionBarChartWidget> {
  DateTime start = DateTime.now().subtract(const Duration(days: 30)); // Ngày bắt đầu
  DateTime end = DateTime.now(); // Ngày kết thúc
  TransactionType selectedType= TransactionType.PAYMENT; // Loại giao dịch mặc định
  @override
  Widget build(BuildContext context) {
    List<TransactionResponse> filteredData = widget.data.where((transaction) {
      return transaction.createAt.isAfter(start.subtract(const Duration(days: 1))) &&
             transaction.createAt.isBefore(end.add(const Duration(days: 1))) &&
             transaction.type == selectedType;
    }).toList();
    Map<int, DailyTotals> dailyMap = {}; // Lưu tổng tiền theo ngày

    for (var transaction in filteredData) {
      int dayKey = transaction.createAt.year * 10000 + 
                   transaction.createAt.month * 100 + 
                   transaction.createAt.day;
      double budget = transaction.currentBalance;
      String time = "${transaction.createAt.day}/${transaction.createAt.month}";

      if (dailyMap.containsKey(dayKey)) {
        dailyMap[dayKey]!.budget += budget; // Cộng dồn budget nếu trùng ngày
      } else {
        dailyMap[dayKey] = DailyTotals(dayKey, budget, time);
      }
    }

    List<DailyTotals> timedata = dailyMap.values.toList()..sort((a, b) => a.number.compareTo(b.number));

    List<BarChartGroupData> barGroups = timedata.map((e) {
      return BarChartGroupData(
        x: e.number, // Sử dụng ngày làm trục X
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: e.budget,
            color: widget.type == TransactionType.PAYMENT ? Colors.amber : Colors.red,
            width: 10,
            borderRadius: BorderRadius.circular(4),
          )
        ],
      );
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: start,
                    firstDate: DateTime(2023),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => start = picked);
                },
                icon: const Icon(Icons.calendar_today, color: Colors.white,),
                label: Text("From: ${start.day}/${start.month}, " ,style: TextStyle(color: Colors.white),),
              ),
              TextButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: end,
                    firstDate: start,
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => end = picked);
                },
                icon: const Icon(Icons.calendar_today, color: Colors.white,),
                label: Text("to: ${end.day}/${end.month}",style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(width: 10),
              DropdownButton<TransactionType>(
                value: selectedType,
                onChanged: (type) => setState(() => selectedType = type!),
                items: TransactionType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height*0.3,
          child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: EdgeInsets.all(8), // Thêm padding
                  tooltipRoundedRadius: 8, // Bo góc cho tooltip
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      ' ${AppLocalizations.of(context).translate("budget")} : ${rod.toY.toInt()} VNĐ', // Giá trị hiển thị
                      const TextStyle(
                        color: Colors.white, // Màu chữ
                        fontSize: 14, // Kích thước chữ
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      String item = timedata.firstWhere((e) => e.number == value.toInt()).times;
                      return Text(item, style: const TextStyle(color: Colors.white, fontSize: 10));
                    },
                  ),
                ),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: barGroups,
            ),
          ),
        ),
      ],
    );
  }
}
