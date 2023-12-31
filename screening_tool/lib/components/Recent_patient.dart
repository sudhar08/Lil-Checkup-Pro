import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';

class Recent_card extends StatelessWidget {
  const Recent_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 60.w,
        height: 10.h,
        decoration: BoxDecoration(
          color: widget_color,
          borderRadius: BorderRadius.circular(20)
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
         
          SizedBox(
            width: 60,
            height: 60,
            child: CircleAvatar(
              
              backgroundImage: AssetImage("assets/images/default.jpg"),
            ),
          ),
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name: Ruban Babu ",style :TextStyle(fontFamily: 'SF-Pro',fontSize: 10.sp,color: darkColor)),
              Text("Name: Ruban Babu ",style :TextStyle(fontFamily: 'SF-Pro',fontSize: 10.sp,color: darkColor)),

            ],
           ),
          
           
        ]),
      ),
    );
  }
}