
import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';

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
import 'package:screening_tool/screens/views/Screening/behaviour/anextiy.dart';
import 'package:screening_tool/screens/views/Screening/growth/finemotor.dart';
import 'package:screening_tool/screens/views/Screening/growth/speechs.dart';

import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;


class FineMotor extends StatefulWidget {
  final Age;
   FineMotor({super.key, required this.Age});

  @override
  State<FineMotor> createState() => _FineMotorState();
}

class _FineMotorState extends State<FineMotor> {
 @override
  void initState(){
    super.initState();
    checkbox();

  }


  checkboxvalues_fine fn = checkboxvalues_fine();
  void checkbox() async{
    var response = await fetch_Q_A();
    var length = response.length;
    
    for (var i = 0; i < length; i++){
      fn.value(i);
    }
  }


  Future fetch_Q_A() async {
    var url = fineurl;

    var data = {
      'age':widget.Age
    };

    final response = await http.post(Uri.parse(url),body: jsonEncode(data));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      List<dynamic> index = message[0];
      return index;
    }
  }
  
void submit_btn(){
  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => speechs(Age: widget.Age)));
  
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
                  child: Text("Fine Motor Test",style: TextStyle(fontSize: 14.sp,fontFamily: 'SF-Pro-Bold'),),
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
                                          padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
                                          child: Questionsgrowth(yes: fn.checkedbox_fine[index]![0] 
                                        , no: fn.checkedbox_fine[index]![1], 
                                        onchanged_no :(newvalue){
                                          setState(() {
                                            fn.checkedbox_fine[index]![0] = false;
                                            fn.checkedbox_fine[index]![1] = newvalue;
                                            
                                          });
                                        }
                                        
                                        
                                        , onchanged_yes: (newvalue){
                                          setState(() {
                                            fn.checkedbox_fine[index]![0] = newvalue;
                                            fn.checkedbox_fine[index]![1] = false;
                                            
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