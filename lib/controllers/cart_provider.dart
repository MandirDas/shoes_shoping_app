import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class CartProvider extends ChangeNotifier {
  final _cartBox = Hive.box('cart_box');
  List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  void getCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();

    _cart = cartData.reversed.toList();
    notifyListeners();
  }

  Future<void> deleteCart(int key) async {
    await _cartBox.delete(key);
    getCart();
  }

  Future<void> createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
    getCart();
  }

  void increment(int key) {
    final item = _cartBox.get(key);
    item['qty'] += 1;
    _cartBox.put(key, item);
    getCart();
  }

  void decrement(int key) {
    final item = _cartBox.get(key);
    if (item['qty'] > 1) {
      item['qty'] -= 1;
      _cartBox.put(key, item);
      getCart();
    }
  }
}
