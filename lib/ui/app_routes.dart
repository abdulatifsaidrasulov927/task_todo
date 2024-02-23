import 'package:flutter/material.dart';
import 'package:task_todo/ui/auth/login_register.dart';
import 'package:task_todo/ui/tab/home/home_screen.dart';
import 'package:task_todo/ui/tab/task/task_screen.dart';
import 'package:task_todo/ui/welcom_screen/splash_screen.dart';
import 'package:task_todo/ui/tab/tab_box.dart';
import 'package:task_todo/ui/welcom_screen/welcom_screen.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String welcomScreen = "welcom_screen";

  static const String tabBox = "/tab_box";
  static const String home = "/home_screen";
  static const String taskScreen = "/task_screen";
  static const String loginScreen = "/login_screen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.welcomScreen:
        return MaterialPageRoute(
          builder: (context) => const WelcomScreen(),
        );
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RouteNames.tabBox:
        return MaterialPageRoute(
          builder: (context) => const TabBox(),
        );
      case RouteNames.taskScreen:
        return MaterialPageRoute(
          builder: (context) => const TaskScreen(
            notifacation: false,
          ),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            isempty: false,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Route not found!")),
          ),
        );
    }
  }
}
