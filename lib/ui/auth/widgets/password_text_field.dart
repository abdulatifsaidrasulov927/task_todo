import 'package:flutter/material.dart';
import 'package:task_todo/utils/color/color.dart';

class GlobalTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;

  const GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    this.controller,
  }) : super(key: key);

  @override
  _GlobalTextFieldState createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool _isPasswordVisible = false;
  late TextEditingController _internalController;
  final internalFocusNode = FocusNode();
  Color color = const Color(0xFFFAFAFA);

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _internalController,
      focusNode: internalFocusNode,
      onTapOutside: (event) {
        internalFocusNode.unfocus();
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
                splashRadius: 1,
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.co_5f8F9FA, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.co_5f8F9FA, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.co_5f8F9FA, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: AppColor.co_5f8F9FA,
        filled: true,
      ),
      style: TextStyle(color: AppColor.dark3, fontSize: 16),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.keyboardType == TextInputType.visiblePassword
          ? !_isPasswordVisible
          : false,
    );
  }
}
