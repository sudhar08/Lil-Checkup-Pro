import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:sizer/sizer.dart';

import '../utils/colors_app.dart';

class custom_buttom extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final double textSize;
  final VoidCallback button_funcation;
  final IconData? icon;
  final Color textcolor;
  final String fontfamily;
  final bool isLoading;

  custom_buttom({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.textSize,
    required this.button_funcation,
    this.icon,
    required this.textcolor,
    required this.fontfamily,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      child: CupertinoButton(
        onPressed: isLoading ? null : button_funcation,
        color: backgroundColor,
        child: Center(
          child: isLoading
              ? CupertinoActivityIndicator(radius: 10,color: primary_color,)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: textSize.sp,
                        fontFamily: fontfamily,
                        color: textcolor,
                      ),
                    ),
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          icon,
                          size: 28,
                          color: textcolor,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
