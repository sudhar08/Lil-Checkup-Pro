// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/screens/views/screening_%20page.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';

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
              growth = result['Growth_condition'];
              
              
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
  growth,
      parent_name,
      condition,
      treatment,
      Specialist,
      Doctor,
      Suggestion,
      conditions,
      child_name;

  

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
                                  fontFamily: 'SF-Pro', fontSize: 13.sp,)),
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
                        Text("Behaviour",style: TextStyle(fontFamily: 'SF-Pro-semibold',fontSize: 13.sp),),
                       
                        Text(":",style: style_text_semi),
                         
                        if(conditions == null)
                        Text("Take Test",style: style_text_semi)
                        else 
                        
                        Text("${conditions.replaceAll(RegExp(r"\[|\]"), "").split(",").join(",")}",style: style_text_semi)
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Growth",style: TextStyle(fontFamily: 'SF-Pro-semibold',fontSize: 13.sp),),
                       
                        Text(":",style: style_text_semi),
                         if(growth == null)
                        Text("Take Test",style: style_text_semi)
                        else 
                        Text("${growth.replaceAll(RegExp(r"\[|\]"), "").split(",").join(",")}",style: style_text_semi)

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
