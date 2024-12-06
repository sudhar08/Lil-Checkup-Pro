import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../../API/urlfile.dart';
import '../../../../components/Questionwidget.dart';
import '../../../../components/app_bar_all.dart';
import '../../../../components/class/checkboxstore.dart';
import '../../../../components/class/results.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/prgressbar.dart';  // Assuming IOSProgressBar is here
import '../../../../utils/colors_app.dart';

class BehaviourPage extends StatefulWidget {
  final Patient_id;
  BehaviourPage({super.key, required this.Patient_id});

  @override
  State<BehaviourPage> createState() => _BehaviourPageState();
}

class _BehaviourPageState extends State<BehaviourPage> {
  Future fetch_Q_A() async {
    var url = questionurl;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      List<dynamic> index = message[0];

      return index;
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the radiobuttton function only once on init
    radiobuttton();
  }

  void radiobuttton() async {
    final response = await fetch_Q_A();
    for (int i = 0; i < response.length; i++) {
      Provider.of<checkboxvaluesbehavior>(context, listen: false)
          .addNewvalue(i);
    }
  }

  void submit_btn() {
    final values =
        Provider.of<checkboxvaluesbehavior>(context, listen: false).BehaviourRadiovalues;
    BehavoiourPageResult BehaviourPageResult = new BehavoiourPageResult();
    BehaviourPageResult.showresults(context, widget.Patient_id, values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(child: appbar_default(title: "Screening", back: true)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // iOS Progress Bar at the top
          IOSProgressBar(
            progress: 1/3, // 100% completion
            currentStep: 1,
            totalSteps: 3,
          ),
          // Title for the Test
          Center(
            child: Text(
              "ASD",
              style: TextStyle(fontSize: 14.sp, fontFamily: 'SF-Pro-Bold'),
            ),
          ),
          // Spacer to separate title and list
          SizedBox(height: 1.h),
          
          
          FutureBuilder(
            future: fetch_Q_A(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CupertinoActivityIndicator());


              } else if (snapshot.hasError) {
                return Center(child: Text("Something went wrong: ${snapshot.error}"));


              } else if (snapshot.hasData) {


                var questions = snapshot.data!;
                if (questions.isNotEmpty) {
                return Expanded(


                  child: ListView.builder(
                    itemCount: questions.length + 1,  // +1 for "Next" button
                    itemBuilder: (BuildContext context, int index) {



                      if (index == questions.length) {


                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 30.0),
                          child: custom_buttom(
                            text: "Next",
                            width: 35,
                            height: 6,
                            backgroundColor: submit_button,
                            textSize: 13,
                            button_funcation: submit_btn,
                            textcolor: lightColor,
                            fontfamily: 'SF-Pro-Bold',
                          ),
                        );




                      } else {



                        var question = questions[index];
                        var s_no = question['S.no'];
                        var q_a = question['Question'];
                          



                        return Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: Consumer<checkboxvaluesbehavior>(
                            builder: (context, value, child) {
                              return Questionwidget(
                                sno: s_no,
                                Q: q_a,
                                index: index,
                                never: value.BehaviourRadiovalues[index],
                                onchanged_never: (newvalue) {
                                  value.update(index, newvalue);
                                },
                                often: value.BehaviourRadiovalues[index],
                                always: value.BehaviourRadiovalues[index],
                                onchanged_often: (newvalue) {
                                  value.update(index, newvalue);
                                },
                                onchanged_always: (newvalue) {
                                  value.update(index, newvalue);
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                );
                }

                else {
                      return Column(
                        children: [
                          Container(
                              width: 50.w,
                              height: 30.h,
                              child: RiveAnimation.asset(
                                  "assets/animation/new_file.riv")),
                          SizedBox(
                              width: 60.w,
                              child: Text(
                                "SORRY YOUR ARE NOT ELIGIBLE TO ATTEND THE SCREENING",
                                style: TextStyle(
                                    fontFamily: 'SF-Pro-semibold',
                                    fontSize: 11.sp),
                              ))
                        ],
                      );
                    }
              }
              return Center(child: Text("No data available"));
            },
          ),
        ],
      ),
    );
  }
}
