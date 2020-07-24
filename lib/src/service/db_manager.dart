import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config//rest_config.dart' as Constants;
import './todo.dart';

// GET Methods:
Future<List<Todo>> getTodos() async {
  final response = await http.get(Constants.get_api);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    return (responseJson as List).map((obj) => Todo.fromJson(obj)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load todos');
  }
}

// POST Methods
Future<Todo> postTodo(String title) async {
  final http.Response response = await http.post(
    Constants.post_api,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'title': title,
      'completed': false,
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Todo.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
