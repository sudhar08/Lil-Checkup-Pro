import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../../API/urlfile.dart';
import '../../../../components/Growthdevelopement.dart';
import '../../../../components/app_bar_all.dart';
import '../../../../components/class/checkboxstore.dart';
import '../../../../components/class/results.dart';
import '../../../../components/custom_button.dart';
import '../../../../utils/colors_app.dart';

class grossmotor extends StatefulWidget {
  final  Age;
  final patient_id;

  grossmotor({super.key, required this.Age, required this.patient_id});

  @override
  State<grossmotor> createState() => _grossmotorState();
}

class _grossmotorState extends State<grossmotor> {
 
  Future fetch_Q_A() async {
    var url = growthurl;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      List<dynamic> index = message[0];
      return index;
    }
  }

  void submit_btn() {
    grossmotor_results grossmotorresults = grossmotor_results();
    final values = Provider.of<checkboxvalues_growth>(context,listen: false).GROWTHRadiovalues;
     final value = Provider.of<checkboxvalues_growth>(context,listen: false).GrowthageValues;
     print(value);
    grossmotorresults.showresults(value, widget.Age, context,widget.patient_id);
  }

  @override
  Widget build(BuildContext context) {
    
    void radiobuttton() async {
      final response = await fetch_Q_A();
      for (int i = 0; i < response.length; i++) {
        Provider.of<checkboxvalues_growth>(context, listen: false)
            .addNewvalue(i);
      }
      Provider.of<checkboxvalues_growth>(context,listen: false).GrowthageValues.clear();
      results.clear();
    }
radiobuttton();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(child: appbar_default(title: "Screening", back: true,)),
      ),
      body: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Gross Motor Test",
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
                                          width: 20,
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
                                        child: Consumer<checkboxvalues_growth>(
                                          builder: (BuildContext context,
                                              checkboxvalues_growth value,
                                              Widget? child) {
                                            return Newgrowth(
                                                sno: s_no,
                                                Q: q_a,
                                                index: index,
                                                onchanged_yes:
                                                    (newvalue){
                                              Provider.of<checkboxvalues_growth>(context,listen: false).update(index, newvalue);
                                            Provider.of<checkboxvalues_growth>(context,listen: false).addage(age);
                                            

                                            },
                                                onchanged_no:
                                                    (newvalue){
                                              Provider.of<checkboxvalues_growth>(context,listen: false).update(index, newvalue);
                                              Provider.of<checkboxvalues_growth>(context,listen:false).removeage(age);
                                            },
                                                    never: value.GROWTHRadiovalues[index], 
                                                    often: value.GROWTHRadiovalues[index],
                                                    );
                                          },
                                        ));
                                  }
                                })),
                      );
                    } else {
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
                }
                return Center(child: Text("Something went w 😒😒"));
              })
        ],
      ),
    );
  }
}
