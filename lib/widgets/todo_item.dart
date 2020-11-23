import 'package:flutter/material.dart';
import 'package:demo_flutter_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todoItem;
  final Function removeItem;
  TodoItem({this.todoItem, this.removeItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todoItem.title,
        style: TextStyle(fontSize: 18),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.remove_circle,
          size: 22,
          color: Colors.redAccent[700],
        ),
        onPressed: () => removeItem(todoItem.id),
      ),
    );
  }
}
