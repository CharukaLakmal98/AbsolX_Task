// screens/details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../utils/date_formatter.dart';

class DetailsScreen extends StatelessWidget {
  final int taskId;

  const DetailsScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final Task task = taskProvider.getTaskById(taskId);

        return Scaffold(
          appBar: AppBar(title: Text('Task Details')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 8),
                    Text(
                      'Due: ${DateFormatter.formatDate(task.dueDate)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(task.description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        taskProvider.toggleTaskStatus(task.id);
                      },
                    ),
                    const Text(
                      'Mark as complete',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
