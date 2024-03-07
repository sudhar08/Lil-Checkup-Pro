import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/Questionwidget.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/class/checkboxstore.dart';
import 'package:screening_tool/components/class/results.dart';

import 'package:screening_tool/components/custom_button.dart';

import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ADHDpage extends StatefulWidget {
  final  patient_id;
  const ADHDpage({super.key, required this.patient_id});

  @override
  State<ADHDpage> createState() => _ADHDpageState();
}

class _ADHDpageState extends State<ADHDpage> {

@override
  void initState() {
    super.initState();
    setState(() {});
    fetch_child_detials();
    checkbox();
    
  }
checkboxvalues_adhd ad = checkboxvalues_adhd();
  void checkbox() async{
    var response = await fetch_Q_A();
    var length = response.length;
    
    for (var i = 0; i < length; i++){
      ad.value(i);
    }
  }


  Future fetch_Q_A() async {
    var url = adhd_url;

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

  void submit_btn(){
    AdhdPageResult r3 = AdhdPageResult();

    r3.getValues(ad.checkedbox_adhd);
   r3.showresults(context,widget.patient_id);
    

    
  }

















  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: SafeArea(child: appbar_default(title: "Screening")),
            ),
            body: Column(
              children: [
          
                
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
                         

                          print(Question.length);

                          return Expanded(
                            child: CupertinoScrollbar(
                                child: ListView.builder(
                                    itemCount: Question.length + 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == Question.length) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                          child: custom_buttom(
                                              text: "Next",
                                              width: 35,
                                              height: 6,
                                              backgroundColor: submit_button,
                                              textSize: 13,
                                              button_funcation: submit_btn,
                                              textcolor: lightColor,
                                              fontfamily: 'SF-Pro-Bold'),
                                        );
                                      } else {
                                        var question = Question![index];
                                        var s_no = question['S.NO'];
                                        var q_a = question['Questions'];

                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Questionwidget(
                                            sno: s_no,
                                            Q: q_a,
                                            index: index,
                                            never: ad.checkedbox_adhd[index]![0],
                                            onchanged_never: (newvalue) {
                setState(() {
                 
                  ad.checkedbox_adhd[index]![0] = newvalue;
                  ad.checkedbox_adhd[index]![1] = false;
                  ad.checkedbox_adhd[index]![2]=false;
                  
                  
                });}, 
                
                often: ad.checkedbox_adhd[index]![1],
                onchanged_often: (newvalue) {
                setState(() {
                 
                  ad.checkedbox_adhd[index]![0] = false;
                  ad.checkedbox_adhd[index]![1] = newvalue;
                  ad.checkedbox_adhd[index]![2]=false;
                  
                  
                });},

                always: ad.checkedbox_adhd[index]![2],
                onchanged_always: (newvalue) {
                setState(() {
                 
                  ad.checkedbox_adhd[index]![0] = false;
                  ad.checkedbox_adhd[index]![1] = false;
                  ad.checkedbox_adhd[index]![2]=newvalue;
                  
                  
                });},
                                          ),
                                        );
                                      }
                                    })),
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