import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:gap/gap.dart';

import 'package:http/http.dart' as http;

import 'package:sizer/sizer.dart';

import '../utils/colors_app.dart';
//D:\github\screening\screening_tool\lib\screens\views\tabview\screening_tool.dart
class serach_bar extends StatelessWidget {
  
  //final TextEditingController controller;
  const serach_bar({super.key,  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    void ccc(){
      
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10 ),
      child: SizedBox(
        width: 380,
      
        child: CupertinoSearchTextField(
          backgroundColor: widget_color,autocorrect: true,
          placeholder: "eg: John",
          controller: controller,
         onSubmitted: (controller) {
          
         },
        ),
      ),
    );
  }
}









//patients widget










class Profile_image_widget extends StatelessWidget {
  final double width;
  final double height;
  final String image;

  const Profile_image_widget(
      {super.key,
      required this.width,
      required this.height,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(image))),
    );
  }
}







class Name_detials_outline extends StatelessWidget {
  final String name;
  final String age;
  final String parent_name;
  const Name_detials_outline(
      {super.key,
      required this.name,
      required this.age,
      required this.parent_name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          name,
          style: TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
        ),
        Text(
          age,
          style: TextStyle(fontFamily: 'SF-Pro', fontSize: 13.sp),
        ),
        Text(
          parent_name,
          style: TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
        ),
      ],
    );
  }
}
