import 'package:flutter/material.dart';

class AddItem extends StatelessWidget {
  final Function addItem;

  AddItem({this.addItem});

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
          width: double.infinity,
          child: TextField(
            controller: myController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Add item...',
            ),
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          height: 45,
          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: RaisedButton(
            onPressed: () => addItem(myController.text, context),
            color: Color(0xffc2bad8),
            textColor: Color(0xff483d8b),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 30,
                  color: Color(0xff483d8b),
                ),
                Text(
                  ' Add Item',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
