import 'package:task_todo/model/user_model.dart';

class AuthenticationModel {
  final String access;
  final String refresh;
  final UserModel user;

  AuthenticationModel({
    required this.access,
    required this.refresh,
    required this.user,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      access: json['access'],
      refresh: json['refresh'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
