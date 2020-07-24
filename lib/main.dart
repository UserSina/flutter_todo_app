import 'package:demo_flutter_app/src/widgets/add_item.dart';
import 'package:flutter/material.dart';

import './src/widgets/add_item.dart';
import './src/widgets/my_list.dart';

void main() => runApp(MyApp());

// Will be re-rendered when external data changes
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Will NOT be re-rendered when external data changes (persistent)
// This is because data should NOT be reset
class _MyAppState extends State<MyApp> {
  final _myTodos = [
    {
      "id": 0,
      "title": "First todo item",
    },
    {
      "id": 1,
      "title": "Second todo item",
    },
    {
      "id": 2,
      "title": "Third todo item",
    },
    {
      "id": 3,
      "title": "Fourth todo item",
    },
  ];

  void _addItem(String itemText) {
    if (itemText == "" || itemText == null) {
      print("Empty text !!");
      return;
    }

    var myObj = {
      "id": 5464, // Randomize this
      "title": itemText,
    };
    setState(() {
      _myTodos.add(myObj);
    });
    print("Item added: $itemText");
  }

  void _removeItem(int id) {
    setState(() {
      // Should be inside setState to cause a re-render
      _myTodos.removeWhere((item) => item['id'] == id);
    });
    print("Item removed, index: $id");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple[900]),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Todo App", style: TextStyle(fontSize: 25)),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            AddItem(addItem: _addItem),
            Flexible(child: MyList(items: _myTodos, removeItem: _removeItem)),
          ],
        ),
      ),
    );
  }
}
