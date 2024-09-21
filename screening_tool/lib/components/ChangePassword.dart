import 'package:EarlyGrowthAndBehaviourCheck/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../utils/colors_app.dart';

class Changepasswordsheet extends StatelessWidget {
  const Changepasswordsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: apple_grey2,
                size: 22,
              )),
        ),
        // middle: Text("Change password",
        //     style: TextStyle(
        //       fontSize: 12.sp,
        //       fontFamily: 'SF-Pro-semibold',
        //     )),
      ),
      child: ListView(
        children: [
          CupertinoListTile(
              title: Text("Change password",
                  style: TextStyle(fontFamily: "SF-Pro-Bold"))),
          CupertinoFormSection(header: Text(""), children: [
            CupertinoTextFormFieldRow(
              placeholder: "Email",
            ),
            CupertinoTextFormFieldRow(
              placeholder: "Old Pasword",
            ),
            CupertinoTextFormFieldRow(
              placeholder: "New Pasword",
            ),
          ]),
          Gap(3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: custom_buttom(
                text: "change password",
                width: 50,
                height: 6,
                backgroundColor: widget_color,
                textSize: 12,
                button_funcation: (){},
                textcolor: primary_color,
                fontfamily: "SF-Pro-Bold"),
          )
        ],
      ),
    );
  }
}
