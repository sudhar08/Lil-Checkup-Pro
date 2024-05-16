import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/Growthdevelopement.dart';
import 'package:screening_tool/components/Questionwidget.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/bottomsheet.dart';
import 'package:screening_tool/components/class/checkboxstore.dart';
import 'package:screening_tool/components/class/results.dart';

import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/components/growthscreening.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/anextiy.dart';
import 'package:screening_tool/screens/views/Screening/growth/finemotor.dart';

import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class social_q extends StatefulWidget {
  final Age;
  final patient_id;
  social_q({super.key, required this.Age, required this.patient_id});

  @override
  State<social_q> createState() => _social_qState();
}

class _social_qState extends State<social_q> {
  @override
  void initState() {
    super.initState();
  }

  Future fetch_Q_A() async {
    var url = socialurl;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      List<dynamic> index = message[0];
      return index;
    }
  }

  void submit_btn() {
    social_result grossmotorresults = social_result();
    var value = Provider.of<checkboxvalues_social>(context,listen: false).socialageValues;
    grossmotorresults.showresults(
        value, context,  widget.patient_id ,widget.Age,);
  }

  @override
  Widget build(BuildContext context) {
    void radiobuttton() async {
      final response = await fetch_Q_A();
      for (int i = 0; i < response.length; i++) {
        Provider.of<checkboxvalues_social>(context, listen: false)
            .addNewvalue(i);
      }
    }

    radiobuttton();

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
              "social Test",
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
                                        text: "Done",
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
                                    child: Consumer<checkboxvalues_social>(
                                      builder: (BuildContext context,
                                          checkboxvalues_social value,
                                          Widget? child) {
                                        return Newgrowth(
                                            sno: s_no,
                                            Q: q_a,
                                            index: index,
                                            onchanged_no: (newvalue) {
                                              Provider.of<checkboxvalues_social>(
                                                      context,
                                                      listen: false)
                                                  .update(index, newvalue);
                                              Provider.of<checkboxvalues_social>(
                                                      context,
                                                      listen: false)
                                                  .addage(age);
                                            },
                                            onchanged_yes: (newvalue) {
                                              Provider.of<checkboxvalues_social>(
                                                      context,
                                                      listen: false)
                                                  .update(index, newvalue);
                                              Provider.of<checkboxvalues_social>(
                                                      context,
                                                      listen: false)
                                                  .addage(age);
                                            },
                                            never:
                                                value.socialRadiovalues[index],
                                            often:
                                                value.socialRadiovalues[index]);
                                      },
                                    ),
                                  );
                                }
                              })),
                    );
                  }
                }
                return Center(child: Text("Something went wrong 😒😒"));
              })
        ],
      ),
    );
  }
}
