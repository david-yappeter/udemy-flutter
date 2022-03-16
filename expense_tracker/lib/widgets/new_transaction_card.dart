import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionCard extends StatefulWidget {
  final Function addTx;

  NewTransactionCard({Key? key, required this.addTx}) : super(key: key);

  @override
  State<NewTransactionCard> createState() => _NewTransactionCardState();
}

class _NewTransactionCardState extends State<NewTransactionCard> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 6)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          elevation: 5,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  controller: titleController,
                  validator: (title) => title != null && title.isEmpty
                      ? 'Title is required'
                      : null,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: amountController,
                  validator: (amount) {
                    if (amount == null || amount.isEmpty) {
                      return 'Amount is required';
                    }

                    try {
                      if (double.parse(amount) <= 0) {
                        return 'Amount must be greater than 0';
                      }
                    } catch (e) {
                      return "Invalid Amount";
                    }

                    return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date',
                  ),
                  controller: TextEditingController(
                    text: _selectedDate == null
                        ? ''
                        : DateFormat.yMMMd().format(_selectedDate as DateTime),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _presentDatePicker();
                  },
                  validator: (date) =>
                      date != null && date.isEmpty ? 'Date is required' : null,
                ),
                TextButton(
                  onPressed: () {
                    final isValid = formKey.currentState?.validate();

                    if (isValid != null && isValid) {
                      widget.addTx(
                        titleController.text,
                        double.parse(amountController.text),
                        _selectedDate as DateTime,
                      );

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).viewInsets.bottom,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
