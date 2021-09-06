import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/task_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  String convertEstimatedTimeToString(int time) {
    String hoursText = '';
    String minutesText = '';

    int hours = (time / 60).floor();
    int minutes = time - hours * 60;

    if (hours > 0) hoursText = hours.toString() + 'h';
    if (minutes > 0) minutesText = minutes.toString() + 'm';
    return hoursText + minutesText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              task.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(convertEstimatedTimeToString(task.estimatedTime)),
          Container(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text('98h69m'),
                Checkbox(
                  value: task.complete,
                  onChanged: (newState) {
                    task.complete = newState ?? false;
                    context.read<TaskProvider>().updateATask(task);
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.green,
                ),
                IconButton(
                  onPressed: () {
                    print("delete task");
                    context.read<TaskProvider>().deleteATask(task.id ?? -1);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
