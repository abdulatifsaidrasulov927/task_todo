import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:task_todo/model/auth.dart';
import 'package:task_todo/model/categorie_model.dart';
import 'package:task_todo/model/create_model.dart';
import 'package:task_todo/model/login_model.dart';
import 'package:task_todo/model/to_do_model.dart';
import 'package:task_todo/model/todo_update.dart';
import 'package:task_todo/model/user_model.dart';
import 'package:task_todo/ui/app_routes.dart';
import 'package:task_todo/utils/contains.dart';

class OpenApiService {
  final _dioOpen = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  OpenApiService(BuildContext context) {
    _init(context);
  }

  _init(BuildContext context) {
    _dioOpen.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            print(
                'ERRORGA KIRDI: Unauthorized request, token may be invalid or expired');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('TOKEN'); //
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Session Expired'),
                content: const Text(
                    'Your session has expired. Please log in again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate to login page
                      Navigator.pushReplacementNamed(
                          context, RouteNames.loginScreen);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            print('ERRORGA KIRDI: ${error.message} and ${error.response}');
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Session Expired'),
                content: Text('Server eror 404'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          return handler.next(error);
        },
        onRequest: (RequestOptions requestOptions, handler) async {
          print('SO\'ROV YUBORILDI: ${requestOptions.path}');
          return handler.next(requestOptions);
        },
        onResponse: (Response response, handler) async {
          print('JAVOB KELDI: ${response.requestOptions.path}');
          return handler.next(response);
        },
      ),
    );
  }

  Future<void> updateToDo(
      {required int id,
      required ToDoUpdateModel toDoUpdateModel,
      required String bearerToken}) async {
    try {
      Response response = await _dioOpen.put(
        '/api/todos/$id/',
        data: await toDoUpdateModel.getFormData(),
        options: Options(headers: {
          "Authorization": 'Bearer $bearerToken',
        }),
      );

      if (response.statusCode == 200) {
        print('ToDo updated successfully');
      } else {
        print('Failed to update ToDo');
      }
    } catch (e) {
      print('Error updating ToDo: $e');
    }
  }

  Future<AuthenticationModel> loginUser(LoginModel loginModel) async {
    try {
      Response response = await _dioOpen.post(
        '/auth/login/',
        data: {
          'username': loginModel.username,
          'email': 'user@example.com',
          'password': loginModel.password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        return AuthenticationModel.fromJson(response.data);
      } else {
        return AuthenticationModel(
            access: '', refresh: '', user: response.data);
      }
    } catch (e) {
      return AuthenticationModel(
          access: '',
          refresh: '',
          user: UserModel(
              pk: 1, username: '', email: '', firstName: '', lastName: ''));
    }
  }

  Future<List<CategorieModel>> getAllJobs({required String bearerToken}) async {
    Response response;
    try {
      response = await _dioOpen.get(
        '/api/categories/',
        options: Options(headers: {"Authorization": 'Bearer $bearerToken'}),
      );
      List<dynamic> data = response.data;
      List<CategorieModel> categorieModelList =
          data.map((json) => CategorieModel.fromJson(json)).toList();
      return categorieModelList;
    } on DioError catch (e) {
      throw Exception('Failed to fetch jobs: $e');
    }
  }

  Future<List<ToDoModel>> getAllToDo({required String bearerToken}) async {
    Response response;
    try {
      response = await _dioOpen.get(
        '/api/todo/',
        options: Options(headers: {"Authorization": 'Bearer $bearerToken'}),
      );
      List<dynamic> data = response.data;
      List<ToDoModel> toDoModel =
          data.map((json) => ToDoModel.fromJson(json)).toList();
      return toDoModel;
    } on DioError catch (e) {
      throw Exception('Failed to fetch jobs: $e');
    }
  }

  Future<ToDoModel> createToDo(
      {required ToDoCreateModel toDoCreateModel,
      required String bearerToken}) async {
    try {
      Response response = await _dioOpen.post(
        '/api/todo/',
        options: Options(headers: {"Authorization": 'Bearer $bearerToken'}),
        data: await toDoCreateModel.getFormData(),
      );
      ToDoModel toDoModel;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        toDoModel = response.data;
        return toDoModel;
      } else {
        return response.data;
      }
    } catch (error) {
      return ToDoModel(
          id: 0,
          context: '',
          alert: '',
          startDate: '',
          endDate: '',
          createdAt: '',
          category: 1);
    }
  }

  Future<void> delateToDo(
      {required int id, required String bearerToken}) async {
    try {
      Response response = await _dioOpen.delete(
        '/api/data/$id/', // O'chirish uchun URL
        options: Options(
          headers: {
            "Authorization": bearerToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Ma\'lumot o\'chirildi: $id');
      } else {
        print('Ma\'lumotni o\'chirib bo\'lmadi: $id');
      }
    } catch (e) {
      print('Xatolik yuz berdi: $e');
    }
  }
}
