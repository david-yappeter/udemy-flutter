import 'package:expense_tracker/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/new_transaction_card.dart';
import 'package:expense_tracker/model/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = <Transaction>[
    Transaction(
      id: 't1',
      title: 'New shoes',
      date: DateTime.now(),
      amount: 69.9,
    ),
    Transaction(
      id: 't2',
      title: 'New shoes',
      date: DateTime.now(),
      amount: 69.9,
    ),
  ];

  // late String titleInput;
  // late String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Card(
            child: Container(
              child: Text('Chart!'),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              width: double.infinity,
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          ),
          NewTransactionCard(addTx: addNewTransaction),
          SingleChildScrollView(
            child: Column(
              children: transactions
                  .map((elem) => TransactionCard(transaction: elem))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      transactions.add(newTx);
    });
  }
}
