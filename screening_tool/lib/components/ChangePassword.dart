import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/API/urlfile.dart';
import 'package:EarlyGrowthAndBehaviourCheck/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../utils/colors_app.dart';

class Changepasswordsheet extends StatelessWidget {
   Changepasswordsheet({super.key});

  @override

  Widget build(BuildContext context) {
TextEditingController Email_id = new TextEditingController();
TextEditingController old_password = new TextEditingController();
TextEditingController New_password = new TextEditingController();

void clear(){
  Email_id.clear();
    old_password.clear();

  New_password.clear();

}

void ChangePasswordapi() async {
   var url = ChangePasswordurl;
   
    var data = {
    "emailid":Email_id.text,
    "old_password":old_password.text,
    "new_password":New_password.text

    };

  try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (response.statusCode == 200) {
        clear();
        var message = jsonDecode(response.body);
          Fluttertoast.showToast(
                    msg: message["message"],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
      }
      else{
         Fluttertoast.showToast(
                    msg: "something went wrong",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);

      }
    } catch(e){
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      print(response.body);
      
    }

  ;


  
}










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
      ),
      child: ListView(
        children: [
          CupertinoListTile(
              title: Text("Change password",
                  style: TextStyle(fontFamily: "SF-Pro-Bold"))),
          CupertinoFormSection(header: Text(""), children: [
            CupertinoTextFormFieldRow(
              placeholder: "Email",
              controller: Email_id ,
              textInputAction: TextInputAction.next,
            ),
            CupertinoTextFormFieldRow(
              placeholder: "Old Pasword",
              controller: old_password,
              textInputAction: TextInputAction.next,
            ),
            CupertinoTextFormFieldRow(
              placeholder: "New Pasword",
              controller: New_password,
              textInputAction: TextInputAction.done,
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
                button_funcation: ChangePasswordapi,
                textcolor: primary_color,
                fontfamily: "SF-Pro-Bold"),
          )
        ],
      ),
    );
  }
}
