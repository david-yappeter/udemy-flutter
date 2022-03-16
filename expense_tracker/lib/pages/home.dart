import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/new_transaction_card.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:expense_tracker/model/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = <Transaction>[
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't5',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't6',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't7',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't8',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't9',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
    // Transaction(
    //   id: 't10',
    //   title: 'New shoes',
    //   date: DateTime.now(),
    //   amount: 69.9,
    // ),
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

  bool _showChart = true;

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
      isScrollControlled: true,
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
    final mediaContext = MediaQuery.of(context);

    final isPortrait = mediaContext.orientation == Orientation.portrait;
    final appBar = AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showModalAddTransaction(context);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (isPortrait)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (isPortrait && _showChart)
            SizedBox(
              height: (mediaContext.size.height -
                      appBar.preferredSize.height -
                      mediaContext.padding.top) *
                  0.3,
              child: Chart(recentTransactions: _recentTransactions),
            ),
          SizedBox(
            height: (mediaContext.size.height -
                    appBar.preferredSize.height -
                    mediaContext.padding.top) *
                (isPortrait && _showChart ? 0.7 : 1),
            child: TransactionList(
              transactions: transactions,
              deleteTransaction: deleteTransaction,
            ),
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
