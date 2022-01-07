import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) transactionHandler;
  NewTransaction(this.transactionHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  DateTime _selectedDate = DateTime(1000);
  // this day can't be selected but use it to check as not-null feature is
  // being hectic so add this condition as well.
  final amtController = TextEditingController();

  void _dataSubmit() {
    if (amtController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmt = double.parse(amtController.text);

    if (enteredTitle.isEmpty ||
        enteredAmt <= 0 ||
        _selectedDate == DateTime(1000)) {
      return;
    }
    widget.transactionHandler(
      enteredTitle,
      enteredAmt,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2021,
      ),
      lastDate: DateTime.now(),
    ).then((dateSelected) {
      if (dateSelected == null) {
        return;
      }
      setState(() {
        _selectedDate = dateSelected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: "Title"),
                  controller: titleController,
                  onSubmitted: (_) => _dataSubmit()),
              TextField(
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Amount"),
                controller: amtController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _dataSubmit(),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        (_selectedDate == DateTime(1000))
                            ? 'No date Chosen'
                            : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                      ),
                    ),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _dataSubmit,
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
