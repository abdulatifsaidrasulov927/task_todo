import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/cubit/auth/auth_cubit.dart';
import 'package:task_todo/model/login_model.dart';
import 'package:task_todo/ui/app_routes.dart';
import 'package:task_todo/ui/auth/widgets/auth_button.dart';
import 'package:task_todo/utils/color/color.dart';
import 'package:task_todo/utils/show_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
        if ((state is AuthLoadingState) ||
            (state is AuthSendCodeSuccessState)) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 100),
                    const Text('Assalomu alaykum',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    Text('Xush kelibsiz',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColor.co_969696)),
                    SizedBox(
                        height: 40 * MediaQuery.of(context).size.height / 812),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        style: const TextStyle(
                            color: AppColor.dark3, fontSize: 17),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: const InputDecoration(
                          prefixStyle: TextStyle(color: Colors.black),
                          labelText: 'ism kiriting',
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50, // Set the desired height
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        style: const TextStyle(
                            color: AppColor.dark3, fontSize: 17),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: const InputDecoration(
                          prefixStyle: TextStyle(color: Colors.black),
                          labelText: 'parol kiriting',
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AuthButton(
                onTap: () {
                  context.read<AuthCubit>().loginUser(
                      loginModel: LoginModel(
                          username: nameController.text,
                          email: '',
                          password: passwordController.text));
                },
                text: 'Tizimga kirish',
              ),
              const SizedBox(height: 30)
            ],
          ),
        );
      }, listener: (context, state) {
        if (state is AuthSendCodeSuccessState) {
          Navigator.pushReplacementNamed(context, RouteNames.tabBox);
        }

        if (state is AuthErrorState) {
          showErrorMessage(message: state.errorText, context: context);
        }
      }),
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Iltimos, ma\'lumotni kiriting';
    }
    if (value.length != 9) {
      return '9 ta belgi kiritilishi kerak';
    }
    return null;
  }
}
