import 'package:f_202010_todo_class/model/todo.dart';
import 'package:flutter/material.dart';

class HomePageTodo extends StatefulWidget {
  @override
  _HomePageTodoState createState() => _HomePageTodoState();
}

class _HomePageTodoState extends State<HomePageTodo> {
  void _showDialogue() {
    TextEditingController noa = TextEditingController();
    TextEditingController umu = TextEditingController();
    Dialog dialog = Dialog(
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
            RaisedButton(
              color: Colors.blue,
              child: Text('Submit'),
              onPressed: () {
                setState(() {
                      Navigator.of(context).pop([noa.text, umu.text]);
                });
              },
            )
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }

  List<Todo> todos = new List<Todo>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
        ),
        body: _list(),
        floatingActionButton: new FloatingActionButton(
          onPressed: _showDialogue,
          child: Icon(Icons.add),
        )
        //_addTodo, tooltip: 'Add task', child: new Icon(Icons.add)),
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
                alignment: Alignment.centerLeft,
                child: Text(
                  element.body,
                  textAlign: TextAlign.left,
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

  void _addTodo() {
    setState(() {
      todos.add(new Todo(title: "itemT", body: "itemB", completed: false));
    });
  }
}
