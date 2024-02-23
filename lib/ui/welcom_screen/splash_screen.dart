import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_todo/data/storage_repostory.dart';
import 'package:task_todo/ui/app_routes.dart';
import 'package:task_todo/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // isLogin();
  }

  bool checkLogged() {
    print('first == ${StorageRepository.getString("first")}');
    if (StorageRepository.getString("first").isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void navigate() async {
    Timer(const Duration(milliseconds: 5500), () {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    });
  }

  void isLogin() async {
    Timer(const Duration(milliseconds: 5500), () {
      if (checkLogged()) {
        Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.tabBox);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(34.0),
                child: Image.asset(AppImages.taskDone),
              ),
              const Text(
                'Reminders made simple',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                onPressed: () async {
                  await StorageRepository.putString("first", 'ok');

                  Navigator.pushReplacementNamed(
                      context, RouteNames.loginScreen);
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
                      colors: [Colors.lightGreenAccent, Colors.green],
                    ),
                    borderRadius:
                        BorderRadius.circular(20), // Match the button shape
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                        minWidth: 88,
                        minHeight: 60), // Set the size of the button
                    alignment: Alignment.center,
                    child: const Text(
                      'Get Started',
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
            ],
          ),
        ),
      ),
    );
  }
}
