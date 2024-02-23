import 'package:dio/dio.dart';

class ToDoUpdateModel {
  String context;
  String? alert;
  String startDate;
  String endDate;
  int category;

  ToDoUpdateModel({
    required this.context,
    required this.alert,
    required this.startDate,
    required this.endDate,
    required this.category,
  });

  // JSON dönüşümü için factory metodu
  factory ToDoUpdateModel.fromJson(Map<String, dynamic> json) {
    return ToDoUpdateModel(
      context: json['context'],
      alert: json['alert'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      category: json['category'],
    );
  }

  Future<FormData> getFormData() async {
    return FormData.fromMap({
      "context": context,
      "alert": alert ?? "",
      "start_date": startDate,
      "end_date": endDate,
      "category": category.toString(),
    });
  }
}
