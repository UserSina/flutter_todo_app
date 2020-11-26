import 'dart:convert';
import 'package:http/http.dart';
import 'package:demo_flutter_app/models/todo.dart';
import 'package:demo_flutter_app/config/rest_config.dart';

class HttpService {
// GET Methods:
  Future<List<Todo>> getTodos() async {
    final response = await get(kGetUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((obj) => Todo.fromJson(obj)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

// POST Methods
  Future<Todo> postTodo(String title) async {
    final Response response = await post(
      kPostUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'userId': 1,
        'title': title,
        'completed': false,
      }),
    );
    if (response.statusCode == 201) {
      print("Returning todo");
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load todo');
    }
  }
}
