import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Map<String, Object> todoItem;
  final Function removeItem;

  ListItem({this.todoItem, this.removeItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todoItem['title'],
        style: TextStyle(fontSize: 18),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.remove_circle,
          size: 22,
          color: Colors.redAccent[700],
        ),
        onPressed: () => removeItem(todoItem['id']),
      ),
    );
  }
}
