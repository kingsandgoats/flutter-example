import './chat_bars.dart';
import 'package:flutter/material.dart';
import '../models/transcations.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transcations> recentTranscation;

  Chart(this.recentTranscation);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTranscation.length; i++) {
        if (recentTranscation[i].date.day == weekDay.day &&
            recentTranscation[i].date.month == weekDay.month &&
            recentTranscation[i].date.year == weekDay.year) {
          totalSum += recentTranscation[i].price;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalMax {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map(
              (data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBars(
                    data['day'],
                    data['amount'],
                    totalMax == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalMax,
                  ),
                );
              },
            ).toList(),
          ),
        ));
  }
}
