import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/provider/task_provider.dart';
import 'package:todo_app/utils/number.dart';
import 'package:todo_app/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeTextController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Add a task"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              CustomTextInput(
                controller: titleController,
                title: 'A task to do',
                hint: 'Content',
              ),
              CustomTextInput(
                controller: timeTextController,
                title: 'Estimated time to finish',
                hint: 'Minutes',
                inputType: TextInputType.number,
              ),
              TextButton(
                onPressed: () => handleAddTask(context),
                child: Container(
                  width: 80,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetInput() {
    titleController.text = '';
    timeTextController.text = '';
  }

  bool isValidInput() {
    if (titleController.text.isEmpty) {
      setState(() {
        errorMessage = 'Content of task can not be empty.';
      });
      return false;
    }

    if (timeTextController.text.isEmpty) {
      setState(() {
        errorMessage = 'Estimated time to finish can not be empty.';
      });
      return false;
    }

    if (!isNumeric(timeTextController.text)) {
      setState(() {
        errorMessage = 'Estimated time to finish must be a number (minutes).';
      });
      return false;
    }

    return true;
  }

  void handleAddTask(BuildContext context) async {
    if (!isValidInput()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notification'),
            content: Text(this.errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Ok'),
              )
            ],
          );
        },
      );
      return;
    }
    print('add task');

    Task newTask = Task.fromInput(
      titleController.text,
      int.parse(timeTextController.text),
    );

    await context.read<TaskProvider>().addATask(newTask);

    resetInput();
    Navigator.pop(context);
  }
}
