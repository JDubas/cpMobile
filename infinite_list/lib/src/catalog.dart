import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './api/item.dart';

class Catalog extends ChangeNotifier {
  final List<Item> _items = [];

  int get itemCount => _items.length;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  Item getByIndex(int index) {
    if (index < _items.length) {
      return _items[index];
    }
    return Item.loading();
  }
}
