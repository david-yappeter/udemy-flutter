import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/auth.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/screens/edit_product.dart';
import 'package:shop_app/screens/order.dart';

import 'package:shop_app/screens/product_detail.dart';
import 'package:shop_app/screens/product_overview.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/user_product.dart';

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
          create: (BuildContext ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (BuildContext ctx) => Products('', '', null),
          update: (BuildContext ctx, Auth auth, Products? previousProducts) =>
              Products(
            auth.token as String,
            auth.userId as String,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (BuildContext ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (BuildContext ctx) => Orders('', []),
          update: (BuildContext ctx, Auth auth, Orders? previousOrder) =>
              Orders(
            auth.token as String,
            previousOrder == null ? [] : previousOrder.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
          builder: (BuildContext ctx, Auth auth, Widget? children) =>
              MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                    primarySwatch: Colors.purple,
                    colorScheme: const ColorScheme.light().copyWith(
                      secondary: Colors.deepOrange,
                    )),
                home: auth.isAuth
                    ? const ProductOverviewScreen()
                    : const AuthScreen(),
                // home: const ProductOverviewScreen(),
                routes: {
                  // ProductOverviewScreen.routeName: (BuildContext ctx) =>
                  // const ProductOverviewScreen(),
                  ProductDetailScreen.routeName: (BuildContext ctx) =>
                      const ProductDetailScreen(),
                  CartScreen.routeName: (BuildContext ctx) =>
                      const CartScreen(),
                  OrdersScreen.routeName: (BuildContext ctx) =>
                      const OrdersScreen(),
                  UserProductsScreen.routeName: (BuildContext ctx) =>
                      const UserProductsScreen(),
                  EditProductsScreen.routeName: (BuildContext ctx) =>
                      const EditProductsScreen(),
                },
              )),
    );
  }
}
