import 'package:equatable/equatable.dart';
import 'package:task_todo/model/to_do_model.dart';

abstract class ToDoState extends Equatable {}

class ToDoStateInitial extends ToDoState {
  @override
  List<Object?> get props => [];
}

class ToDoStateLoadingState extends ToDoState {
  @override
  List<Object?> get props => [];
}

class ToDoStateSuccessState extends ToDoState {
  ToDoStateSuccessState({required this.toDoModel});

  final List<ToDoModel> toDoModel;

  @override
  List<Object?> get props => [toDoModel];
}

class ToDoStateErrorState extends ToDoState {
  ToDoStateErrorState({required this.errorText});

  final String errorText;

  @override
  List<Object?> get props => [errorText];
}

class ToDoCreateLoadingState extends ToDoState {
  @override
  List<Object?> get props => [];
}

class ToDoCreateSuccessState extends ToDoState {
  ToDoCreateSuccessState({required this.toDoModel});

  final ToDoModel toDoModel;

  @override
  List<Object?> get props => [toDoModel];
}

class ToDoCreateStateError extends ToDoState {
  ToDoCreateStateError({required this.errorText});

  final String errorText;

  @override
  List<Object?> get props => [errorText];
}
