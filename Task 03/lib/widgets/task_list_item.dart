// widgets/task_list_item.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/date_formatter.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskListItem({Key? key, required this.task, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.circle_outlined,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('Due: ${DateFormatter.formatDate(task.dueDate)}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
