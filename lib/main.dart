import '../widgets/chart.dart';
import 'package:intl/intl.dart';

import '../widgets/new_transaction.dart';
import '../models/transactions.dart';
import 'package:flutter/material.dart';
import '../widgets/transactions_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

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
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Groceries', amount: 15.25, date: DateTime.now()),
  ];
  bool _showChart = false;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      // True if last week else false
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTransac = Transaction(
        id: DateTime.now().toString(),
        title: toBeginningOfSentenceCase(txTitle).toString(),
        amount: txAmount,
        date: txDate);

    setState(() {
      _userTransactions.add(newTransac);
    });
  }

  void _bringtransacSheet(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  Widget _buildLandscapeContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Show Chart'),
        Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            })
      ],
    );
  }

  Widget _buildPotraitContent(MediaQueryData mediaQuery, AppBar appBar) {
    return SizedBox(
      child: Chart(_recentTransactions),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Expenses Tracker'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _bringtransacSheet(context),
        )
      ],
    );
    final transactionWidget = SizedBox(
      child: TransactionList(_userTransactions, _deleteTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLandscape) _buildLandscapeContent(),
              if (isLandscape)
                _showChart
                    ? SizedBox(
                        child: Chart(_recentTransactions),
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.8,
                      )
                    : transactionWidget,
              if (!isLandscape) _buildPotraitContent(mediaQuery, appBar),
              if (!isLandscape) transactionWidget,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => _bringtransacSheet(context),
      ),
    );
  }
}
