import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';

class DailyTotals {
  int number;
  double budget;
  String times;
  DailyTotals(this.number, this.budget, this.times);
}

class InvoiceBarChartWidget extends StatefulWidget {
  final List<InvoiceResponse> data;
  final InvoiceStatus type;

  const InvoiceBarChartWidget({super.key, required this.data, required this.type});

  @override
  State<InvoiceBarChartWidget> createState() => _InvoiceBarChartWidgetState();
}

class _InvoiceBarChartWidgetState extends State<InvoiceBarChartWidget> {
    DateTime start = DateTime.now().subtract(const Duration(days: 30)); // Ngày bắt đầu
  DateTime end = DateTime.now(); // Ngày kết thúc
  InvoiceStatus selectedType= InvoiceStatus.PAID; // Loại giao dịch mặc định
  @override
  Widget build(BuildContext context) {
    
    Map<int, DailyTotals> dailyMap = {}; 
    List<InvoiceResponse> filteredData = widget.data.where((invoice) {
      return invoice.updateAt.isAfter(start.subtract(const Duration(days: 1))) &&
             invoice.updateAt.isBefore(end.add(const Duration(days: 1))) &&
             invoice.status == selectedType;
    }).toList();
    // Lưu tổng tiền theo ngày

    for (var invoice in filteredData) {
      int dayKey = invoice.updateAt.year * 10000 + 
                   invoice.updateAt.month * 100 + 
                   invoice.updateAt.day;
      double budget = invoice.totalAmount;
      String time = "${invoice.updateAt.day}/${invoice.updateAt.month}";

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
            color: widget.type == InvoiceStatus.PAID ? Colors.lightGreenAccent : widget.type == InvoiceStatus.PENDING ? Colors.amber : Colors.red,
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
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                label: Text("Từ: ${start.day}/${start.month}",style: TextStyle(color: Colors.white),),
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
                label: Text("Đến: ${end.day}/${end.month}",style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(width: 10),
              DropdownButton<InvoiceStatus>(
                value: selectedType,
                onChanged: (type) => setState(() => selectedType = type!),
                items: InvoiceStatus.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(width: 20,),
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
