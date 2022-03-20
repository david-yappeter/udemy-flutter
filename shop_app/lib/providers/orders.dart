import 'package:flutter/material.dart';

import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    required this.id,
    required this.products,
    required this.dateTime,
  });

  double get totalAmount {
    return products.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }
}
