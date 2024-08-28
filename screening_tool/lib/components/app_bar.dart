import 'package:EarlyGrowthAndBehaviourCheck/utils/colors_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:sizer/sizer.dart';

import '../API/urlfile.dart';

class app_bar extends StatelessWidget {
  final String title;
  final IconData? icon;
  final doc_name;
  final String Image_path;

  const app_bar({
    super.key,
    required this.title,
    this.icon,
    required this.doc_name, required this.Image_path,
  });

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Container(
        height: 300,
        decoration: const BoxDecoration(
            gradient: appbar,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(0, 3.54)),
            ]),
        child: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon == null
                    ? Text("")
                    : Padding(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            icon,
                            size: 28,
                            color: lightColor,
                          ),
                        ),
                      ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: lightColor,
                          fontFamily: 'SF-Pro-Bold'),
                    ),
                  ),
                ),
                Gap(Size.width / 8.w),
              ],
            ),
            SizedBox(
              height: 5.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.0, left: 12),
                  child: Text(
                    "Hi\n Dr. $doc_name",
                    style: TextStyle(
                        fontFamily: 'SF-Pro', fontSize: 25, color: lightColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    width: 100,
                    height: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage("http://$ip/screening$Image_path"),
                            fit: BoxFit.cover,)),
                  ),
                )
              ],
            ),
          ],
        )));
  }
}
