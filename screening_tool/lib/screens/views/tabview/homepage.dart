import 'dart:convert';

import 'package:circular_progress_stack/circular_progress_stack.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/Recent_patient.dart';
import 'package:screening_tool/components/app_bar.dart';
import 'package:screening_tool/screens/auth_screens/signuppage.dart';


import 'package:screening_tool/screens/views/patient/Add_child.dart';
import 'package:screening_tool/screens/views/patient_view.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Home_screen extends StatefulWidget {
  //final String userid;
  const Home_screen({
    super.key,
  });

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  var result, name, no_of_patients, list_of_patients ,image_path,completed_patient;
// ignore: non_constant_identifier_names

  bool _loading = false;
  @override
  void initState() {
    super.initState();
   
    Doc_info();
  }

  Future<void> _refreshon() async{
    await Future.delayed( Duration(milliseconds: 1000));
    await Doc_info();

  }



  Future Doc_info() async {
    var data = {"id": userid};
    var url = homeUrl;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    var detials;
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message['Status']) {
        detials = message['detials'];
        CupertinoActivityIndicator(radius: 20.0);
        Future.delayed(Duration(milliseconds: 1000), () {
          setState(() {
            result = detials;
            name = result['doctor_name'];
            no_of_patients = result['no_of_patient'].toString();
            completed_patient = result['completed_patient'].toString();
            list_of_patients = int.parse(no_of_patients);
            image_path = result['image_path'].toString().substring(2);
            
            _loading = true;
          });
        });
      } else {
        print("no user found");
      }
    } else {
      print("check the internet connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);



    return _loading != true
           ? Center(child:CupertinoActivityIndicator(radius: 20.0,))

           :
    
    
    Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(24.2.h),
        child: 
         app_bar(
          title: 'Home',
          doc_name: name, Image_path: image_path, 
        ),
      ),
      body:
           CustomMaterialIndicator(
            onRefresh: _refreshon,

          indicatorBuilder: (BuildContext context, IndicatorController controller) { 
            return Icon(Icons.health_and_safety_outlined);
           },
             child: ListView(
              
               children: [
               
                 Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 20, left: 15),
                     child: Container(
                       width: 45.w,
                       height: 21.h,
                       decoration: BoxDecoration(
                           color: widget_color,
                           borderRadius: BorderRadius.circular(21.67),
                           boxShadow: const [
                             BoxShadow(
                                 color: primary_color_shadow,
                                 blurRadius: 3,
                                 spreadRadius: 1,
                                 offset: Offset(0, 3.54)),
                           ]),
                       child:  Column(children: [
                         Padding(
                           padding: EdgeInsets.only(top: 8.0),
                           child: Text(
                             "Attended patients",
                             style: TextStyle(
                                 fontFamily: 'SF-Pro',
                                 fontSize: 15.sp,
                                 color: darkColor),
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.all(10.0),
                           child: Text("$completed_patient/$no_of_patients",
                               style: TextStyle(
                                   fontFamily: 'SF-Pro-Bold',
                                   fontSize: 18.sp,
                                   color: primary_color)),
                         ),
                         Padding(
                           padding: EdgeInsets.only(top: 8.0),
                           child: SingleAnimatedStackCircularProgressBar(
                             size: 55,
                             progressStrokeWidth: 10,
                             backStrokeWidth: 10,
                             startAngle: 0,
                             backColor: Color(0xffD7DEE7),
                             barColor: Colors.blue,
                             barValue:  double.parse(completed_patient)/5*100,
                           ),
                         ),
                       ]),
                     ),
                   ),
                   //add new childern of the doctor to the app
               
                   Padding(
                       padding: EdgeInsets.only(top: 3.h, left: 10.w),
                       child: GestureDetector(
                         onTap: () {
                           Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => const add_new_child()));
                         },
                         child: Container(
                           width: 36.w,
                           height: 17.h,
                           decoration: BoxDecoration(
                               color: widget_color,
                               borderRadius: BorderRadius.circular(21.67),
                               boxShadow: const [
                                 BoxShadow(
                                     color: primary_color_shadow,
                                     blurRadius: 3,
                                     spreadRadius: 1,
                                     offset: Offset(0, 3.54)),
                               ]),
                           child: Column(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(top: 25),
                                 child: SizedBox(
                                   width: 35,
                                   height: 35,
                                   child: Icon(
                                     CupertinoIcons.person_crop_circle_fill_badge_plus,
                                     size: 34,
                                     color: darkColor
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: EdgeInsets.only(top: 20),
                                 child: Text(
                                   "New child",
                                   style: TextStyle(
                                     fontFamily: 'SF-Pro',
                                     fontSize: 15.sp,
                                   ),
                                 ),
                               )
                             ],
                           ),
                         ),
                       ))
                 ]),
                 
                 //gapp between the add child and attendented
                  SizedBox(
                   height: 3.h,
                 ),
             
             
               // no of petient container 
             
             
             Padding(
                   padding: EdgeInsets.only(right: 100),
                   child: GestureDetector(
                     onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(
                           builder: (context) => Patient_screen(
                                 
                                 name: name, image_path: image_path, 
                               )));
                     },
                     child: Container(
                       width: 68.w,
                       height: 18.h,
                       decoration: BoxDecoration(
                           color: widget_color,
                           borderRadius: BorderRadius.circular(22),
                           boxShadow: const [
                             BoxShadow(
                                 color: primary_color_shadow,
                                 blurRadius: 3,
                                 spreadRadius: 1,
                                 offset: Offset(0, 3.54)),
                           ]),
                       child: Column(
                         children: [
                           Padding(
                             padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 SizedBox(
                                   width: 15.w,
                                 ),
                                 Icon(
                                   CupertinoIcons.person_2_fill,
                                   size: 36,
                                   color: darkColor
                                 ),
                                 Padding(
                                   padding: EdgeInsets.only(left: 30, right: 10),
                                   child: Icon(
                                     CupertinoIcons.chevron_right_circle,
                                     size: 28,
                                     color: primary_color,
                                   ),
                                 )
                               ],
                             ),
                           ),
                           Text(
                             "No of Patient",
                             style:
                                 TextStyle(fontFamily: 'SF-Pro', fontSize: 16.sp),
                           ),
                           SizedBox(
                             height: 0.45.h,
                           ),
                           Text(
                             no_of_patients.toString(),
                             style: TextStyle(
                                 fontFamily: 'SF-Pro-Bold',
                                 fontSize: 20.sp,
                                 color: primary_color),
                           )
                         ],
                       ),
                     ),
                   ),
                 ),
             
                 //gap
             
                SizedBox(
                   height: 20,
                 ),
             
                 // recent patient information title goes here
             
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 18.0),
                       child: Text(
                         "Your Recent Patient",
                         style: TextStyle(
                             fontFamily: 'SF-pro-Bold',
                             fontSize: 13.sp,
                             color: apple_grey),
                       ),
                     ),
                     GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                           builder: (context) => Patient_screen(
                                 
                                 name: name, image_path: image_path, 
                               )));
                        
                      },
                       child: Padding(
                         padding: const EdgeInsets.only(right: 15.0),
                         child: Text("see all",
                             style: TextStyle(
                                 fontFamily: 'SF-Pro-Bold',
                                 fontSize: 13.sp,
                                 color: apple_grey)),
                       ),
                     )
                   ],
                 ),
             
                 // recent patient information
             
                 
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:Row(children: [
                    Padding(
                           padding: const EdgeInsets.symmetric(vertical: 25),
                           child: Recent_card(),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 25),
                           child: Recent_card(),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 25),
                           child: Recent_card(),
                         )
                  ]) ,)
             
             
             
                    
                    
                  
                 ]),
                 
               ],
                 
                 
                 ),
           ));
  }
}
