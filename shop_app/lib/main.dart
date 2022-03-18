import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart.dart';

import 'package:shop_app/screens/product_detail.dart';
import 'package:shop_app/screens/product_overview.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            colorScheme: const ColorScheme.light().copyWith(
              secondary: Colors.deepOrange,
            )),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (BuildContext ctx) =>
              const ProductDetailScreen(),
          CartScreen.routeName: (BuildContext ctx) => const CartScreen(),
        },
      ),
    );
  }
}
