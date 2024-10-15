import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa o Provider para acesso ao Catalog
import 'api/item.dart';
import 'catalog.dart'; // Importa o Catalog para gerenciar a lista de itens

class ItemTile extends StatelessWidget {
  final Item item;
  final int index; // Adiciona o índice para remover o item correto

  const ItemTile({required this.item, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: item.color,
          ),
        ),
        title: Text(item.name, style: Theme.of(context).textTheme.titleLarge),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Remove o item do catálogo usando o índice
            Provider.of<Catalog>(context, listen: false).removeItem(index);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tarefa "${item.name}" removida'),
              ),
            );
          },
        ),
      ),
    );
  }
}
