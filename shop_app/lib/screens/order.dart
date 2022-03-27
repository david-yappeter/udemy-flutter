import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/order_item.dart' as wdgt;
import 'package:shop_app/widgets/drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (BuildContext ctx, AsyncSnapshot<void> dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (BuildContext ctx, Orders orderData, Widget? child) =>
                    ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return wdgt.OrderItem(
                      order: orderData.orders[idx],
                    );
                  },
                ),
              );
            }
          }
        },
      ),
      drawer: const MainDrawer(),
    );
  }
}
