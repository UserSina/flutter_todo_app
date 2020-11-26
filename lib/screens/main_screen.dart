import 'package:demo_flutter_app/models/todo.dart';
import 'package:demo_flutter_app/service/http_service.dart';
import 'package:demo_flutter_app/widgets/add_item.dart';
import 'package:demo_flutter_app/widgets/todo_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HttpService _httpService = new HttpService();
  Future<List<Todo>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = _httpService.getTodos();
  }

  List<Todo> _myTodos = [];

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

    _httpService.postTodo(itemText).then(
      (value) {
        setState(() {
          _myTodos.add(value);
        });
      },
    ).catchError(
      (onError) => () {
        print("Error inserting");
      },
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Todo App",
          style: TextStyle(fontSize: 25),
        ),
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
                  child: TodoList(items: _myTodos, removeItem: _removeItem),
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
    );
  }
}
