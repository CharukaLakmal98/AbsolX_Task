// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list_item.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Task Manager',
            style: TextStyle(color: Colors.white), // Change text color
          ),
        ),
        backgroundColor: Colors.blue, // Set background color
        shape: Border(
          bottom: BorderSide(
            color: Colors.white, // Set border color
            width: 2.0, // Set border width
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                final tasks = taskProvider.tasks;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: tasks[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(taskId: tasks[index].id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
