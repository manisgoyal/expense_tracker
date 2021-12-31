import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double) transactionHandler;
  NewTransaction(this.transactionHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amtController = TextEditingController();

  void dataSubmit() {
    final enteredTitle = titleController.text;
    final enteredAmt = double.parse(amtController.text);

    if (enteredTitle.isEmpty || enteredAmt <= 0) {
      return;
    }
    widget.transactionHandler(
      enteredTitle,
      enteredAmt,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (_) => dataSubmit()),
            TextField(
              autocorrect: false,
              decoration: const InputDecoration(labelText: "Amount"),
              controller: amtController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => dataSubmit(),
            ),
            TextButton(
                onPressed: dataSubmit,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
