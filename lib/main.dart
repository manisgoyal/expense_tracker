import 'package:intl/intl.dart';

import '../widgets/new_transaction.dart';
import '../models/transactions.dart';
import 'package:flutter/material.dart';
import '../widgets/transactions_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'Quicksand',
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold)));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Tracker',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.purple)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Groceries', amount: 15.25, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTransac = Transaction(
        id: DateTime.now().toString(),
        title: toBeginningOfSentenceCase(txTitle).toString(),
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTransac);
    });
  }

  void bringtransacSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => bringtransacSheet(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(
            child: Card(
              child: Text(
                "CHART",
                style: TextStyle(color: Colors.greenAccent),
              ),
              elevation: 5,
              color: Colors.deepPurple,
            ),
            width: double.infinity,
          ),
          TransactionList(_userTransactions)
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => bringtransacSheet(context),
      ),
    );
  }
}
