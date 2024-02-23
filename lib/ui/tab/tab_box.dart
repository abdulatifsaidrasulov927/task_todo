import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_todo/bloc/category_bloc/category_bloc.dart';
import 'package:task_todo/bloc/category_bloc/category_event.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_bloc.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_event.dart';
import 'package:task_todo/cubit/color_cubit/toglo_color_cubit.dart';
import 'package:task_todo/cubit/date_cubit.dart';
import 'package:task_todo/cubit/tab_cubit.dart';
import 'package:task_todo/data/storage_repostory.dart';
import 'package:task_todo/model/create_model.dart';
import 'package:task_todo/ui/tab/home/home_screen.dart';
import 'package:task_todo/ui/tab/task/task_screen.dart';
import 'package:task_todo/utils/images.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  int currentIndex = 0;
  @override
  void initState() {
    screens = [
      const HomeScreen(
        isempty: false,
      ),
      const TaskScreen(
        notifacation: true,
      )
    ];
    _init();
    super.initState();
  }

  String bearerToken = StorageRepository.getString("TOKEN");

  _init() async {
    BlocProvider.of<CategoryBloc>(context)
        .add(GetAllCategores(bearerToken: bearerToken));
    BlocProvider.of<ToDoBloc>(context)
        .add(GetAllToDo(bearerToken: bearerToken));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3867D5),
                  Color(0xFF81C7F5),
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          SizedBox(height: 240, child: Image.asset(AppImages.doira)),
          Positioned(
              right: 0,
              child: Image.asset(
                AppImages.doira2,
                height: 100,
              )),
          Positioned(
            top: 80,
            right: 10,
            child: Container(
              height: 50,
              width: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 4, spreadRadius: 0.1)
                ],
              ),
            ),
          )
        ]),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Brenda!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              'Today you have ${context.watch<ToDoBloc>().toDoModel.length} tasks',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: context.watch<TabCubit>().state,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.black,
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  AppSvg.home,
                  colorFilter: ColorFilter.mode(
                      currentIndex == 0 ? Colors.blue : Colors.black,
                      BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  AppSvg.task,
                  colorFilter: ColorFilter.mode(
                      currentIndex == 1 ? Colors.blue : Colors.black,
                      BlendMode.srcIn),
                ),
              )
            ],
            currentIndex: context.watch<TabCubit>().state,
            onTap: context.read<TabCubit>().changeTabIndex,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF857C3),
                  Color(0xFFF857C3),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFF456C3),
                  blurRadius: 9,
                  spreadRadius: 0,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {
                return showBottomSheet(context);
              },
              shape: const CircleBorder(
                side: BorderSide(width: 3, color: Colors.transparent),
              ),
              child: const Icon(
                Icons.add,
                size: 36, // O'zingizga qulay bo'lgan o'lchamni tanlang
                color: Colors.white, // Oq rangni tanlang
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController taskController = TextEditingController();
  DateTime now = DateTime.now();
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF857C3),
                    Color(0xFFF857C3),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFF456C3),
                    blurRadius: 9,
                    spreadRadius: 0,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  shape: const CircleBorder(
                    side: BorderSide(width: 3, color: Colors.transparent),
                  ),
                  child: SvgPicture.asset(AppSvg.cansel)),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(120, 30),
                    topRight: Radius.elliptical(120, 30),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Add new task',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: TextField(
                            controller: taskController,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                              BlocBuilder<BottomSheetCubit, BottomSheetState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                  5,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<BottomSheetCubit>(context)
                                          .toggleColor(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: state.containerColors[index],
                                      ),
                                      child: Text(
                                        'Category ${index + 1}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<DateCubit>().selectDateTime(context);
                          },
                          child: Text(
                              'start time ${context.watch<DateCubit>().selectedDate}'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<DateCubit>()
                                .selectendDateTime(context);
                          },
                          child: Text(
                              'end time ${context.watch<DateCubit>().selectedendDate}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              taskController.text.isEmpty
                                  ? print('')
                                  : BlocProvider.of<ToDoBloc>(context).add(
                                      CreateToDo(
                                          bearerToken: bearerToken,
                                          toDoCreateModel: ToDoCreateModel(
                                              context: taskController.text,
                                              alert: '15:15:00',
                                              startDate: '2024-02-22',
                                              endDate: '2024-02-22',
                                              createdAt: now.toString(),
                                              category: 1)),
                                    );
                              taskController.clear();
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(0),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.blueAccent, Colors.blue],
                                ),
                                borderRadius: BorderRadius.circular(
                                    20), // Match the button shape
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88,
                                    minHeight:
                                        60), // Set the size of the button
                                alignment: Alignment.center,
                                child: const Text(
                                  'Add Task',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
