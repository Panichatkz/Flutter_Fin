// lib/services/cart_service.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartService extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addToCart(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    return _items.fold(0, (total, current) => total + current.price);
  }
}
