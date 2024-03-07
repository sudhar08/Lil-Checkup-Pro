import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
   social_q({super.key, required this.Age});

  @override
  State<social_q> createState() => _social_qState();
}

class _social_qState extends State<social_q> {
   @override
  void initState(){
    super.initState();
    checkbox();

  }


  checkboxvalues_social sp = checkboxvalues_social();
  void checkbox() async{
    var response = await fetch_Q_A();
    var length = response.length;
    
    for (var i = 0; i < length; i++){
      sp.value(i);
    }
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


  
void submit_btn(){
  social_result grossmotorresults = social_result();
  grossmotorresults.showresults(sp.social,context,widget.Age);
 
  
  
  
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
                Center(child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("social Test",style: TextStyle(fontSize: 14.sp,fontFamily: 'SF-Pro-Bold'),),
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
                                              horizontal: 30.0 ,vertical: 10),
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
                                        var age = int.parse( question['age']);
                                      var patient_age = int.parse( widget.Age);

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
                                          child: Questionsgrowth(yes: sp.checkedbox_social[index]![0] 
                                        , no: sp.checkedbox_social[index]![1], 
                                        onchanged_no :(newvalue){
                                          setState(() {
                                            sp.checkedbox_social[index]![0] = false;
                                            sp.checkedbox_social[index]![1] = newvalue;
                                            if(sp.social.containsKey(age)==true){
                                              sp.social.remove(age);
                                              
                                            }
                                           
                                          });
                                        }
                                        
                                        
                                        , onchanged_yes: (newvalue){
                                          setState(() {
                                            sp.checkedbox_social[index]![0] = newvalue;
                                            sp.checkedbox_social[index]![1] = false;
                                             
                                             if(sp.social.containsKey(age)==false){
                                              sp.social.addAll({age:patient_age});
                                              
                                            }
                                            else{
                                            sp.social.remove(age);
                                            }
                                              
                                            
                                          });
                                        }, index:s_no, Question: q_a,),
                                          
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