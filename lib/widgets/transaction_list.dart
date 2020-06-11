import 'package:expense_tracker/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxn;

  TransactionList(this.transactions, this.deleteTxn);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var bodyHeight = (mediaQuery.size.height - mediaQuery.padding.top);
    return Container(
      height: 550,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Divider(),
                Container(
                  child: Image.asset('images/waiting.png'),
                  height: bodyHeight * 0.4,
                )
              ],
            )
          : ListView(
              children: transactions
                  .map((e) => TransactionItem(
                        key: ValueKey(e.id),
                        transaction: e,
                        mediaQuery: mediaQuery,
                        deleteTxn: deleteTxn,
                      ))
                  .toList(),
            ),
    );
  }
}
