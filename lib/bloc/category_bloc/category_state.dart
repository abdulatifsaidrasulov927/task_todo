import 'package:equatable/equatable.dart';
import 'package:task_todo/model/categorie_model.dart';

abstract class CategoryState extends Equatable {}

class CategoryStateInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryStateLoadingState extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryStateSuccessState extends CategoryState {
  CategoryStateSuccessState({required this.categorieModel});

  final List<CategorieModel> categorieModel;

  @override
  List<Object?> get props => [categorieModel];
}

class CategoryStateErrorState extends CategoryState {
  CategoryStateErrorState({required this.errorText});

  final String errorText;

  @override
  List<Object?> get props => [errorText];
}
