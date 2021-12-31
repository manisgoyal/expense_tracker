import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart ';

class TransactionList extends StatelessWidget {
  late List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? Column(
                children: [
                  const Text(
                    'No transactions added yet!!!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Image.asset(
                      './assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                    height: 300,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                      child: Row(children: [
                    Container(
                      child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColorLight,
                        border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                            width: 3),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transactions[index].title,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22)),
                        Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: const TextStyle(
                              color: Colors.black26,
                            ))
                      ],
                    )
                  ]));
                },
              ));
  }
}
