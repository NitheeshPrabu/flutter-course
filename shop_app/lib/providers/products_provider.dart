import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_provider.dart';
import '../models/HttpException.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> _items = [];
  final String token;

  ProductsProvider(this.token, this._items);

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> get favouriteItems {
    return _items.where((item) => item.isFavourite).toList();
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url =
        'https://flutter-shopapp-c1d1b.firebaseio.com/products.json?auth=$token';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<ProductProvider> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(ProductProvider(
          id: productId,
          description: productData['description'],
          title: productData['title'],
          price: productData['price'],
          isFavourite: productData['isFavourite'],
          imageUrl: productData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(ProductProvider product) async {
    final url =
        'https://flutter-shopapp-c1d1b.firebaseio.com/products.json?auth=$token';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavourite': product.isFavourite
          }));
      final newProduct = ProductProvider(
        description: product.description,
        id: json.decode(response.body)['name'],
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, ProductProvider newProduct) async {
    final url =
        'https://flutter-shopapp-c1d1b.firebaseio.com/products/$id.json?auth=$token';
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
        }));

    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-shopapp-c1d1b.firebaseio.com/products/$id.json?auth=$token';
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct); // optimistic update
      notifyListeners();
      throw HttpException('Could not delete the product.');
    }
    existingProduct = null;
  }
}
