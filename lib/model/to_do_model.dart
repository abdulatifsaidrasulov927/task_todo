import 'package:dio/dio.dart';

class ToDoModel {
  final int id;
  final String context;
  final String? alert;
  final String startDate;
  final String endDate;
  final String createdAt;
  final int category;

  ToDoModel({
    required this.id,
    required this.context,
    required this.alert,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.category,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'],
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
