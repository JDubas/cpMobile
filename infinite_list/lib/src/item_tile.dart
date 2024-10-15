import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/item.dart';
import 'catalog.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final int index;

  const ItemTile({required this.item, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: item.color,
            ),
          ),
          title: Text(
            item.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Provider.of<Catalog>(context, listen: false).removeItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task "${item.name}" removed'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
