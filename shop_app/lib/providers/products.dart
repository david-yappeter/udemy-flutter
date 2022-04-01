import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shop_app/providers/product.dart';
import 'package:shop_app/models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = <Product>[
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, itemList) {
    if (itemList != null) {
      _items.addAll(itemList);
    }
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((Product product) => product.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts(BuildContext ctx,
      {bool filterByUser = false}) async {
    final url =  Uri.parse(
      filterByUser ?
      'https://solid-daylight-332812-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"' : 'https://solid-daylight-332812-default-rtdb.firebaseio.com/products.json?auth=$authToken',
    );
    final favoriteUrl = Uri.parse(
      'https://solid-daylight-332812-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw const HttpException(message: 'Could not fetch products');
      } else {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;

        final favoriteResponse = await http.get(favoriteUrl);
        final favoriteData = json.decode(favoriteResponse.body);

        final List<Product> loadedProducts = [];
        responseBody.forEach(
          (prodId, prodData) {
            loadedProducts.add(
              Product(
                id: prodId,
                title: prodData['title'],
                description: prodData['description'],
                price: prodData['price'],
                isFavorite: favoriteData == null
                    ? false
                    : favoriteData[prodId] != null
                        ? favoriteData[prodId]['isFavorite']
                        : false,
                imageUrl: prodData['imageUrl'],
              ),
            );
          },
        );
        _items = loadedProducts;
        notifyListeners();
      }
    } catch (error) {
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: const Text('Failed to fetch products'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
      'https://solid-daylight-332812-default-rtdb.firebaseio.com/products.json?auth=$authToken',
    );

    return http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavorite,
        'creatorId': userId,
      }),
    )
        .then((response) {
      final responseBody = json.decode(response.body);
      final newProduct = Product(
        id: responseBody['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url = Uri.parse(
      'https://solid-daylight-332812-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken',
    );
    await http.patch(
      url,
      body: json.encode(
        {
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        },
      ),
    );
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex < 0) return;
    _items[prodIndex] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
      'https://solid-daylight-332812-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken',
    );
    final favoriteUri = Uri.parse(
      'https://solid-daylight-332812-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken',
    );
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    http.delete(favoriteUri).catchError((error) {});

    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw const HttpException(message: 'Could not delete product.');
      } else {
        existingProduct = null;
      }
    }).catchError((error) {
      _items.insert(existingProductIndex, existingProduct as Product);
      notifyListeners();
      throw HttpException(message: error.toString());
    });
  }

  Product findById(String id) =>
      _items.firstWhere((Product product) => product.id == id);
}
