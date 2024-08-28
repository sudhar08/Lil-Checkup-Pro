import 'package:EarlyGrowthAndBehaviourCheck/utils/colors_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../API/urlfile.dart';

class Recent_card extends StatelessWidget {
  final String patient_id;
  final String patient_name;
  final String image_path;
  const Recent_card({super.key, required this.patient_id, required this.patient_name, required this.image_path});

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
              
              backgroundImage: NetworkImage("http://$ip/screening$image_path"),
            ),
          ),
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Patient_id: $patient_id",style :TextStyle(fontFamily: 'SF-Pro-semibold',fontSize: 10.sp,color: darkColor)),
              Text("Name: $patient_name",style :TextStyle(fontFamily: 'SF-Pro-semibold',fontSize: 10.sp,color: darkColor)),

            ],
           ),
          
           
        ]),
      ),
    );
  }
}