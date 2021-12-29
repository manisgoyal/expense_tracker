import 'package:flutter/material.dart';
import './transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Groceries', amount: 15.25, date: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: const Card(
                child: Text(
                  "CHART",
                  style: TextStyle(color: Colors.greenAccent),
                ),
                elevation: 5,
                color: Colors.deepPurple,
              ),
              width: double.infinity,
            ),
            Column(
              children: transactions.map((tx) {
                return Card(
                    child: Row(children: [
                  Container(
                    child: Text(
                      tx.amount.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueGrey,
                      border: Border.all(color: Colors.cyan, width: 3),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tx.title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      Text(tx.date.toString(),
                          style: const TextStyle(
                            color: Colors.black26,
                          ))
                    ],
                  )
                ]));
              }).toList(),
            )
          ],
        ));
  }
}
