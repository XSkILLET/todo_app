# Flutter To-Do List App
A simple To-Do List app built with Flutter and Hive for local data storage. This app allows users to create, view, sort, and manage their tasks with ease.

#Features
- Create Tasks: Add tasks with a title, description, priority, and due date.
- Sort Tasks: Sort tasks in ascending or descending order by title.
- Persistent Storage: Store tasks locally using Hive, a lightweight and fast key-value database for Flutter.
- Task Management: Mark tasks as completed, and delete tasks when they are no longer needed.
# Getting Started
Prerequisites
To run this project, you will need:

- Flutter SDK
- Dart
- A code editor (e.g., VS Code, Android Studio)

# Project Structure
- main.dart: Entry point of the application, initializes Hive and runs the app.
- todo.dart: Contains the ToDoDatabase class that manages loading, saving, and updating the task data.
- todo_item.dart: Defines the TodoItem widget, which displays individual tasks.
- create_todo_item.dart: Provides the UI for creating new tasks.

# Usage
- Creating a Task: Press the '+' button to navigate to the task creation screen. Fill in the task details and save.
- Sorting Tasks: Use the button in the app bar to toggle between ascending and descending sort order.
- Completing/Deleting Tasks: Check off tasks when completed or delete them using the delete button.

# Dependencies
- Flutter
- Hive
- Hive Flutter Adapter
