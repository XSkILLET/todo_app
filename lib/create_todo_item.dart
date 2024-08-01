import 'package:flutter/material.dart';

import 'todo_item.dart';

class CreateToDoItem extends StatefulWidget {
  CreateToDoItem({
    super.key,
    required this.savetask,
    required this.cancelTask,
    required this.controllerTitle,
    required this.controllerDesccription,
    required this.controllerPriority,
    required this.controllerDate,
  });

  VoidCallback savetask;
  VoidCallback cancelTask;
  final controllerTitle;
  final controllerDesccription;
  final controllerPriority;
  final controllerDate;

  @override
  State<CreateToDoItem> createState() => _CreateToDoItemState();
}

List<String> dropdownItems = [
  "Urgent",
  "Normal",
  "low",
];

class _CreateToDoItemState extends State<CreateToDoItem> {
  String selectedDate = DateTime.now().toString();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(selectedDate),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked.toString();
      });
    }
  }

  String dropdownValue = dropdownItems.first;

  @override
  Widget build(BuildContext context) {
    //final _controllerTitle = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Create new Task")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: widget.controllerTitle,
                maxLines: 1,
                maxLength: 20,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  hintText: "Enter task Title",
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: widget.controllerDesccription,
                maxLength: 120,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    hintText: "Enter task description"),
              ),
              const SizedBox(height: 6),
              DropdownMenu(
                controller: widget.controllerPriority,
                inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40,
                initialSelection: dropdownItems.first,
                onSelected: _selectedItem,
                dropdownMenuEntries: dropdownItems.map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      selectedDate.split(' ')[0],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select date'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: widget.savetask,
                    child: const Text("Save"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: widget.cancelTask,
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectedItem(String? value) {
    // This is called when the user selects an item.
    setState(
      () {
        dropdownValue = value!;
      },
    );
  }
}
