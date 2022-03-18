import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorite;

  const ProductGrid({
    Key? key,
    required this.showFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavorite ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext ctx, int idx) => ChangeNotifierProvider.value(
        value: products[idx],
        child: ProductItem(key: ValueKey(products[idx].id)),
      ),
    );
  }
}
