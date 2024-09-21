import 'package:EarlyGrowthAndBehaviourCheck/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colors_app.dart';

class Deleteaccountsheet extends StatelessWidget {
  const Deleteaccountsheet({super.key});

   void _showAlertDialog(BuildContext context) {
    Navigator.pop(context);

    showCupertinoDialog(
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
        middle: Text("Delete Account",
            style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'SF-Pro-semibold',
              )),
      ),
      child: Scaffold(
        body: ListView(
         // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CupertinoListTile(title: Text("Delete Account",style: TextStyle(fontFamily: "SF-Pro-Bold"),textAlign: TextAlign.center,),padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),),
            Descption(),
            
          
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
            CupertinoTextFormFieldRow(
              placeholder: "Pasword",
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



Widget Descption(){
  return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'If you wish to delete your account, please note that this action is permanent and cannot be undone. Deleting your account will result in the removal of all your personal information and your Patient records from our system.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Important Considerations:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                BulletPoint( 'All saved data, including Your personal detials, will be permanently erased.'),
                BulletPoint( 'You will lose access to any features or services associated with your account.'),
                BulletPoint( 'This action is irreversible.'),
                SizedBox(height: 10),
                Text(
                  'To proceed with account deletion, please confirm by entering your password. If you need assistance, feel free to contact our support team.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
}

Widget BulletPoint(String text){
  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 20)),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 16)),
        ),
      ],
  );
}