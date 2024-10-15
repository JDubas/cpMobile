import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/item.dart';
import 'catalog.dart';  // Supondo que você tenha uma classe Catalog que gerencia a lista de itens.

/// This is the widget responsible for building the item in the list,
/// once we have the actual data [item].
class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: item.color, // Cada item tem uma cor diferente.
          ),
        ),
        title: Text(item.name, style: Theme.of(context).textTheme.titleLarge),
        // Adicionar o botão de excluir (X)
        trailing: IconButton(
          icon: const Icon(Icons.close, color: Colors.red), // Ícone de X em vermelho
          onPressed: () {
            // Remove o item da lista usando o Provider
            Provider.of<Catalog>(context, listen: false).removeItem(item);
          },
        ),
      ),
    );
  }
}
