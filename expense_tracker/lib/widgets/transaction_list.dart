import 'package:flutter/material.dart';

import 'package:expense_tracker/model/transaction.dart';
import 'package:expense_tracker/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: transactions.isNotEmpty
          ? ListView.builder(
              itemBuilder: (BuildContext ctx, int idx) => TransactionCard(
                transaction: transactions[idx],
                deleteTransaction: deleteTransaction,
              ),
              itemCount: transactions.length,
            )
          : Column(
              children: [
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
    );
  }
}
