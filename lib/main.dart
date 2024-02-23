import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/bloc/category_bloc/category_bloc.dart';
import 'package:task_todo/bloc/to_do_bloc/to_do_bloc.dart';
import 'package:task_todo/cubit/auth/auth_cubit.dart';
import 'package:task_todo/cubit/color_cubit/toglo_color_cubit.dart';
import 'package:task_todo/cubit/date_cubit.dart';
import 'package:task_todo/cubit/notifacation/notifacition_cubit.dart';
import 'package:task_todo/cubit/tab_cubit.dart';
import 'package:task_todo/data/storage_repostory.dart';
import 'package:task_todo/network/open_api_service.dart';
import 'package:task_todo/repositories/auth_repository.dart';
import 'package:task_todo/ui/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            openApiService: OpenApiService(context),
          ),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => ToDoBloc(
                apiService: OpenApiService(context), context: context)),
        BlocProvider(
            create: (context) => CategoryBloc(
                apiService: OpenApiService(context), context: context)),
        BlocProvider(
          create: (context) => TabCubit(),
        ),
        BlocProvider(
          create: (context) =>
              AuthCubit(authRepository: context.read<AuthRepository>()),
        ),
        BlocProvider(
          create: (context) => NatifacitionCubit(),
        ),
        BlocProvider(
          create: (context) => BottomSheetCubit(),
        ),
        BlocProvider(
          create: (context) => DateCubit(),
        ),
      ], child: const MyApp()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.welcomScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
