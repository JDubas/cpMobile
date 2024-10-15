import 'package:flutter/material.dart';

class Item {
  final Color color;
  final String name;

  Item({
    required this.color,
    required this.name,
  });

  Item.loading() : this(color: Colors.grey, name: '...');

  bool get isLoading => name == '...';
}
