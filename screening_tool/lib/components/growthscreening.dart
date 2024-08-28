import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/API/urlfile.dart';
import 'package:EarlyGrowthAndBehaviourCheck/components/class/results.dart';
import 'package:EarlyGrowthAndBehaviourCheck/components/custom_button.dart';
import 'package:EarlyGrowthAndBehaviourCheck/components/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:sizer/sizer.dart';


import 'package:http/http.dart' as http;

import '../screens/views/screening_ page.dart';
import '../utils/colors_app.dart';


class Growthbottomsheet extends StatelessWidget {
  final List Conditions;
  final patient_id;
   Growthbottomsheet({Key? key, required this.Conditions, required  this.patient_id}) : super(key: key);

  



  @override
  Widget build(BuildContext Context) {



  void backend() async{
    var url = Growth_done_url;
   
    var data = {
        
    "conditions":Conditions.toString(),
    "id":userid,
    "patient_id":patient_id.toString(),
    "updater_conditions":"Growth",

    };
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        if (message['status']) {
         Navigator.of(Context).push(MaterialPageRoute(
        builder: (context) => screeening_page(patient_id: patient_id))); 
         results.clear();
         print(message['msg']);

        return message['msg'];
              

  
       
        }
        else{
          print(message['Status']);
        }
      }
    } catch(e){
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      print(response.body);
      
    }

  ;

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
        middle: Text("Result",style: TextStyle(fontSize: 15.sp,fontFamily: 'SF-Pro-semibold')),
      ),
      
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: EdgeInsets.all(5.0)),
           
            
            custom_widget(width: 90, height: 17, backgroundColor: widget_color, 
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(5.0)),
              Text("Condition name",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold')),
              Divider(height: 2.h,),
              Gap(3.h),
              for(var item in Conditions ) Text("$item",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro')),

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
              , width: 45, height: 6, backgroundColor: submit_button, textSize: 12, button_funcation: backend, textcolor: lightColor, fontfamily: 'SF-Pro-Bold')
            ],)
        
        ],),
      ));
  }
}