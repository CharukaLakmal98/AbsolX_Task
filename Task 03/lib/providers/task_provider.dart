// providers/task_provider.dart
import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      id: 1,
      title: 'Task 1: Python & AI (30 points)',
      description:
          'Create a Python script that uses a publicly available dataset of your choice to build a simple AI model.',
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    Task(
      id: 2,
      title: 'Task 2: AI Sales Agent (20 points) ',
      description:
          'reate a simple conversational AI Sales Agent using Python that simulates sales conversations. ',
      dueDate: DateTime.now().add(const Duration(days: 5)),
    ),
    Task(
      id: 3,
      title: 'Task 3: Flutter App Development (25 points) ',
      description:
          'Develop a simple Flutter application with at least two screens: a home screen and a details screen. ',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
    Task(
      id: 4,
      title: 'Task 4: Web Development (15 points)',
      description:
          'Create a responsive landing page for a fictional product or service. ',
      dueDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      id: 5,
      title: 'Task 5: Documentation and Presentation (10 points) ',
      description:
          'Prepare a short PDF document or presentation summarizing your solutions.',
      dueDate: DateTime.now().add(const Duration(days: 4)),
    ),
  ];

  List<Task> get tasks => [..._tasks];

  Task getTaskById(int id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  void toggleTaskStatus(int id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final task = _tasks[taskIndex];
      _tasks[taskIndex] = Task(
        id: task.id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        isCompleted: !task.isCompleted,
      );
      notifyListeners();
    }
  }
}
