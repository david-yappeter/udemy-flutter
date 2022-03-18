import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  // final String title;

  const ProductDetailScreen({
    Key? key,
    // required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    final Product product = Provider.of<Products>(context)
        .items
        .firstWhere((Product product) => product.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(),
    );
  }
}
