// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/screens/views/screening_%20page.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../../../API/urlfile.dart';
import '../../../components/app_bar_all.dart';
import '../../../utils/colors_app.dart';
import '../../../utils/tropography.dart';

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

  var age;
  var imagepath,test;
  bool _loading = false;
String? Age;

  Future report_Patient_info() async {
    var data = {"patient_id": widget.patient_id};
    var url = child_info;
   
    try {
      
       final response = await http.post(Uri.parse(url), body: jsonEncode(data)).timeout(const Duration(seconds: 10));
    
      if (response.statusCode == 200) {
        
        var message = jsonDecode(response.body);
        if (message['Status']) {
          return message['pateintinfo'];
         
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

  Future<void> _refreshon() async{
    await Future.delayed( Duration(milliseconds: 1000));
    report_Patient_info();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: SafeArea(
              child: appbar_default(
            title: "Report", back: true,
          ))),
      body:  FutureBuilder(
        future: report_Patient_info(),
        builder:  (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CupertinoActivityIndicator(radius: 15,));
                    
                  }

                  
                  else if (snapshot.connectionState ==ConnectionState.done){
                    
                    

                    
                    if (snapshot.hasData){
                      var pateintinfo = snapshot.data;
                      
                      name = pateintinfo['child_name'];
              parent_name = pateintinfo['parent_name'];
               age =  DateTime.parse(pateintinfo['age']);
              conditions = pateintinfo['conditions'];
              growth = pateintinfo['Growth_condition'];
              
              
              imagepath = pateintinfo['image_path'];
              imagepath = imagepath.toString().substring(2);
              var cal = AgeCalculator.age(age);
          if (cal.years <= 0) {
            Age = cal.months.toString() + "months";
           
          } else {
            Age = cal.years.toString() + "yrs";
            
          }

              return  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        //child image for the
                
                        CupertinoContextMenu(
                //           previewBuilder:
                //     (BuildContext context, Animation<double> animation, Widget child) {
                //   return SizedBox(
                //     height: 40.h,
                //     width: 85.w,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(20),
                //       child: Image.network(
                //         "http://$ip/screening/$imagepath",
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   );
                // },
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
                      ]);
  }
  
  }
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              //color: widget_color,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                               SizedBox(
                                width: 80.w,
                                height: 25.h,
                                child: RiveAnimation.asset("assets/animation/404_cat.riv"),
                               ),
                                
                            ]),
                          ),
                          GestureDetector(
                              onTap: (){
                                _refreshon();
                                 
                              },
                              child: Text("Try again",style: TextStyle(fontFamily: 'SF-Pro',fontSize: 13.sp,color: primary_color),))
                        ],
                      ),
  );
  
  
  }
  
    ));
  }
}
