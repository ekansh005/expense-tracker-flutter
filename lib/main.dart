import 'package:expense_tracker/widgets/chart.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Opensans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(title: 'Expense Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Books',
      amount: 14.44,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Shoes',
      amount: 11.77,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't3',
      title: 'Books',
      amount: 14.44,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Shoes',
      amount: 11.77,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't5',
      title: 'Books',
      amount: 14.44,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Shoes',
      amount: 11.77,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't7',
      title: 'Books',
      amount: 14.44,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Shoes',
      amount: 11.77,
      date: DateTime.now().subtract(Duration(days: 1)),
    )
  ];

  List<Transaction> get _getRecentTransactions {
    return _userTransactions.where((transaction) {
      return (transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      ));
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void openAddNewTxModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (builderCtx) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        if (isLandscape)
          Switch(
            value: showChart,
            onChanged: (val) {
              setState(() {
                showChart = val;
              });
            },
          ),
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => openAddNewTxModal(context),
        )
      ],
    );
    var bodyHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openAddNewTxModal(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape)
              Container(
                height: bodyHeight * 0.3,
                child: Chart(_getRecentTransactions),
              ),
            if (!isLandscape)
              Container(
                height: bodyHeight * 0.7,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
            if (isLandscape)
              showChart
                  ? Container(
                      height: bodyHeight * 1,
                      child: Chart(_getRecentTransactions),
                    )
                  : Container(
                      height: bodyHeight * 1,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction),
                    ),
          ],
        ),
      ),
    );
  }
}
