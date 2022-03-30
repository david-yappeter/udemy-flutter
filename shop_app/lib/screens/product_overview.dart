import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/drawer.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  static String routeName = '/';

  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showFavorite = false;
  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts(context)
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              switch (selectedValue) {
                case FilterOptions.favorites:
                  setState(() {
                    showFavorite = true;
                  });
                  break;
                case FilterOptions.all:
                  setState(() {
                    showFavorite = false;
                  });
                  break;
                default:
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext ctx) => [
              const PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.favorites),
              const PopupMenuItem(
                  child: Text('Show All'), value: FilterOptions.all),
            ],
          ),
          Consumer<Cart>(
            builder: (BuildContext ctx, Cart cart, Widget? child) => Badge(
              child: child as Widget,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(showFavorite: showFavorite),
      drawer: const MainDrawer(),
    );
  }
}
