import 'package:dio/dio.dart';

class LoginModel {
  final String username;
  final String email;
  final String password;

  LoginModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Future<FormData> getFormData() async {
    return FormData.fromMap({
      "username": username,
      "password": password,
    });
  }
}
