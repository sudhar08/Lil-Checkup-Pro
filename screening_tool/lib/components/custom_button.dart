import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';


class custom_buttom extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  double textSize;
  final  button_funcation;
 final IconData? icon;
 final Color textcolor;
 final String fontfamily;
 final bool? isloading;

  custom_buttom(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      required this.backgroundColor,
      required this.textSize,
      required this.button_funcation, 
       this.icon, 
      required this.textcolor, required this.fontfamily, this.isloading,
      
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      child: CupertinoButton(
        onPressed: button_funcation,
        
        color: backgroundColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: textSize.sp, fontFamily:fontfamily,color: textcolor),
              ),
              icon == null?Text(""): Icon(
                icon,
                size: 28,
                color: textcolor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
