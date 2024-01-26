
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/components/widget_page.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart'as http;

class Edit_report extends StatefulWidget {
  const Edit_report({super.key});

  @override
  State<Edit_report> createState() => _Edit_reportState();
}


TextEditingController Precription = new TextEditingController() ;
TextEditingController Specialist = new TextEditingController() ;
TextEditingController Doctor = new TextEditingController() ;
TextEditingController Condition = new TextEditingController() ;
TextEditingController Suggestion = new TextEditingController() ;


void clear_field(){
  Precription.clear();
  Specialist.clear();
  Doctor.clear();
  Condition.clear();
  Suggestion.clear();

}

bool valid = false;

void submitbutton() async{
  var data = 
    {
    "Precription":Precription.text,
    "Specialist":Specialist.text,
    "Doctor": Doctor.text ,
    "conditions": Condition.text,
    "Suggestion": Suggestion.text,
};
  
   
  if (Precription.text.isNotEmpty && Specialist.text.isNotEmpty &&Doctor.text.isNotEmpty&&Condition.text.isNotEmpty&&Suggestion.text.isNotEmpty){

    var url = editreporturl;
    final response = await http.post(Uri.parse(url),body: jsonEncode(data));
    if(response.statusCode ==200){
      var msg = jsonDecode(response.body);
      if (msg){
        print("sucessfully updated");
        clear_field();

      }
      else{
        print("failed");
      }

 
  

  }


}
else{
  valid = true;
 print(Precription.text);
 print(Specialist.text);
 print(Doctor.text);
 print(Condition.text);
 print(Suggestion.text);
}






}




class _Edit_reportState extends State<Edit_report> {

 

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    print(height);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: SafeArea(
            bottom: true,
            child: appbar_default(title: "Edit Report"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Profile_image_widget(
                    width: 25, height: 15, image: "assets/images/default.jpg"),
                Name_detials_outline(
                    name: "Name", age: "Age", parent_name: "Parent Name"),
                Name_detials_outline(name: ":", age: ":", parent_name: ":"),
                Name_detials_outline(
                    name: "Yuvan", age: "2 yrs", parent_name: "nelson")
              ],
            ),
            Gap(1.5.h),
      
      
      
            Form_widget(prefix: "Precription",t_controller: Precription,vaild:valid ,),
             Form_widget(prefix: "Specialist",t_controller: Specialist,vaild: valid,),
             Form_widget(prefix: "Doctor",t_controller: Doctor,vaild: valid,),
             Form_widget(prefix: "Condition",t_controller: Condition,vaild: valid,),
             Form_widget(prefix: "Suggestion",t_controller: Suggestion,vaild: valid,),
      
      
      
      
            Gap(3.h),
            custom_buttom(
                text: "SUBMIT",
                width: 80,
                height: 6,
                backgroundColor: submit_button,
                textSize: 15,
                button_funcation: (){
                  submitbutton();
                  
                },
                textcolor: lightColor, fontfamily: 'SF-Pro-Bold',)
          ],
        ),
      ),
    );
  }
}








class Form_widget extends StatelessWidget {
  final String prefix;
  final TextEditingController t_controller;

  bool vaild;
   Form_widget({super.key, required this.prefix, required this.t_controller, required this.vaild});

   String? validator(vaild){
    if (vaild){
      return "please enter value";
    }
   
    
    
   }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        
        decoration: BoxDecoration(
          color: widget_color,
          borderRadius: BorderRadius.circular(10)
    
        ),
        child: CupertinoFormRow(
          
          prefix: Text(prefix,style: TextStyle(fontFamily: 'SF-Pro',fontSize: 12.sp),),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 75.w,
              child: CupertinoTextFormFieldRow(
                controller: t_controller,
               
                  
                placeholder: "Value",
                
                decoration: BoxDecoration(
                    color: widget_color, borderRadius: BorderRadius.circular(6)),
                
                 
              ),
            ),
          ),
        ), 
      ),
    );
    
  }
}
