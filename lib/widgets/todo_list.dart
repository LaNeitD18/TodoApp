import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<Task> data;

  @override
  Widget build(BuildContext context) {
    // print('data in todo list: ' +
    //     data.map((e) => jsonEncode(e.toMap())).toList().toString());

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return TaskItem(task: data[index]);
      },
    );
  }
}
