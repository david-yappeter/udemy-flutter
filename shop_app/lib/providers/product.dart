import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String token) async {
    final initialFavorite = isFavorite;
    isFavorite = !initialFavorite;
    notifyListeners();

    final url = Uri.parse(
        'https://solid-daylight-332812-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'isFavorite': !initialFavorite,
          },
        ),
      );

      if (response.statusCode >= 400) {
        throw const HttpException(message: 'Could not update favorite.');
      }
    } catch (error) {
      isFavorite = initialFavorite;
      notifyListeners();
      throw HttpException(message: error.toString());
    }
  }
}
