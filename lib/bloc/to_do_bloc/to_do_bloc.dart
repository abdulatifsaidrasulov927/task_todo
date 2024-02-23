import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_event.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_state.dart';
import 'package:task_todo/model/to_do_model.dart';
import 'package:task_todo/model/todo_update.dart';
import 'package:task_todo/network/open_api_service.dart';
import 'package:task_todo/ui/app_routes.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc({required this.apiService, required this.context})
      : super(ToDoStateInitial()) {
    on<GetAllToDo>(_getAllJobs);
    on<CreateToDo>(_createToDo);
  }

  final OpenApiService apiService;
  final BuildContext context; //
  List<ToDoModel> toDoModel = [];
  _getAllJobs(GetAllToDo event, Emitter<ToDoState> emit) async {
    emit(ToDoStateLoadingState());

    try {
      toDoModel = await apiService.getAllToDo(bearerToken: event.bearerToken);
      emit(ToDoStateSuccessState(toDoModel: toDoModel));
    } on UnauthorizedException {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    } catch (e) {
      emit(ToDoStateErrorState(errorText: e.toString()));
    }
  }

  _createToDo(CreateToDo event, Emitter<ToDoState> emit) async {
    emit(ToDoCreateLoadingState());

    ToDoModel toDoModel = await apiService.createToDo(
        toDoCreateModel: event.toDoCreateModel, bearerToken: event.bearerToken);

    try {
      emit(ToDoCreateSuccessState(toDoModel: toDoModel));
    } on UnauthorizedException {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    } catch (e) {
      emit(ToDoCreateStateError(errorText: e.toString()));
    }
  }

  delateToDo(int id, String bearerToken) async {
    try {
      await apiService.delateToDo(id: id, bearerToken: bearerToken);
    } catch (e) {
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkk $e');
      ToDoStateErrorState(errorText: '$e');
    }
  }

  updateToDo(
      int id, String bearerToken, ToDoUpdateModel toDoUpdateModel) async {
    await apiService.updateToDo(
        id: id, bearerToken: bearerToken, toDoUpdateModel: toDoUpdateModel);
  }
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(
      {this.message = 'Unauthorized: Token may be invalid or expired'});

  @override
  String toString() => message;
}
