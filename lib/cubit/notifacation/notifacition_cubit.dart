import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_todo/model/to_do_model.dart';

class NatifacitionCubit extends Cubit<bool> {
  NatifacitionCubit() : super(false);
  bool notifaction = true;
  List<ToDoModel> toDoModel = [];
  void closeNotifacition() {
    return emit(notifaction = false);
  }

  bool isEndDateToday({required List<ToDoModel> endDateList}) {
    DateTime today = DateTime.now();

    for (int i = 0; i < endDateList.length; i++) {
      DateTime endDate =
          DateTime.parse(endDateList[i].endDate.substring(0, 10));

      if (endDate.year == today.year &&
          endDate.month == today.month &&
          endDate.day == today.day) {
        return true;
      }
    }
    return false;
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}
