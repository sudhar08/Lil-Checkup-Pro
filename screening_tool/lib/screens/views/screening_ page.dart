import 'dart:convert';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/Questionwidget.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/class/checkboxstore.dart';

import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/behviour_screening.dart';
import 'package:screening_tool/screens/views/Screening/growth/grossmotor.dart';

import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class screeening_page extends StatefulWidget {
  final patient_id;
  const screeening_page({super.key, required this.patient_id});

  @override
  State<screeening_page> createState() => _screeening_pageState();
}

class _screeening_pageState extends State<screeening_page> {
  @override
  void initState() {
    super.initState();
    setState(() {});
    fetch_child_detials();
   
   
      
    
     

  }


 
 

  var name, image_path,parent_name;
  bool screeening_page_loading = false;
   var gr;
  String? Age;
  void fetch_child_detials() async {
    var data = {"patient_id": widget.patient_id};
    var url = child_info;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message['Status']) {
        var detials = message['pateintinfo'];
        DateTime age = DateTime.parse(detials['age']);
        setState(() {
          name = detials['child_name'];
          image_path = detials['image_path'].toString().substring(2);
          parent_name = detials['parent_name'];
           var cal = AgeCalculator.age(age);
          if (cal.years <= 0) {
            Age = cal.months.toString() + "months";
            gr = cal.months.toString();
          } else {
            Age = cal.years.toString() + "yrs";
            gr  = cal.years;
            gr = gr*12;
            gr = gr.toString();
          }

          screeening_page_loading = true;
        });
      }
    }
  }

  void behaviour_btn() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => behaviourpage(patient_id: widget.patient_id)));
  }
   void growth_btn() {
    var _age = gr;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => grossmotor(Age: _age,)));
  }

  @override
  Widget build(BuildContext context) {
    print(gr);
    return screeening_page_loading == false
        ? Center(
            child: CupertinoActivityIndicator(
              radius: 20.0,
            ),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: SafeArea(child: appbar_default(title: "Screening")),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  width: 100.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget_color_1,
                    boxShadow: [
                  BoxShadow(
                    color: primary_color_shadow,
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(0, 3.54),
                  )
                    ]
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoContextMenu(
                        previewBuilder: (BuildContext context,
                            Animation<double> animation, Widget child) {
                          return SizedBox(
                            height: 30.h,
                            width: 60.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "http://$ip/screening/$image_path",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        actions: [
                          Center(
                              child:
                                  CupertinoContextMenuAction(child: Text(name)))
                        ],
                        child: Container(
                          width: 35.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://$ip/screening$image_path"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 75, right: 10),
                        child: Column(
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                            Text(
                              "Age",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                            Text(
                              "Parent name",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80, right: 10),
                        child: Column(
                          children: [
                            Text(
                              ":",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80, right: 10),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                            Text(
                              Age!,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                            Text(
                              parent_name,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                 custom_buttom(
                          text: "Growth screening",
                          width: 80,
                          height: 6,
                          backgroundColor: primary_color_shadow,
                          textSize: 13,
                          button_funcation: growth_btn,
                          textcolor: darkColor,
                          fontfamily: 'SF-Pro-Bold'),
                          Gap(3.h),
                          custom_buttom(
                          text: "Behaviour Screening",
                          width: 80,
                          height: 6,
                          backgroundColor: never,
                          textSize: 13,
                          button_funcation: behaviour_btn,
                          textcolor: darkColor,
                          fontfamily: 'SF-Pro-Bold')
                    
              ],
            ),
          );
  }
}
