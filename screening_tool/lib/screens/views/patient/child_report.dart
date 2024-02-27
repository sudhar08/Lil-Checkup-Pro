// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/components/custom_widget.dart';
import 'package:screening_tool/components/widget_page.dart';
import 'package:screening_tool/screens/views/patient/edit_report.dart';

import 'package:screening_tool/screens/views/screening_%20page.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';
import 'package:age_calculator/age_calculator.dart';

class child_report extends StatefulWidget {
  final patient_id;
  const child_report({super.key, required this.patient_id});

  @override
  State<child_report> createState() => _child_reportState();
}

class _child_reportState extends State<child_report> {
  Future<Map> get_child_info() async {
    var data = {"patient_id": widget.patient_id};
    var url = get_infourl;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));

    var decode = jsonDecode(response.body);

    return decode;
  }

  var result,age;
  var imagepath,test;
  bool _loading = false;
String? Age;

  void report_Patient_info() async {
    var data = {"patient_id": widget.patient_id};
    var url = child_info;
   
    try {
      
       final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    
      if (response.statusCode == 200) {
        
        var message = jsonDecode(response.body);
        if (message['Status']) {
          CupertinoActivityIndicator(radius: 20.0);

          Future.delayed(Duration(milliseconds: 10), () {
           

          
            setState(() {
              result = message['pateintinfo'];
              name = result['child_name'];
              parent_name = result['parent_name'];
               age =  DateTime.parse(result['age']);
              conditions = result['conditions'];
              conditions = conditions.replaceAll(RegExp(r"\[|\]"), "").split(",");
              imagepath = result['image_path'];
              imagepath = imagepath.toString().substring(2);
              var cal = AgeCalculator.age(age);
          if (cal.years <= 0) {
            Age = cal.months.toString() + "months";
           
          } else {
            Age = cal.years.toString() + "yrs";
            
          }

              _loading = true;
            });
          });
        }
      }
    } catch (e) {
      print(e);
      
    }
  }

  @override
  void initState() {
    super.initState();
    report_Patient_info();
  }

  var name,
      parent_name,
      condition,
      treatment,
      Specialist,
      Doctor,
      Suggestion,
      conditions,
      child_name;

  void bottom_sheet() {
    showCupertinoModalBottomSheet(
        expand: true,
        isDismissible: true,
        backgroundColor: widget_color,
        context: context,
        builder: (BuildContext context) {
          // name = info["name"];

          // parent_name = info['parent_name'];
          // condition = info['conditions'];
          // treatment = info['treatment'];
          // Specialist = info['specialist'];
          // Doctor = info['doctor'];
          // Suggestion = info['suggestion'];

          return Scaffold(
            body: Column(children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DIAGNOSIS",
                      style: TextStyle(fontSize: 17, fontFamily: 'SF-Pro-Bold'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        size: 28,
                        color: darkColor,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 2,
                thickness: 1.5,
              ),
              Gap(1.h),
              Container(
                width: 85.w,
                height: 12.h,
                decoration: BoxDecoration(
                    color: widget_color,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 10.h,
                      child: CircleAvatar(
                          backgroundImage:
                              NetworkImage("http://$ip/screening/$imagepath")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Name_detials_outline(
                        name: 'Name',
                        age: "Age",
                        parent_name: "Parent Name",
                      ),
                    ),
                    Name_detials_outline(
                      name: ':',
                      age: ":",
                      parent_name: ":",
                    ),
                    Name_detials_outline(
                      name: name,
                      age: Age!,
                      parent_name: parent_name,
                    )
                  ],
                ),
              ),
              Gap(2.h),
              custom_widget(
                  width: 90,
                  height: 15,
                  backgroundColor: widget_color,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Report", style: style_text_bold),
                      ),
                      Gap(1.5.h),
                      Divider(
                        height: 3,
                      ),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Condition",
                            style: style_text,
                          ),
                          Gap(1.5.h),
                          Text(":"),
                          Gap(1.5.h),
                          Text("condition", style: style_text_bold),
                        ],
                      )
                    ],
                  ),
                  borderradius: 20),
              Gap(2.h),
              custom_widget(
                  width: 90,
                  height: 20,
                  backgroundColor: widget_color,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("TREATMENT", style: style_text_bold),
                      ),
                      Gap(1.h),
                      Divider(
                        height: 2,
                      ),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("TREATMENT", style: style_text),
                          Gap(1.5.h),
                          Text(":"),
                          Gap(1.5.h),
                          Text("treatment", style: style_text),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("SPECIALIST", style: style_text),
                          Gap(1.5.h),
                          Text(":"),
                          Gap(1.5.h),
                          Text("Specialist", style: style_text),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("DOCTOR", style: style_text),
                          Gap(1.5.h),
                          Text(":"),
                          Gap(1.5.h),
                          Text("Doctor", style: style_text),
                        ],
                      )
                    ],
                  ),
                  borderradius: 20),
              Gap(2.h),
              custom_widget(
                  width: 90,
                  height: 15,
                  backgroundColor: widget_color,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("SUGGESTION", style: style_text_bold),
                      ),
                      Gap(1.5.h),
                      Divider(
                        height: 3,
                      ),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Suggestion", style: style_text),
                        ],
                      )
                    ],
                  ),
                  borderradius: 20),
              Gap(4.h),
              custom_buttom(
                  text: "Edit",
                  width: 80,
                  height: 6,
                  backgroundColor: primary_color,
                  textSize: 15,
                  button_funcation: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Edit_report()));
                  },
                  textcolor: lightColor,
                  fontfamily: 'SF-Pro-Bold')
            ]),
          );
        });
  }
  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: SafeArea(
              child: appbar_default(
            title: "Report",
          ))),
      body: _loading != true
          ? Center(child: CupertinoActivityIndicator(radius: 20.0))
          : Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //child image for the

              CupertinoContextMenu(
                previewBuilder:
          (BuildContext context, Animation<double> animation, Widget child) {
        return SizedBox(
          height: 40.h,
          width: 85.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "http://$ip/screening/$imagepath",
              fit: BoxFit.cover,
            ),
          ),
        );
      },
                actions: [
                  CupertinoContextMenuAction(child: Text(name))
                ],
                child: Container(
                  width: 40.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //color: apple_grey
                      image: DecorationImage(
                          image: NetworkImage("http://$ip/screening$imagepath"),
                          fit: BoxFit.fill)),
                ),
              ),

              //name detials for the child image for the child

              Container(
                width: 80.w,
                height: 15.h,
                decoration: BoxDecoration(
                    color: widget_color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: primary_color_shadow,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(0, 3.54)),
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontFamily: 'SF-Pro', fontSize: 13.sp),
                          ),
                          Text("Age",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro', fontSize: 13.sp)),
                          Text("Parent Name",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro', fontSize: 13.sp)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text(":"), Text(":"), Text(":")],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(name,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro', fontSize: 13.sp)),
                          Text(Age!,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro', fontSize: 13.sp)),
                          Text(parent_name,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro', fontSize: 13.sp))
                        ],
                      )
                    ]),
              ),

              //report the widget starts here !!!!

              Container(
                width: 90.w,
                height: 20.h,
                decoration: BoxDecoration(
                    color: widget_color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: primary_color_shadow,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(0, 3.54)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "DIAGNOSIS  REPORT",
                      style: TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                    ),
                    Divider(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Conditions",style: TextStyle(fontFamily: 'SF-Pro-semibold',fontSize: 13.sp),),
                       
                        Text(":",style: style_text_semi),
                         
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          for(var item in conditions) Text(item,style: style_text_semi),
                        ],)
                      ],
                    ),
                    




// Update the string builder with each word and rebuild the widget

                       
                    
                    
                    
                  ],
                ),
              ),

              // take screeening button  !!!!
              SizedBox(
                width: 130.w,
              ),
              Container(
                width: 80.w,
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => screeening_page(
                              patient_id: widget.patient_id,
                            )));
                  },
                  child: Text(
                    "Take Screening",
                    style: TextStyle(fontFamily: 'SF-pro', fontSize: 17.sp),
                  ),
                  color: primary_color,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Gap(3.h)
            ]),
    );
  }
}
