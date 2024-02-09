import 'dart:convert';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/Questionwidget.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/class/behaviour.dart';

import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/screens/views/Screening/anextiy.dart';

import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
























class behaviourpage extends StatefulWidget {
  final patient_id;
  const behaviourpage({super.key, this.patient_id});

  @override
  State<behaviourpage> createState() => _behaviourpageState();
}

class _behaviourpageState extends State<behaviourpage> {

  @override
  void initState() {
    super.initState();
    setState(() {});
    fetch_child_detials();
  }

  Future fetch_Q_A() async {
    var url = questionurl;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      List<dynamic> index = message[0];
      return index;
    }
  }

  var name, image_path;
  bool screeening_page_loading = false;
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
          var cal = AgeCalculator.age(age);
          if (cal.years <= 0) {
            Age = cal.months.toString() + "months";
          } else {
            Age = cal.years.toString() + "yrs";
          }

          screeening_page_loading = true;
        });
      }
    }
  }

  void submit_btn() {
     Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => anextiy(
                                patient_id: widget.patient_id,
                              )));
  }

  

  @override
  Widget build(BuildContext context) {

    Map<int,List> values = {};





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
                Container(
                  width: 100.w,
                  height: 15.h,
                  //color: apple_grey,

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
                          height: 12.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://$ip/screening$image_path"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32, right: 5),
                        child: Column(
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 20),
                            ),
                            Text(
                              "Age",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32, right: 10),
                        child: Column(
                          children: [
                            Text(
                              ":",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 20),
                            ),
                            Text(
                              ":",
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32, right: 10),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 20),
                            ),
                            Text(
                              Age!,
                              style: TextStyle(
                                  fontFamily: 'SF-Pro-Bold', fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                FutureBuilder(
                    future: fetch_Q_A(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {


                      var Question = snapshot.data;




                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CupertinoActivityIndicator(
                          radius: 15,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {


                           bool checkedValue_never = false;
  bool checkedValue_often = false;
  bool checkedValue_sometimes = false;
                      behaviourpages b1 = behaviourpages();
                      

                          return Expanded(
                            child: CupertinoScrollbar(
                              child: ListView.builder(
                                itemCount: Question.length+1,
                                itemBuilder: (BuildContext context, int index){
                                 if (index == Question.length){




                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                    child: custom_buttom(text: "Next",
                                     width: 35, 
                                     height: 6, 
                                     backgroundColor: submit_button,
                                      textSize: 13, 
                                      button_funcation: submit_btn, 
                                      textcolor: lightColor,
                                       fontfamily: 'SF-Pro-Bold'),
                                  );
                                 }







                                 else{
                                  var question = Question![index];
                                    var s_no = question['S.no'];
                                    var q_a = question['Question'];
                                    
                                  
                                    print(b1.values);
                                     






                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Questionwidget(sno: s_no, Q: q_a, lenght:index),
                                    );







                                 }
                                })
                            ),
                          );
                        }
                      }
                      return Text("something went wrong😒");
                    })
              ],
            ),
          );  
  }
  
}