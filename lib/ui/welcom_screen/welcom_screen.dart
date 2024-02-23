import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_todo/data/storage_repostory.dart';

import 'package:task_todo/ui/app_routes.dart';

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({
    super.key,
  });

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  bool checkLogged() {
    print('TOKEN == ${StorageRepository.getString("TOKEN")}');
    if (StorageRepository.getString("TOKEN").isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void isLogin() async {
    Timer(const Duration(milliseconds: 10), () {
      if (checkLogged()) {
        if (StorageRepository.getString("first").isEmpty) {
          Navigator.pushReplacementNamed(context, RouteNames.splashScreen);
        }
        Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.tabBox);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('To do')),
    );
  }
}
