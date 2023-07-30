import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transation> _recentTransations;

  const Chart({required recentTransations, super.key})
      : _recentTransations = recentTransations;

  _calculeteTotalBy(DateTime weekDay) => _recentTransations
      .where((tr) => tr.date.day == weekDay.day)
      .where((tr) => tr.date.month == weekDay.month)
      .where((tr) => tr.date.year == weekDay.year)
      .map((tr) => tr.value)
      .fold(0.0, (a, b) => a + b);

  List<Map<String, Object>> get groupedTransation {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var firstCharOfWeekDay = DateFormat.E().format(weekDay).substring(0, 1);

      final total = _calculeteTotalBy(weekDay);

      return {'day': firstCharOfWeekDay, 'value': total};
    });
  }

  double _calculatePercentageOfWeekDay(double value) {
    if (value <= 0) {
      return 0.0;
    }
    return value / _weekTotalValue;
  }

  double get _weekTotalValue =>
      groupedTransation.fold(0.0, (sum, tr) => sum + (tr['value'] as double));

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransation.isNotEmpty
              ? groupedTransation.reversed.map(
                  (tr) {
                    var value = tr['value'] as double;

                    return Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        label: tr['day'].toString(),
                        value: value,
                        percetage: _calculatePercentageOfWeekDay(value),
                      ),
                    );
                  },
                ).toList()
              : List.empty(),
        ),
      ),
    );
  }
}
