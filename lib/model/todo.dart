
class Todo {
  int id;
  String title;
  String body;
  bool completed;
  bool expandDong = false;
  TodoType type;
  Todo({this.title, this.body, this.completed, this.type=TodoType.Default});
}
enum TodoType{
  Default,
  Call,
  Work,
}