import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/bloc/category_bloc/category_event.dart';
import 'package:task_todo/bloc/category_bloc/category_state.dart';
import 'package:task_todo/model/categorie_model.dart';
import 'package:task_todo/network/open_api_service.dart';
import 'package:task_todo/ui/app_routes.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.apiService, required this.context})
      : super(CategoryStateInitial()) {
    on<GetAllCategores>(_getAllJobs);
  }

  final OpenApiService apiService;
  final BuildContext context; //
  _getAllJobs(GetAllCategores event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoadingState());

    try {
      print('boshlandi');
      List<CategorieModel> categorieModel =
          await apiService.getAllJobs(bearerToken: event.bearerToken);
      print('categorieModel ?? ${categorieModel}');

      emit(CategoryStateSuccessState(categorieModel: categorieModel));
    } on UnauthorizedException {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    } catch (e) {
      emit(CategoryStateErrorState(errorText: e.toString()));
    }
  }
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(
      {this.message = 'Unauthorized: Token may be invalid or expired'});

  @override
  String toString() => message;
}
