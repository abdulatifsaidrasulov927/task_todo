import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

class DateCubit extends Cubit<DateTime> {
  DateCubit() : super(DateTime(0));

  String startDate = '';
  String endDate = '';

  dateTimeStarWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        startDate = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);
        // emit(startDate);
      },
    );
  }

  dateTimeEndWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        endDate = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);
        // emit(endDate);
      },
    );
  }

  DateTime selectedDate = DateTime(0);
  DateTime selectedendDate = DateTime(0);

  TimeOfDay? selectedTime;

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedDate = pickedDate;
        // selectedTime = pickedTime;
        emit(selectedDate);

        print('Selected date: $selectedDate, Selected time: $selectedTime');
      }
    }
  }

  Future<void> selectendDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedendDate = pickedDate;
        // selectedTime = pickedTime;
        emit(selectedendDate);

        print('Selected date: $selectedendDate, Selected time: $selectedTime');
      }
    }
  }
}
