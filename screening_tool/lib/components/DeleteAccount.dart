import 'package:EarlyGrowthAndBehaviourCheck/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colors_app.dart';

class Deleteaccountsheet extends StatelessWidget {
  const Deleteaccountsheet({super.key});

   void _showAlertDialog(BuildContext context) {
    Navigator.pop(context);

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete account'),
        content: const Text('Are you sure to Delete?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

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
        middle: Text("Account Deletion",
            style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'SF-Pro-semibold',
              )),
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          CupertinoFormSection(header: Text("Form"), children: [
            // SizedBox(
            //   height: 8.h,
            //   width: 99.w,
            //   child: CupertinoTextField(

            //     decoration: BoxDecoration(
            //       border: Border.all(color: darkColor),
            //       borderRadius: BorderRadius.circular(15)
            //     ),
            //   ))

            CupertinoTextFormFieldRow(
              placeholder: "Email",
            ),
          ]),
          // SizedBox(height: .h,),
          SizedBox(height: 1.h,),
          custom_buttom(
              text: "Delete",
              width: 60,
              height: 7,
              backgroundColor: widget_color_1,
              textSize: 14,
              button_funcation: (){_showAlertDialog(context);},
              textcolor: redcolor,
              icon: CupertinoIcons.delete,
              fontfamily: "SF-Pro-Bold"),
              SizedBox(height: 1.h,)
        ]),
      ),
    );
  }
}
