import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'api/item.dart';

class Catalog extends ChangeNotifier {
  final List<Item> _items = [];

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  int get totalItemCount => _items.length;

  int get itemCount => _items.length;

  void addItem(Item item) {
    _items.add(item);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  void reorderItem(int oldIndex, int newIndex) {
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  Item getByIndex(int index) {
    if (index < totalItemCount) {
      return _items[index];
    }
    return Item.loading();
  }
}
