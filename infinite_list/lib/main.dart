import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'src/catalog.dart';
import 'src/api/item.dart';
import 'src/item_tile.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 480;
const double windowHeight = 854;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Lista de tarefas');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Catalog>(
      create: (context) => Catalog(),
      child: MaterialApp(
        title: 'Lista de tarefas',
        theme: ThemeData.light(),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  void _addItem() {
    final itemText = _controller.text.trim();
    if (itemText.isNotEmpty) {
      Provider.of<Catalog>(context, listen: false).addItem(
        Item(
          name: itemText,
          color: Colors.primaries[Provider.of<Catalog>(context, listen: false)
              .totalItemCount %
              Colors.primaries.length],
        ),
      );
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tarefas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Adicionar tarefa',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: Selector<Catalog, int?>(
              selector: (context, catalog) => catalog.itemCount,
              builder: (context, itemCount, child) => ReorderableListView.builder(
                itemCount: itemCount!,
                padding: const EdgeInsets.symmetric(vertical: 18),
                itemBuilder: (context, index) {
                  var catalog = Provider.of<Catalog>(context);
                  var item = catalog.getByIndex(index);
                  return Dismissible(
                    key: Key(item.name),
                    onDismissed: (direction) {
                      Provider.of<Catalog>(context, listen: false)
                          .removeItem(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tarefa "${item.name}" removida'),
                        ),
                      );
                    },
                    background: Container(color: Colors.red),
                    child: ItemTile(item: item, index: index),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex--;
                  Provider.of<Catalog>(context, listen: false)
                      .reorderItem(oldIndex, newIndex);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
