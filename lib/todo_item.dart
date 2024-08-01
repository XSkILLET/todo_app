import 'dart:ffi';

import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  TodoItem({
    required this.title,
    required this.priority,
    required this.description,
    required this.date,
    required this.taskCompleted,
    this.deleteTask,
    super.key,
  });

  final String title;
  final String priority;
  final String description;
  final String date;
  Function()? deleteTask;

  bool taskCompleted;

  @override
  State<TodoItem> createState() {
    return _ToDoItemState();
  }
}

class _ToDoItemState extends State<TodoItem> {
  void onChangedTask(bool? isChecked) {
    setState(() {
      widget.taskCompleted = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.low_priority;

    if (widget.priority == "Urgent") {
      icon = Icons.notifications_active;
    }

    if (widget.priority == "Normal") {
      icon = Icons.list;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(value: widget.taskCompleted, onChanged: onChangedTask),
                Icon(icon),
                const SizedBox(width: 14),
                Text(widget.title,
                    style: TextStyle(
                        decoration: widget.taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                alignment: Alignment.centerRight),
                
          ],
        ),
      ),
    );
  }
}
