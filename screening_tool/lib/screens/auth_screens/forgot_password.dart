import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/API/urlfile.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/auth_screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:EarlyGrowthAndBehaviourCheck/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class Forgot_password extends StatefulWidget {
  const Forgot_password({super.key});

  @override
  State<Forgot_password> createState() => _Forgot_passwordState();
}

class _Forgot_passwordState extends State<Forgot_password> {

bool email_check(String email) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      return emailValid;
    }


void ForgetPassword() async{

    if (Email.text.isEmpty || password.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "please fill all the fields", toastLength: Toast.LENGTH_SHORT);
      } else {
        var data = {"email": Email.text, "password": password.text};

        // url to login;
        var url = forgot_url;

        if (email_check(Email.text)) {
          try {
            final response = await http.post(Uri.parse(url), body: jsonEncode(data));
            if (response.statusCode == 200) {
              var message =   jsonDecode(response.body);
              print(response.body);
              if (message["Status"]) {
                
                Fluttertoast.showToast(
                    msg: "password updated sucessfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
                
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login_page( )));
              } else {
                Fluttertoast.showToast(
                    msg: "invalid Email address",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          } catch (e) {
            Fluttertoast.showToast(
                msg: "Check your internet connection",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 15.sp);
                print(e);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Please Enter your vaild Email Address",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 15.sp);
        }
      }
    }

















TextEditingController Email = new TextEditingController();
TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var Screen_size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            // image of the page 
            Container(
                width: Screen_size.width,
                height: 45.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/forgot.jpg"),
                      fit: BoxFit.cover),
                )),
        
        
                //title of the page
        
            
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Center(
                child: Text(
                  "FORGOT PASSWORD",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        
            // text box 
        
            Padding(
              padding: const EdgeInsets.only(top:50),
              child: SizedBox(
                width: 85.w,
                height: 6.h,
                child: CupertinoTextField(
                  placeholder: "Email",
                  controller: Email,
                  textInputAction: TextInputAction.next,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: widget_color),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 85.w,
                height: 6.h,
                child: CupertinoTextField(
                  placeholder: "New password",
                  controller: password,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: ForgetPassword ,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: widget_color),
                ),
              ),
            ),
            SizedBox(height: 5.h,),
            CupertinoButton(child: Text("SUBMIT"), onPressed:ForgetPassword,
            color: submit_button,
            ),

            
        
        
        
          ]),
        ),
      ),
    );
  }
}
