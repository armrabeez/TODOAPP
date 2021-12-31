import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class GetTextField extends StatelessWidget {
  GetTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.inputFormatters,
    this.keyboardType,
    required this.obscureText,
    this.maxLength,
    this.validator,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.onSaved,
  }) : super(key: key);

  String? hintText;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  bool obscureText;
  int? maxLength;
  String? Function(String?)? validator;
  Widget? prefixIcon;
  BoxConstraints? prefixIconConstraints;
  void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      maxLength: maxLength,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        filled: true,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        counter: const Offstage(),
      ),
      onSaved: onSaved,
    );
  }
}
