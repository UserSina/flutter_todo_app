import 'package:flutter/material.dart';

import '../service/todo.dart';
import 'list_item.dart';

class MyList extends StatelessWidget {
  final List<Todo> items;
  final Function removeItem;

  MyList({this.items, this.removeItem});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: (items).map((todo) {
        return ListItem(
          todoItem: todo,
          removeItem: removeItem,
        );
      }).toList(),
    );
  }
}
