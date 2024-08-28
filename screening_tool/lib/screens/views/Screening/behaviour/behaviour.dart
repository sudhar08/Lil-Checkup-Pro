import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../../API/urlfile.dart';
import '../../../../components/Questionwidget.dart';
import '../../../../components/app_bar_all.dart';
import '../../../../components/class/checkboxstore.dart';
import '../../../../components/class/results.dart';
import '../../../../components/custom_button.dart';
import '../../../../utils/colors_app.dart';

class BehaviourPage extends StatefulWidget {
  final  Patient_id;
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
  Widget build(BuildContext context) {
    void radiobuttton() async {
      final response = await fetch_Q_A();
      for (int i = 0; i < response.length; i++) {
        Provider.of<checkboxvaluesbehavior>(context, listen: false)
            .addNewvalue(i);
      }
    }

    radiobuttton();

    void submit_btn() {
      final values = Provider.of<checkboxvaluesbehavior>(context,listen: false).BehaviourRadiovalues;
      BehavoiourPageResult BehaviourPageResult =  new BehavoiourPageResult();
      BehaviourPageResult.showresults(context, widget.Patient_id, values);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(child: appbar_default(title: "Screening", back: true,)),
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
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 10,
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: CupertinoScrollbar(
                          child: ListView.builder(
                              // scrollDirection: Axis.horizontal,
                              itemCount: Question.length + 1,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                //value.addNewvalue(index);
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
                                  var q_a = question['Question'];
                                  //print(Provider.of<checkboxvaluesbehavior>(context,listen: false).BehaviourRadiovalues);
                                    
                                  return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Consumer<checkboxvaluesbehavior>(
                                        builder: (BuildContext context, checkboxvaluesbehavior value, Widget? child) { 
                                        return Questionwidget(
                                            sno: s_no,
                                            Q: q_a,
                                            index: index,
                                            never: value.BehaviourRadiovalues[index],
                                            onchanged_never: (newvalue){
                                              Provider.of<checkboxvaluesbehavior>(context,listen: false).update(index, newvalue);
                                            },
                                            often:value.BehaviourRadiovalues[index],
                                            always: value.BehaviourRadiovalues[index],
                                            onchanged_often: (newvalue){
                                              Provider.of<checkboxvaluesbehavior>(context,listen: false).update(index, newvalue);
                                            },
                                            onchanged_always:
                                                (newvalue){
                                              Provider.of<checkboxvaluesbehavior>(context,listen: false).update(index, newvalue);
                                            },);},
                                      ));
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
