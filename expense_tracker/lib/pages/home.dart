import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/new_transaction_card.dart';
import 'package:expense_tracker/widgets/chart.dart';
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

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void showModalAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: NewTransactionCard(
            addTx: addNewTransaction,
          ),
          onTap: () {},
        );
      },
    );
  }

  void addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      transactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalAddTransaction(context);
            },
          ),
        ],
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Chart(recentTransactions: _recentTransactions),
          TransactionList(
            transactions: transactions,
            deleteTransaction: deleteTransaction,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalAddTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
