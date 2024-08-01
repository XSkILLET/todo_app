import "package:hive_flutter/hive_flutter.dart";
import "package:todolist/todo_item.dart";

class ToDoDatabase {

  List toDoList = [];


  final _myBox = Hive.box("tododatabase");

  void loadData(){
    toDoList = _myBox.get("TODO");
  }

  void createinitialData(){
    toDoList.add(TodoItem(title: "create task", priority: "Low", description: "create a task to do", taskCompleted: false, date: DateTime.now().toString(),));
  }

  void updateDatabase(){
    _myBox.put("TODO", toDoList);
  }
}