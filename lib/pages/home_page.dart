import 'package:f_202010_todo_class/model/todo.dart';
import 'package:flutter/material.dart';

class ToDialog extends StatefulWidget {
  @override
  _ToDialogState createState() => _ToDialogState();
}

class _ToDialogState extends State<ToDialog> {
  TextEditingController noa = TextEditingController();
  TextEditingController umu = TextEditingController();
  String selected = 'Default';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Title',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              maxLines: 1,
              controller: noa,
              textAlign: TextAlign.center,
              onSubmitted: null,
            ),
            Text(
              'Body',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: umu,
            ),
            DropdownButton<String>(
              value: selected,
              elevation: 16,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24.0,
              items: <String>['Default', 'Call', 'Work']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  selected = newValue;
                });
              },
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text('Submit'),
              onPressed: () {
                setState(() {
                  TodoType type = TodoType.Default;
                  switch(selected){
                    case 'Work':{
                      type = TodoType.Work;
                      break;
                    }
                    case 'Call':{
                      type = TodoType.Call;
                      break;
                    }
                  }
                  Todo noaumu =
                      Todo(title: noa.text, body: umu.text, completed: false, type: type);
                  Navigator.of(context).pop(noaumu);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class HomePageTodo extends StatefulWidget {
  @override
  _HomePageTodoState createState() => _HomePageTodoState();
}

class _HomePageTodoState extends State<HomePageTodo> {

  List<Todo> todos = new List<Todo>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: _list(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, posicion) {
        var element = todos[posicion];
        return _item(element, posicion);
      },
    );
  }

  Widget _item(Todo element, int posicion) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          todos.remove(element);
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(20.0),
        color: element.completed ? Colors.green[100] : Colors.red[100],
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    _iconPick(element.type),
                    size: 48.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  element.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                FlatButton(
                  onPressed: () {
                    setState(
                      () {
                        element.completed = !element.completed;
                      },
                    );
                  },
                  child: Icon(
                    Icons.check_circle_outline,
                    color: element.completed ? Colors.green : Colors.grey,
                    size: 48.0,
                  ),
                )
              ],
            ),
            Visibility(
              visible: element.expandDong,
              child: Container(
                padding: EdgeInsets.only(left: 68),
                alignment: Alignment.centerLeft,
                child: Text(
                  element.body,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(
                  () {
                    element.expandDong = !element.expandDong;
                  },
                );
              },
              child: Icon(
                element.expandDong ? Icons.expand_more : Icons.expand_less,
                size: 48.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  IconData _iconPick(TodoType type) {
    switch (type) {
      case TodoType.Call:
        {
          return Icons.call;
        }
      case TodoType.Work:
        {
          return Icons.work;
        }
      case TodoType.Default:
        {
          return Icons.edit;
        }
    }
    return Icons.edit;
  }

  void _addTodo() async {
    final Todo noaumu = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
          return ToDialog();
        });
    if (noaumu != null) {
      setState(() {
        todos.add(noaumu);
      });
    }
  }
}

class TodoTypeDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<TodoType>(
      value: TodoType.Default,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24.0,
      items: <TodoType>[TodoType.Default, TodoType.Call, TodoType.Work]
          .map<DropdownMenuItem<TodoType>>((TodoType value) {
        return DropdownMenuItem<TodoType>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (TodoType value) {},
    );
  }
}
