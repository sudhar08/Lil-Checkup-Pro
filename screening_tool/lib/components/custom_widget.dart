import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class custom_widget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Widget child;
  final double borderradius;

  const custom_widget(
      {super.key,
      required this.width,
      required this.height,
      required this.backgroundColor,
      required this.child,
      required this.borderradius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width.w,
      height: this.height.h,
      decoration: BoxDecoration(
          color: backgroundColor, 
          borderRadius: BorderRadius.circular(borderradius),
          
          ),
          child: child,
    );
  }
}
