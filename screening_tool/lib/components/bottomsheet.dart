
import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/components/custom_button.dart';
import 'package:EarlyGrowthAndBehaviourCheck/components/custom_widget.dart';
import 'package:EarlyGrowthAndBehaviourCheck/components/pichart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:sizer/sizer.dart';

import '../API/urlfile.dart';
import '../screens/views/screening_ page.dart';
import '../utils/colors_app.dart';



class ModalWithNavigator extends StatelessWidget{
  final  int Score;
  final  behaviour;
  final  anextiy;
  final  depression;
  final adhd;
  final List ConditionName;
  final patient_id;
   ModalWithNavigator({Key? key, required this.Score, required this.behaviour, required this.anextiy, required this.depression, required this.ConditionName,  required this.patient_id, required this.adhd}) : super(key: key);

  



  @override
  Widget build(BuildContext Context) {

   void backend() async{
    var url = done_url;
   
    var data = {
        
    "conditions":ConditionName.toString(),
    "id":userid,
    "patient_id":patient_id.toString(),
    "updater_conditions":"Behaviour",

    };
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        if (message['status']) {
          Fluttertoast.showToast(
          msg: "Sucessfully Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

         Navigator.of(Context).push(MaterialPageRoute(
        builder: (context) => screeening_page(patient_id: patient_id))); 
         print(patient_id);
        return message['msg'];
              

  
       
        }
        else{;
          print(message['Status']);
        }
      }
    } catch(e){
      print("object");
    }

  ;

}

void done(){
  backend();
}

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pop(Context);
            },
            child: Text("Cancel",style: TextStyle(fontSize: 15.sp,fontFamily: 'SF-Pro',color: primary_color),)),
        ),
        middle: Text("Score",style: TextStyle(fontSize: 15.sp,fontFamily: 'SF-Pro-Bold')),
      ),
      
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: EdgeInsets.all(5.0)),
            Container(width: 100.w,height: 12.h,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             
              Text("TOTAL SCORE",style: TextStyle(fontSize: 15.sp,fontFamily: 'SF-Pro-bold')),
              SizedBox(height: 1.h,),
              Text("$Score",style: TextStyle(fontSize:22.sp,fontFamily: 'SF-Pro-bold',color: primary_color),
        )]),),



                pieChart(attention: behaviour.toDouble(), anextiy: anextiy.toDouble(), depression: depression.toDouble(), adhd: adhd.toDouble(),),








            
            custom_widget(width: 90, height: 2.5.h, backgroundColor: widget_color, 
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(5.0)),
              Text("Conditions ",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold')),
              Divider(height: 2.h,),
              Gap(1.5.h),
              Text(ConditionName.map((value) => '$value').join('\n'),style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-semibold')),

            ],)
            
            , borderradius: 15.0),
            
            
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              custom_buttom(text:"Retake"
              , width: 48, height: 6, backgroundColor: widget_color, textSize: 12, button_funcation: (){

                Navigator.pop(Context);
              }, textcolor: darkColor, fontfamily: 'SF-Pro-Bold'),
              custom_buttom(text:"Done"
              , width: 45, height: 6, backgroundColor: submit_button, textSize: 12, button_funcation: done, textcolor: lightColor, fontfamily: 'SF-Pro-Bold')
            ],)
        
        ],),
      ));
  }
}
