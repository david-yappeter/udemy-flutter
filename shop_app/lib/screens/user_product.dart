import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> refreshProducts(BuildContext ctx) async {
    await Provider.of<Products>(ctx, listen: false).fetchAndSetProducts(ctx);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return refreshProducts(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          // child: Container(),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (BuildContext ctx, int idx) => Column(
              children: [
                UserProductItem(
                  id: productsData.items[idx].id,
                  title: productsData.items[idx].title,
                  imageUrl: productsData.items[idx].imageUrl,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}
