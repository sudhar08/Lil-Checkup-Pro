import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/screens/auth_screens/signuppage.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../API/urlfile.dart';
import '../../utils/colors_app.dart';
import '../views/Homepage.dart';
//import 'package:toast/toast.dart ';

// ignore: camel_case_types
class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

bool visiblilty = true;
bool _checkbox = false;

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();

class _Login_pageState extends State<Login_page> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var per_w = width / 100;
    var per_h = height / 100;

    bool email_check(String email) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      return emailValid;
    }

bool isLoading = false;

void clear_box() {
  username.clear();
  password.clear();
  
}
    void login_btn() async {
      setState(() {
              isLoading = true;
            });
      if (username.text.isEmpty || password.text.isEmpty) {
        setState(() {
              isLoading = false;
            });
        Fluttertoast.showToast(
            msg: "please fill all the fields", toastLength: Toast.LENGTH_SHORT);
      } else {
        var data = {"username": username.text, "password": password.text};

        // url to login;
        var url = loginurl;

        if (email_check(username.text)) {
          try {
            final response = await http.post(Uri.parse(url), body: jsonEncode(data)).timeout(const Duration(seconds: 10));
            if (response.statusCode == 200) {
              var message =   jsonDecode(response.body);
              print(response.body);
              if (message["loginStatus"]) {
                var userInfo = message["userInfo"];
                var id = userInfo["id"];
                var name = userInfo["username"];
                setState(() {
                  userid = id;
                  isLoading = false;
                });

                Fluttertoast.showToast(
                    msg: "Login sucessfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
                
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => Home_page(
                          userid: id,
                          
                        )),(route) => false,);

                      clear_box();
                        
              } else {
                setState(() {
              isLoading = false;
            });
                Fluttertoast.showToast(
                    msg: "invalid username or password",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          } catch (e) {
            setState(() {
              isLoading = false;
            });
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
          setState(() {
              isLoading = false;
            });
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



    

    return Sizer(builder: (context, orientation, deviceType) {
      print(MediaQuery.of(context).size.height);

      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.jpg"),
                    fit: BoxFit.cover,  
                    colorFilter:
                        ColorFilter.mode(Colors.black, BlendMode.dstATop),
                    opacity: 0.5)),
            child: SafeArea(
                top: true,
                bottom: true,
                child: AutofillGroup(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: per_h * 6),
                        child: FadeInUp(
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  color: lightColor,
                                  fontFamily: 'SF-Pro-Bold'),
                            ),
                          ),
                        ),
                      ),
                  
                      //title of the is over here
                  
                      SizedBox(
                        height: 14.h,
                      ),
                      FadeInUp(
                        //delay: Duration(milliseconds: 600 ),
                        child: Center(
                          child: SizedBox(
                            width: 82.w,
                            height: 6.h,
                            child: CupertinoTextField(
                                controller: username,
                        
                                padding: EdgeInsets.only(left: per_w * 8),
                                decoration: BoxDecoration(
                                  color: lightColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefix: Padding(
                                  padding: EdgeInsets.only(left: per_w * 5),
                                  child: Icon(CupertinoIcons.person_circle_fill,
                                  color: darkColor,
                                      size: 28.0),
                                ),
                                textDirection: TextDirection.ltr,
                                placeholder: "Email",
                                autofillHints: const [AutofillHints.newUsername],
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(fontFamily: 'SF-Pro')),
                          ),
                        ),
                      ),
                  
                      // username textfield over here
                  
                      SizedBox(
                        height: 5.h,
                      ),
                      FadeInUp(
                        child: Center(
                          child: SizedBox(
                            width: 82.w,
                            height: 6.h,
                            child: CupertinoTextField(
                              controller: password,
                              autofillHints: const [AutofillHints.newPassword],
                              padding: EdgeInsets.only(left: 40),
                              decoration: BoxDecoration(
                                  color: lightColor,
                                  borderRadius: BorderRadius.circular(20.0)),
                              obscureText: visiblilty,
                              prefix: const Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Icon(CupertinoIcons.lock_fill, size: 28.0,color: darkColor,),
                              ),
                              suffix: Padding(
                                  padding: EdgeInsets.only(right: 30),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visiblilty = !visiblilty;
                                        });
                                      },
                                      icon: visiblilty
                                          ? Icon(
                                              CupertinoIcons.eye_slash,
                                              size: 28.0,color: darkColor,
                                            )
                                          : Icon(
                                              CupertinoIcons.eye,
                                              size: 28.0,color: darkColor,
                                            ))),
                              textDirection: TextDirection.ltr,
                              placeholder: "Password",
                              
                              onEditingComplete: login_btn,
                            ),
                          ),
                        ),
                      ),
                  
                      // password texxt field is over here
                  
                      FadeInUp(
                        child: Padding(
                          padding: EdgeInsets.only(top: 0.5.h),
                          child: Container(
                            width: 390,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              
                              // FadeInUp(
                              //   child: Padding(
                              //       padding: EdgeInsets.only(left: 11.w),
                              //       child: InkWell(
                              //         onTap: () {
                              //           Navigator.of(context).push(MaterialPageRoute(
                              //               builder: (context) => Forgot_password()));
                              //         },
                              //         child: Text(
                              //           "Forget Password?",
                              //           style: TextStyle(
                              //               fontSize: 11.5.sp,
                              //               color: lightColor,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //       )),
                              // ),
                            ]),
                          ),
                        ),
                      ),
                      //login button for login
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Center(
                          child: FadeInUp(
                            child: SizedBox(
                                width: 73.w,
                                height: 7.h,
                                child: CupertinoButton(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    TextInput.finishAutofillContext();
                                    login_btn();
                                  },
                                  color: primary_color,
                                  
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                        ),
                      ),
                  
                      // Login button over here
                  
                      Padding(
                        padding: EdgeInsets.only(top:4.5.h),
                        child: Container(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  Signup()));
                          },
                          child: FadeInUp(
                            child: Text(
                              "Don't have a account? Signup",
                              style: TextStyle(fontSize: 11.5.sp, color: lightColor),
                            ),
                          ),
                        )),
                      )
                    ],
                  ),
                )),
          ),
        ),
      );
    });
  }
}
