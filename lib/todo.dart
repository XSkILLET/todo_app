import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/todo_database.dart';
import 'package:todolist/todo_item.dart';

import 'create_todo_item.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final _controllerTitle = TextEditingController();
  final _controllerDesc = TextEditingController();
  final _controllerDate = TextEditingController();
  final _controllerPriority = TextEditingController();

  final _mybox = Hive.box("tododatabase");
  ToDoDatabase db = ToDoDatabase();

  var _order = 'asc';

  @override
  void initState() {
    if (_mybox.get("TODO") == null) {
      db.createinitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  List get _orderedTodos {
    final sortedTodos = List.of(db.toDoList);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.title.compareTo(b.title);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
            onPressed: _changeOrder,
            icon: Icon(
              _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
              color: Colors.white,
            ),
            label: Text(
              'Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}',
              style: TextStyle(color: Colors.white),
            )),
      ]),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoItem(
            //key: ObjectKey(_orderedTodos[index]),
            title: _orderedTodos[index].title,
            priority: _orderedTodos[index].priority,
            description: _orderedTodos[index].description,
            taskCompleted: _orderedTodos[index].taskCompleted,
            date: _orderedTodos[index].date,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _createToDoTask, child: const Icon(Icons.add)),
    );
  }

  void _createToDoTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CreateToDoItem(
            savetask: _saveTask,
            cancelTask: () {
              Navigator.of(context).pop();
            }, controllerTitle: _controllerTitle, controllerDesccription: _controllerDesc, controllerPriority: _controllerPriority, controllerDate: _controllerDate,
          );
        },
      ),
    );
  }

  _saveTask() {
    print("---------------------------------------------------------------");
    print(_controllerTitle.text + " \n " + _controllerPriority.text+ " \n " + _controllerDesc.text + "\n"+ _controllerDate.text);
    setState(() {
      db.toDoList.add(TodoItem(
        title: _controllerTitle.text,
        priority: _controllerPriority.text,
        description: _controllerDesc.text,
        taskCompleted: false,
        date: _controllerDate.text,
      ));
      Navigator.of(context).pop(context);
      db.updateDatabase();
      _controllerDate.clear();
      _controllerTitle.clear();
      _controllerDesc.clear();
      _controllerPriority.clear();
    });
  }

  _deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDatabase();
    });
  }
}
