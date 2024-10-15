import 'dart:io' show Platform;
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'src/catalog.dart';
import 'src/item_tile.dart';
import 'src/api/item.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 480;
const double windowHeight = 854;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Lista de Tarefas');
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
        title: 'Lista de Tarefas',
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
  
void _addTask() {
  final taskText = _controller.text.trim();
  if (taskText.isNotEmpty) {
    // Gerar uma cor aleatória
    final randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    Provider.of<Catalog>(context, listen: false).addItem(Item(name: taskText, color: randomColor));
    _controller.clear();
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
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
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: Selector<Catalog, int?>(
              selector: (context, catalog) => catalog.itemCount,
              builder: (context, itemCount, child) => ListView.builder(
                itemCount: itemCount,
                padding: const EdgeInsets.symmetric(vertical: 18),
                itemBuilder: (context, index) {
                  var catalog = Provider.of<Catalog>(context);
                  var item = catalog.getByIndex(index);
                  return Dismissible(
                    key: Key(item.name),
                    onDismissed: (direction) {
                      Provider.of<Catalog>(context, listen: false).removeItem(item);
                    },
                    background: Container(color: Colors.red),
                    child: ItemTile(item: item),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
