import 'package:task_todo/model/auth.dart';
import 'package:task_todo/model/create_model.dart';
import 'package:task_todo/model/login_model.dart';
import 'package:task_todo/model/to_do_model.dart';
import 'package:task_todo/network/open_api_service.dart';

class AuthRepository {
  final OpenApiService openApiService;

  AuthRepository({required this.openApiService});

  Future<AuthenticationModel> loginUser(
      {required LoginModel loginModel}) async {
    return openApiService.loginUser(loginModel);
  }

  Future<ToDoModel> createToDo(
          {required ToDoCreateModel toDoCreateModel,
          required String bearerToken}) async =>
      openApiService.createToDo(
          toDoCreateModel: toDoCreateModel, bearerToken: bearerToken);
}
