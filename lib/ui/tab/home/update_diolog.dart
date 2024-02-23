import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_bloc.dart';
import 'package:task_todo/model/todo_update.dart';

class UpdateToDoDialog extends StatefulWidget {
  final int id;
  final String barertoken;

  UpdateToDoDialog({required this.id, required this.barertoken});

  @override
  _UpdateToDoDialogState createState() => _UpdateToDoDialogState();
}

class _UpdateToDoDialogState extends State<UpdateToDoDialog> {
  late TextEditingController contextController;
  late TextEditingController alertController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    contextController = TextEditingController();
    alertController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    categoryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update ToDo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: contextController,
              decoration: InputDecoration(labelText: 'Context'),
            ),
            TextField(
              controller: alertController,
              decoration: InputDecoration(labelText: 'Alert'),
            ),
            TextField(
              controller: startDateController,
              decoration: InputDecoration(labelText: 'Start Date'),
            ),
            TextField(
              controller: endDateController,
              decoration: InputDecoration(labelText: 'End Date'),
            ),
            TextField(
              controller: categoryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Category'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            ToDoUpdateModel updateModel = ToDoUpdateModel(
              context: contextController.text,
              alert: alertController.text,
              startDate: startDateController.text,
              endDate: endDateController.text,
              category: int.parse(categoryController.text.isEmpty
                  ? '1'
                  : categoryController.text),
            );

            context
                .read<ToDoBloc>()
                .updateToDo(widget.id, widget.barertoken, updateModel);

            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }

  void updateToDo(ToDoUpdateModel updateModel) {
    // ToDo'yu güncelleme işlevi burada çağrılır
    // Güncelleme işlevi buraya eklenmelidir.
    print('Updating ToDo...');
    print('Context: ${updateModel.context}');
    print('Alert: ${updateModel.alert}');
    print('Start Date: ${updateModel.startDate}');
    print('End Date: ${updateModel.endDate}');
    print('Category: ${updateModel.category}');
  }
}
