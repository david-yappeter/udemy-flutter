import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

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
  List<OrderItem> _orders = [];
  final String authToken;

  List<OrderItem> get orders {
    return [..._orders];
  }

  Orders(this.authToken, List<OrderItem> orders) {
    _orders = orders;
  }

  Future<void> fetchAndSetOrders(BuildContext ctx) async {
    final url = Uri.parse(
        'https://solid-daylight-332812-default-rtdb.firebaseio.com/orders.json?auth=$authToken');
    final response = await http.get(url);
    try {
      if (response.statusCode >= 400) {
        throw const HttpException(message: 'Could not fetch orders');
      } else {
        var responseBody = json.decode(response.body);
        if (responseBody == null) {
          return;
        }
        responseBody = responseBody as Map<String, dynamic>;

        final List<OrderItem> loadedOrders = [];
        responseBody.forEach((orderId, orderData) {
          loadedOrders.add(
            OrderItem(
              id: orderId,
              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price'],
                    ),
                  )
                  .toList(),
            ),
          );
        });

        _orders = loadedOrders;
        notifyListeners();
      }
    } catch (error) {
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: const Text('Failed to fetch orders'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts) async {
    final url = Uri.parse(
        'https://solid-daylight-332812-default-rtdb.firebaseio.com/orders.json?auth=$authToken');
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': DateTime.now().toString(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
          'dateTime': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode >= 400) {
        _orders.removeAt(0);
        notifyListeners();
        throw const HttpException(message: 'Could not add order.');
      }
    } catch (error) {
      _orders.removeAt(0);
      notifyListeners();
      throw HttpException(message: error.toString());
    }
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }
}
