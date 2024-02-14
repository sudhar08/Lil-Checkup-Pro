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
import 'package:screening_tool/components/class/checkboxstore.dart';
import 'package:screening_tool/components/class/results.dart';

import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/anextiy.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/finalpage.dart';

import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class anextiy extends StatefulWidget {
  final patient_id;
  const anextiy({super.key, required this.patient_id});

  @override
  State<anextiy> createState() => _anextiyState();
}

class _anextiyState extends State<anextiy> {
  @override
  void initState() {
    super.initState();
    setState(() {});
    fetch_child_detials();
    checkbox();


    
  }

  checkboxvalues_axienty ax = checkboxvalues_axienty();
  void checkbox() async {
    var response = await fetch_Q_A();
    var length = response.length;

    for (var i = 0; i < length; i++) {
      ax.value(i);
    }
  }

  Future fetch_Q_A() async {
    var url = anextiyurl;

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
    AnextiyPageResult Ar1 = AnextiyPageResult();
    Ar1.getValues(ax.checkedbox_axienty);
    Ar1.showresults();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => finalpage(
              patient_id: widget.patient_id,
            )));
  }

  @override
  Widget build(BuildContext context) {
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
                                        var s_no = question['S.no'];
                                        var q_a = question['Questions'];
                                        return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Questionwidget(
                                                sno: s_no,
                                                Q: q_a,
                                                index: index,
                                                never: ax.checkedbox_axienty[index]![0],
                                                onchanged_never:
                                                    (newvalue) {
                setState(() {
                 
                  ax.checkedbox_axienty[index]![0] = newvalue;
                  ax.checkedbox_axienty[index]![1] = false;
                  ax.checkedbox_axienty[index]![2]=false;
                  
                  
                });},
                                                often: ax.checkedbox_axienty[index]![1],
                                                always: ax.checkedbox_axienty[index]![2],
                                                onchanged_often:
                                                     (newvalue) {
                setState(() {
                 
                  ax.checkedbox_axienty[index]![0] = false;
                  ax.checkedbox_axienty[index]![1] = newvalue;
                  ax.checkedbox_axienty[index]![2]=false;
                  
                  
                });},
                                                onchanged_always:
                                                     (newvalue) {
                setState(() {
                 
                  ax.checkedbox_axienty[index]![0] = false;
                  ax.checkedbox_axienty[index]![1] = false;
                  ax.checkedbox_axienty[index]![2]=newvalue;
                  
                  
                });},));
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
