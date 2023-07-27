import 'package:expenses/models/transation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transation> _recentTransations;

  const Chart({required recentTransations, super.key})
      : _recentTransations = recentTransations;

  _calculeteTotalBy(DateTime weekDay) {
    var total = 0.0;

    var transationValues = _recentTransations
        .where((tr) => tr.date.day == weekDay.day)
        .where((tr) => tr.date.month == weekDay.month)
        .where((tr) => tr.date.year == weekDay.year)
        .map((tr) => tr.value);

    if (transationValues.isNotEmpty) {
      total = transationValues.reduce((a, b) => a + b);
    }

    return total;
  }

  List<Map<String, Object>> get groupedTransation {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      //DateFormat.E().format(weekDay).substring(0, 1);

      final total = _calculeteTotalBy(weekDay);

      print(DateFormat.E().format(weekDay).substring(0, 1) +
          "=" +
          total.toString());

      return {'day': 'T', 'value': 9.99};
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransation;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
