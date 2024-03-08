import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/Growthdevelopement.dart';
import 'package:screening_tool/components/Questionwidget.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/class/checkboxstore.dart';
import 'package:screening_tool/components/class/results.dart';

import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/screens/auth_screens/signuppage.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/anextiy.dart';
import 'package:screening_tool/screens/views/Screening/growth/finemotor.dart';
import 'package:screening_tool/screens/views/Screening/growth/social.dart';

import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class speechs extends StatefulWidget {
  final Age;
  final patient_id;
  const speechs({super.key, required this.Age, required this.patient_id});

  @override
  State<speechs> createState() => _speechsState();
}

class _speechsState extends State<speechs> {
  @override
  void initState() {
    super.initState();
    checkbox();
  }

  checkboxvalues_speechs sp = checkboxvalues_speechs();
  void checkbox() async {
    var response = await fetch_Q_A();
    var length = response.length;

    for (var i = 0; i < length; i++) {
      sp.value(i);
    }
  }

  Future fetch_Q_A() async {
    var url = speechurl;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        List<dynamic> index = message[0];
        return index;
      }
    } catch (e) {
      print("object");
      RiveAnimation.asset("assets/animation/404_cat.riv");
    }
  }

  void submit_btn() {
    speech_result grossmotorresults = speech_result();
    grossmotorresults.showresults(sp.speech, context, widget.Age,widget.patient_id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.Age);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(child: appbar_default(title: "Screening")),
      ),
      body: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Speechs Test",
              style: TextStyle(fontSize: 14.sp, fontFamily: 'SF-Pro-Bold'),
            ),
          )),
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
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (Question.isNotEmpty) {
                      return Expanded(
                        child: CupertinoScrollbar(
                            child: ListView.builder(
                                itemCount: Question.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == Question.length) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 10),
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
                                    var age = int.parse(question['age']);
                                    var patient_age = int.parse(widget.Age);

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 35, vertical: 10),
                                      child: Questionsgrowth(
                                        yes: sp.checkedbox_speechs[index]![0],
                                        no: sp.checkedbox_speechs[index]![1],
                                        onchanged_no: (newvalue) {
                                          setState(() {
                                            sp.checkedbox_speechs[index]![0] =
                                                false;
                                            sp.checkedbox_speechs[index]![1] =
                                                newvalue;


                                               if (sp.speech.containsKey(age) ==
                                                true) {
                                              sp.speech.remove(age);
                                            }
                                            
                                          });
                                        },
                                        onchanged_yes: (newvalue) {
                                          setState(() {
                                            sp.checkedbox_speechs[index]![0] =
                                                newvalue;
                                            sp.checkedbox_speechs[index]![1] =
                                                false;
                                                if (sp.speech.containsKey(age) ==
                                                false) {
                                              sp.speech
                                                  .addAll({age: patient_age});
                                            } else {
                                              sp.speech.remove(age);
                                            }
                                           
                                          });
                                        },
                                        index: s_no,
                                        Question: q_a,
                                      ),
                                    );
                                  }
                                })),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 80.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    //color: widget_color,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(children: [
                                  SizedBox(
                                      width: 80.w,
                                      height: 30.h,
                                      child: RiveAnimation.asset(
                                          "assets/animation/sad.riv")),
                                  Text(
                                    "Sorry your not able to attend this test",
                                    style: style_text_bold,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: custom_buttom(
                                        text: "Next",
                                        width: 60,
                                        height: 6,
                                        backgroundColor: primary_color_shadow,
                                        textSize: 13,
                                        button_funcation: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      social_q(
                                                          Age: widget.Age, patient_id: widget.patient_id,)));
                                        },
                                        textcolor: darkColor,
                                        fontfamily: 'SF-Pro-Bold'),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                }
                return Container(
                    width: 100.w,
                    height: 50.h,
                    child: RiveAnimation.asset("assets/animation/404_cat.riv"));
              })
        ],
      ),
    );
  }
}
