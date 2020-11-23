import 'package:flutter/material.dart';
import 'package:demo_flutter_app/models/todo.dart';
import 'package:demo_flutter_app/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> items;
  final Function removeItem;
  TodoList({this.items, this.removeItem});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: (items).map((todo) {
        return TodoItem(
          todoItem: todo,
          removeItem: removeItem,
        );
      }).toList(),
    );
  }
}
