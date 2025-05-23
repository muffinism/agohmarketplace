import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart.dart'; 

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => _items;

  static const _cartKey = 'cart_items';

  CartProvider() {
    _loadCartFromPrefs(); 
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity += 1;
    } else {
      _items[productId] = CartItem(
        id: productId,
        title: title,
        price: price,
        quantity: 1,
      );
    }
    notifyListeners();
    _saveCartToPrefs(); 
  }

  double get totalPrice =>
      _items.values.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = _items.values.map((item) => jsonEncode({
          'id': item.id,
          'title': item.title,
          'price': item.price,
          'quantity': item.quantity,
        })).toList();
    await prefs.setStringList(_cartKey, cartJson);
  }

  Future<void> _loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartJson = prefs.getStringList(_cartKey);

    if (cartJson != null) {
      _items = {
        for (var itemStr in cartJson)
          jsonDecode(itemStr)['id']: CartItem(
            id: jsonDecode(itemStr)['id'],
            title: jsonDecode(itemStr)['title'],
            price: jsonDecode(itemStr)['price'],
            quantity: jsonDecode(itemStr)['quantity'],
          ),
      };
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    _items.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}