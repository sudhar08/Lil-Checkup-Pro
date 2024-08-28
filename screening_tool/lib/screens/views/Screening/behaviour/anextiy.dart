import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/components/Questionwidget.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../API/urlfile.dart';
import '../../../../components/app_bar_all.dart';
import '../../../../components/class/checkboxstore.dart';
import '../../../../components/custom_button.dart';
import '../../../../utils/colors_app.dart';

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

  
  void checkbox() async {
    var response = await fetch_Q_A();
    var length = response.length;

    for (var i = 0; i < length; i++) {
      Provider.of<checkboxvaluesAxienty>(context,listen: false).addNewvalue(i);
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
    final Values = Provider.of<checkboxvaluesAxienty>(context,listen: false).AxientyRadiovalues;
   // AnextiyPageResult ah = new AnextiyPageResult();
    //ah.showresults(context,widget.patient_id, Values);

    
  }

  @override
  Widget build(BuildContext context) {
    return screeening_page_loading == false
        ? Center(
            child: CupertinoActivityIndicator(
              radius: 15.0,
            ),
          )
        : Scaffold(
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
                                        return Consumer<checkboxvaluesAxienty>(
                                          builder: (BuildContext context, checkboxvaluesAxienty value, Widget? child) {  
                                          return Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Questionwidget(
                                                Q: q_a,
                                                sno: s_no,
                                                 index: index,
                                                 never: value.AxientyRadiovalues[index],
                                                 often: value.AxientyRadiovalues[index],
                                                 always: value.AxientyRadiovalues[index],
                                                 onchanged_always: (newValue){
                                                  Provider.of<checkboxvaluesAxienty>(context,listen: false).update(index, newValue);
                                                 },
                                                 onchanged_never: (newValue){
                                                  Provider.of<checkboxvaluesAxienty>(context,listen: false).update(index, newValue);
                                                 },
                                                 onchanged_often: (newValue){
                                                  Provider.of<checkboxvaluesAxienty>(context,listen: false).update(index, newValue);
                                                 },
                                                 
                                                 
                                                 )
                                              );
                                      });
                        }},
                          )));
                        }
                      }
                      return Text("something went wrong😒");
                    })
              ],
            ),
          );
  }
}
