import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/model/transaction.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    final mediaContext = MediaQuery.of(context);
    final themeContext = Theme.of(context);

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text("\$${widget.transaction.amount}"),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat().format(widget.transaction.date),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: mediaContext.size.width > 460
            ? TextButton.icon(
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: themeContext.errorColor,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(
                    color: themeContext.errorColor,
                  ),
                ),
              )
            : IconButton(
                color: themeContext.errorColor,
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
              ),
      ),
    );
    // Card(
    //   margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         children: [
    //           Container(
    //             child: Text(
    //               "\$${widget.transaction.amount.toStringAsFixed(2)}",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             decoration: BoxDecoration(
    //               border: Border.all(color: Colors.black, width: 2.0),
    //             ),
    //             padding: EdgeInsets.all(10),
    //             margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    //           ),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 widget.transaction.title,
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 16,
    //                 ),
    //               ),
    //               Text(
    //                 DateFormat().format(widget.transaction.date),
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                   color: Colors.grey,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       IconButton(
    //         icon: Icon(Icons.delete),
    //         onPressed: () {
    //           widget.deleteTransaction(widget.transaction.id);
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
