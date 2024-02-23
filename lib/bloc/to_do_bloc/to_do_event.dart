import 'package:equatable/equatable.dart';
import 'package:task_todo/model/create_model.dart';

abstract class ToDoEvent extends Equatable {}

class GetAllToDo extends ToDoEvent {
  final String bearerToken;
  GetAllToDo({required this.bearerToken});
  @override
  List<Object?> get props => [bearerToken];
}

class CreateToDo extends ToDoEvent {
  final String bearerToken;
  final ToDoCreateModel toDoCreateModel;
  CreateToDo({required this.bearerToken, required this.toDoCreateModel});
  @override
  List<Object?> get props => [bearerToken, toDoCreateModel];
}

class DaleteToDo extends ToDoEvent {
  final String bearerToken;
  final int id;
  DaleteToDo({required this.bearerToken, required this.id});
  @override
  List<Object?> get props => [bearerToken, id];
}
