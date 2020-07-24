import 'package:flutter/material.dart';

import './src/widgets/add_item.dart';
import './src/widgets/my_list.dart';

import './src/service/db_manager.dart';
import './src/service/todo.dart';

void main() => runApp(MyApp());

// Will be re-rendered when external data changes
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Will NOT be re-rendered when external data changes (persistent)
// This is because data (all_variables and functions) should NOT be reset
// To cause a re-render, change these local variables under setState() {}
class _MyAppState extends State<MyApp> {
  Future<List<Todo>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = getTodos();
  }

  List<Todo> _myTodos = [
    // Just a placeholder, can be emptied
    Todo(0, "First"),
    Todo(1, "Second"),
    Todo(0, "Third"),
  ];

  void _addItem(String itemText, BuildContext context) {
    if (itemText == "" || itemText == null) {
      print("Empty text !!");
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: const Text('Please enter a valid text'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return;
    }

    postTodo(itemText).then(
      (value) {
        setState(() {
          _myTodos.add(value);
        });
      },
    ).catchError((onError) => null);
    print("Item added: $itemText");
  }

  void _removeItem(int id) {
    setState(() {
      // Should be inside setState to cause a re-render
      _myTodos.removeWhere((item) => item.id == id);
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
            FutureBuilder<List<Todo>>(
              future: futureTodos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _myTodos = snapshot.data;
                  return Flexible(
                    child: MyList(items: _myTodos, removeItem: _removeItem),
                  );
                } else if (snapshot.hasError) {
                  // return Text("${snapshot.error}");
                  return AlertDialog(
                    title: Text("Error loading todos"),
                    content: Text("Check your internet connection !"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Okay"),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  );
                }

                // By default, show a loading spinner.
                return Container(
                  margin: EdgeInsets.all(60),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
