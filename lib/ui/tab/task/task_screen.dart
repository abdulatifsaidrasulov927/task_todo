import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/bloc/category_bloc/category_bloc.dart';
import 'package:task_todo/bloc/category_bloc/category_state.dart';
import 'package:task_todo/cubit/notifacation/notifacition_cubit.dart';
import 'package:task_todo/ui/tab/task/widget/grid_item.dart';
import 'package:task_todo/ui/tab/widget/notifecation_widget.dart';
import 'package:task_todo/utils/images.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key, required this.notifacation});
  final bool notifacation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.watch<NatifacitionCubit>().notifaction ? 160 : 1,
        flexibleSpace: const NotifacationWidget(
            taskName: 'Meeting with client', taskTime: '13.00 PM'),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryStateLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoryStateErrorState) {
            return Center(child: Text(state.errorText));
          }

          if (state is CategoryStateSuccessState) {
            if (state.categorieModel.isEmpty) {
              return const Center(child: Text('Empty'));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: state.categorieModel.length,
                  itemBuilder: (context, index) {
                    return GridItem(
                      counttext: '',
                      icon: AppSvg.personalSvg,
                      text: state.categorieModel[index].name,
                    );
                  },
                ),
              );
            }
          }
          print(state);
          return const SizedBox();
        },
      ),
    );
  }
}
