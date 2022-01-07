import 'package:expense_tracker/widgets/chart_bar.dart';

import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;
  Chart(this.transactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var totalSum = 0.0;
      final weekday = DateTime.now().subtract(Duration(days: index));
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekday.day &&
            transactions[i].date.month == weekday.month &&
            transactions[i].date.year == weekday.year) {
          totalSum += transactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousSum, element) {
      return previousSum + double.parse('${element['amount']}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: groupedTransactionValues.map((item) {
              return Expanded(
                child: ChartBar(
                  item['day'].toString(),
                  (item['amount'] as double),
                  (totalSpending == 0)
                      ? 0
                      : (item['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ),
    );
  }
}
