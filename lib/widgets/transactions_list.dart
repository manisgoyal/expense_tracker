import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart ';

class TransactionList extends StatelessWidget {
  late List<Transaction> transactions;
  final Function(String txId) deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (context, constraints) {
                return Column(
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
                    SizedBox(
                      child: Image.asset(
                        './assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                      height: constraints.maxHeight * 0.7,
                    ),
                  ],
                );
              })
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FittedBox(
                            child: Text(
                              '\$${double.parse(transactions[index].amount.toStringAsFixed(2))}',
                            ),
                          ),
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        transactions[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () =>
                            deleteTransaction(transactions[index].id),
                      ),
                    ),
                  );
                },
              ));
  }
}
