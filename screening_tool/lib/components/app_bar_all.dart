// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screening_tool/components/app_bar.dart';
import 'package:screening_tool/screens/auth_screens/signuppage.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';

class appbar_default extends StatelessWidget {
  final String title;
  const appbar_default({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    
    return Container(
      width: Size.width,
      height: 100,
      decoration: BoxDecoration(
          gradient: appbar,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 219, 207, 207),
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(0, 3.54)),
          ],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
                child: Icon(
              CupertinoIcons.chevron_back,
              size: 28,
              color: lightColor,
            )),
          ),
          SizedBox(width: 5.w),
          Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18.sp, fontFamily: 'SF-Pro-Bold', color: lightColor),
            ),
          ),
          SizedBox(width: 22.w), 
        ],
      ),
    );
  }
}
