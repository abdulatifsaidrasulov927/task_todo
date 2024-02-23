import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_todo/utils/color/color.dart';

class LoginTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final String caption;
  final ValueChanged? onChanged;
  final FocusNode? focusNode;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final EdgeInsets? contentPadding;

  const LoginTextField({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.caption = "",
    this.suffixIcon,
    this.readOnly = false,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.obscureText,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  late TextEditingController _internalController;
  final internalFocusNode = FocusNode();
  Color color = const Color(0xFFFAFAFA);

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    widget.focusNode?.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscuringCharacter: '●',
      onTapOutside: (event) {
        internalFocusNode.unfocus();
      },
      readOnly: widget.readOnly,
      controller: _internalController,
      cursorColor: Theme.of(context).dividerColor,
      focusNode: widget.focusNode ?? internalFocusNode,
      // inputFormatters: [],
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xff9e9e9e),
          height: 20 / 14,
        ),
        contentPadding: widget.contentPadding,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
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
    );
  }
}
