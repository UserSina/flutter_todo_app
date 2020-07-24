import 'dart:convert';
import 'package:http/http.dart' as http;

import './todo.dart';
import '../config//rest_config.dart' as Constants;

Future<Todo> getTodos() async {
  final response = await http.get(Constants.get_api);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // FIXME: Response is a list of todos, not a todo
    return Todo.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load todos');
  }
}

// FIXME: Finish the post
Future<http.Response> postTodo() {
  return http.post(Constants.post_api);
}
