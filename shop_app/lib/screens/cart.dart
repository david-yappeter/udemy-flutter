import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}')),
                const Spacer(),
                TextButton(
                  child: Text(
                    'ORDER NOW',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
