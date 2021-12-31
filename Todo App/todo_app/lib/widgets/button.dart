import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class GetTextButton extends StatelessWidget {
  GetTextButton({
    Key? key,
    required this.btnText,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  String? btnText;
  void Function()? onPressed;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 15.h),
        textStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Text(btnText!),
      ),
    );
  }
}
