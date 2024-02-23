import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/Cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_bloc.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_event.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_state.dart';
import 'package:task_todo/cubit/notifacation/notifacition_cubit.dart';
import 'package:task_todo/data/storage_repostory.dart';
import 'package:task_todo/ui/tab/home/update_diolog.dart';
import 'package:task_todo/ui/tab/widget/notifecation_widget.dart';
import 'package:task_todo/utils/images.dart';
import 'package:task_todo/utils/show_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isempty});
  final bool isempty;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String barertoken = StorageRepository.getString('TOKEN');
    int _selectedIndex = -1;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.watch<NatifacitionCubit>().notifaction ? 160 : 1,
        flexibleSpace: context.watch<NatifacitionCubit>().notifaction
            ? const NotifacationWidget(
                taskName: 'Meeting with client', taskTime: '13.00 PM')
            : const SizedBox(),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          if (state is ToDoStateLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ToDoStateErrorState) {
            showErrorMessage(message: state.errorText, context: context);
            return Center(child: Text(state.errorText));
          }

          if (state is ToDoStateSuccessState) {
            context.watch<NatifacitionCubit>().notifaction = context
                .read<NatifacitionCubit>()
                .isEndDateToday(endDateList: state.toDoModel);
            context.watch<NatifacitionCubit>().toDoModel = state.toDoModel;
            if (state.toDoModel.isEmpty) {
              return const Center(child: Text('Empty'));
            } else {
              print('ok generate');
              return widget.isempty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 120.0,
                              left: 120.0,
                              right: 120.0,
                              bottom: 50),
                          child: Image.asset(AppImages.taskDesk),
                        ),
                        const Text(
                          'No tasks',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            ...List.generate(
                                state.toDoModel.length,
                                (index) => Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return UpdateToDoDialog(
                                                    barertoken: barertoken,
                                                    id: state
                                                        .toDoModel[index].id,
                                                  );
                                                },
                                              );
                                            },
                                            flex: 2,
                                            backgroundColor: Colors.white,
                                            foregroundColor:
                                                const Color(0xFF5F87E7),
                                            icon: Icons.edit,
                                          ),
                                          SlidableAction(
                                            onPressed: (context) {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                      'todo o`chirmoqchimisiz ?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        context
                                                            .read<ToDoBloc>()
                                                            .delateToDo(
                                                                state
                                                                    .toDoModel[
                                                                        index]
                                                                    .id,
                                                                barertoken);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text('cansel'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            backgroundColor: Colors.white,
                                            foregroundColor:
                                                const Color(0xFFFB3636),
                                            icon: const IconData(0xf4c4,
                                                fontFamily: iconFont,
                                                fontPackage: iconFontPackage),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomRight: Radius
                                                                .circular(14),
                                                            topRight:
                                                                Radius.circular(
                                                                    14),
                                                            bottomLeft: Radius
                                                                .elliptical(
                                                                    10, 3),
                                                            topLeft: Radius
                                                                .elliptical(
                                                                    10, 3)),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 1,
                                                        blurRadius: 1,
                                                        offset:
                                                            const Offset(0, 3),
                                                      )
                                                    ]),
                                                child: ListTile(
                                                  leading: Radio<int>(
                                                    value: _selectedIndex,
                                                    splashRadius: 10,
                                                    activeColor: Colors.green,
                                                    focusColor: Colors.green,
                                                    focusNode: FocusNode(),
                                                    autofocus: false,
                                                    overlayColor:
                                                        const MaterialStatePropertyAll(
                                                            Colors.green),
                                                    hoverColor: Colors.green,
                                                    toggleable: false,
                                                    fillColor:
                                                        const MaterialStatePropertyAll(
                                                            Colors.grey),
                                                    groupValue: index,
                                                    onChanged: (value) {
                                                      _selectedIndex = index;
                                                    },
                                                    mouseCursor:
                                                        MaterialStateMouseCursor
                                                            .clickable,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 12),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            context
                                                                .watch<
                                                                    NatifacitionCubit>()
                                                                .formatDateTime(state
                                                                    .toDoModel[
                                                                        index]
                                                                    .createdAt),
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        158,
                                                                        158,
                                                                        158,
                                                                        1),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          state.toDoModel[index]
                                                              .context,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .purple[900],
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  trailing: SvgPicture.asset(
                                                      AppSvg.offBell),
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(14),
                                                            topLeft:
                                                                Radius.circular(
                                                                    14))),
                                                width: 5,
                                                height: 50,
                                              ),
                                            ],
                                          )),
                                    )),
                          ],
                        ),
                      ),
                    );
            }
          }
          if (state is ToDoCreateSuccessState) {
            BlocProvider.of<ToDoBloc>(context)
                .add(GetAllToDo(bearerToken: barertoken));
          }

          print('state ==$state');
          return const SizedBox();
        },
      ),
    );
  }
}

enum SingingCharacter { lafayette, jefferson }
