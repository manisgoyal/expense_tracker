import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String txId) deleteTransaction;
  const TransactionList(this.transactions, this.deleteTransaction);
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
            : ListView(
                children: transactions.map((transac) {
                return TransactionItem(
                  key: ValueKey(transac.id),
                  transaction: transac,
                  deleteTransaction: deleteTransaction,
                );
              }).toList()));
  }
}
