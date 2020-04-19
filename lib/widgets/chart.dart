import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSumOfDay = 0.0;
      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalSumOfDay += transaction.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSumOfDay,
      };
    }).reversed.toList();
  }

  double get totalSpend {
    return groupedTransactionValues.fold(0.0, (previous, currentTransaction) {
      return previous + currentTransaction['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    print(totalSpend);
    return Container(
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              flex: 1,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalSpend == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpend,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
