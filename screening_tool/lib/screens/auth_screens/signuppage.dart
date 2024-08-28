import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/screens/auth_screens/login_page.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:fluttertoast/fluttertoast.dart";
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../API/urlfile.dart';
import '../../utils/colors_app.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

double width = 85.w;
double height = 40;
TextEditingController username = new TextEditingController();
TextEditingController email = new TextEditingController();
TextEditingController phone_no = new TextEditingController();
TextEditingController registration_no = new TextEditingController();
TextEditingController password = new TextEditingController();


class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double padding = 9;
    

    



void clear_field(){
  username.clear();
  email.clear();
phone_no.clear();
  password.clear();
  registration_no.clear();
  
  

}



    void signup_btn() async {
      if (password.text.isNotEmpty &&
          phone_no.text.isNotEmpty &&
          username.text.isNotEmpty &&
          email.text.isNotEmpty &&
          registration_no.text.isNotEmpty) 
          
          {
        var signup_data = {
          "id": registration_no.text + username.text,
          "username": username.text,
          "emailid": email.text,
          "registrationno": registration_no.text,
          "passwords": password.text,
          "phone_no":phone_no.text
        };

        var url = signupurl;
        
        final response = await http.post(Uri.parse(url), body: jsonEncode(signup_data));
       
        if (response.statusCode == 200) {
          print(response.body);
           
          var msg = jsonDecode(response.body);
          print(msg);
          if (msg == "successfully added") {
            print(signup_data);
            Fluttertoast.showToast(
                msg: "sucessfully resregistered",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
              clear_field();  
            Navigator.of(context).pop(
                MaterialPageRoute(builder: (context) => const Login_page()));
          }
        } else {
          print(jsonDecode(response.body));
        }
      } 
      
      
      else {
       Fluttertoast.showToast(msg: "Please fill all the fields");
       clear_field(); 

      }
//function backet
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BounceInDown(
            child: SingleChildScrollView(
              child: SafeArea(
                  top: true,
                  bottom: true,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.h),
                        child: Center(
                            child: Text(
                          "SIGN UP!",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: darkColor,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
            
                      ////////////////////////////
                      ///
            
                      Container(
                        width: 100.w,
                        height: 25.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/signup.jpg"),
                          fit: BoxFit.cover,
                        )),
                      ),
            
                      //////////////////
            
                      Container(
                        width: 100.w,
                        height: size.height / 100 * 64.5,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(127, 6, 57, 242),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: BounceInDown(
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                width: 30.w,
                                height: 4.5.h,
                                child: Center(
                                  child: Text(
                                    "DOCTOR",
                                    style: TextStyle(
                                        fontSize: 14.sp, fontFamily: 'SF-Pro-Bold'),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: lightColor,
                                    borderRadius: BorderRadius.circular(7.2)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding),
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: CupertinoTextField(
                                  controller: username,
                                  textInputAction: TextInputAction.next,
                                  placeholder: "Full name",
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: lightColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding),
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: CupertinoTextField(
                                  controller: email,
                                  textInputAction: TextInputAction.next,
                                  placeholder: "Email ID",
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: lightColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding),
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: CupertinoTextField(
                                  controller: phone_no,
                                  textInputAction: TextInputAction.next,
                          
                                  placeholder: "Phone No",
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: lightColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding),
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: CupertinoTextField(
                                  controller: registration_no,
                                  textInputAction: TextInputAction.next,
                                  obscureText: true,
                                  placeholder: "Registration No",
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: lightColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(padding),
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: CupertinoTextField(
                                  controller: password,
                                  onEditingComplete: signup_btn,
                                  obscureText: true,
                                  placeholder: "Password",
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: lightColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25.0),
                              child: SizedBox(
                                width: 70.w,
                                height: 6.5.h,
                                child: CupertinoButton(
                                    child: Center(
                                      child: Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontFamily: 'SF-Pro-Bold'),
                                      ),
                                    ),
                                    color: primary_color,
                                    borderRadius: BorderRadius.circular(30),
                                    onPressed: () {
                                      signup_btn();
                                      
                                    }),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop(MaterialPageRoute(
                                        builder: (context) => const Login_page()));
                                  },
                                  child: Text("Already  have a account? Login",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: lightColor,
                                          fontFamily: 'SF-Pro')),
                                ))
                          ]),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
