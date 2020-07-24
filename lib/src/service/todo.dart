class Todo {
  final int id;
  final String title;

  Todo(this.id, this.title);

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
