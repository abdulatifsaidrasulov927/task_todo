import 'package:dio/dio.dart';

class ToDoCreateModel {
  final String context;
  final String? alert;
  final String startDate;
  final String endDate;
  final String createdAt;
  final int category;

  ToDoCreateModel({
    required this.context,
    required this.alert,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.category,
  });

  factory ToDoCreateModel.fromJson(Map<String, dynamic> json) {
    return ToDoCreateModel(
      context: json['context'],
      alert: json['alert'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      createdAt: json['created_at'],
      category: json['category'],
    );
  }

  Future<FormData> getFormData() async {
    return FormData.fromMap({
      "context": context,
      "alert": '$alert',
      "start_date": startDate,
      "end_date": endDate,
      "created_at": createdAt,
      "category": '$category',
    });
  }
}
