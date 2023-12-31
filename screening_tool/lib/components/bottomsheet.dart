import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/components/custom_widget.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';

class ModalWithNavigator extends StatelessWidget {
  const ModalWithNavigator({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext Context) {
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
            Padding(padding: EdgeInsets.all(8.0)),
            Container(width: 100.w,height: 12.h,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("YOUR SCORE",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold'),),
                SizedBox(height: 1.h,),
                Text("96",style: TextStyle(fontSize: 22.sp,fontFamily: 'SF-Pro-Bold',color: primary_color),)
                    
            ]),),
            
            custom_widget(width: 90, height: 17, backgroundColor: widget_color, 
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(5.0)),
              Text("Condition name",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold')),
              Divider(height: 2.h,),
              Gap(3.h),
              Text("  Autism spectrum disorder",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro')),

            ],)
            
            
            
            
            
            
            , borderradius: 15.0),
            custom_widget(width: 90, height: 17, backgroundColor: widget_color, 
            
            child:  Column(
              children: [
                Padding(padding: EdgeInsets.all(5.0)),
              Text("Treatment for condition",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold')),
              Divider(height: 2.h,),
              Gap(3.h),
              Text("  Autism spectrum disorder",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro')),

            ],), borderradius: 15.0),
            custom_widget(width: 90, height: 17, backgroundColor: widget_color, 
            
            child:  Column(
              children: [
                Padding(padding: EdgeInsets.all(5.0)),
              Text("Suggestion for the condition",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold')),
              Divider(height: 2.h,),
              Gap(3.h),
              Text("  Autism spectrum disorder",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro')),

            ],), borderradius: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              custom_buttom(text:"Retake"
              , width: 45, height: 6, backgroundColor: widget_color, textSize: 12, button_funcation: (){

                Navigator.pop(Context);
              }, textcolor: darkColor, fontfamily: 'SF-Pro-Bold'),
              custom_buttom(text:"Done"
              , width: 45, height: 6, backgroundColor: submit_button, textSize: 12, button_funcation: (){
                  Navigator.pop(Context);

              }, textcolor: darkColor, fontfamily: 'SF-Pro-Bold')
            ],)
        
        ],),
      ));
  }
}