import 'package:EarlyGrowthAndBehaviourCheck/components/DeleteAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../../../components/app_bar_all.dart';
import '../../../../components/class/results.dart';
import '../../../../utils/colors_app.dart';


class Accountpage extends StatelessWidget {
  const Accountpage({super.key});


void popsheet(BuildContext context){
       showCupertinoModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      expand: false,
      backgroundColor: Colors.transparent, context: context,
      //duration: Duration(milliseconds: 500),
      builder: (context) => Container(
        width: 100.w,
        height: 60.h,
        child: Deleteaccountsheet(),
        
       )
      );
    // );
  }

  

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: 
            
            SafeArea(child: appbar_default(title: "Account", back: true,))),

      body: 
           CupertinoListSection(
            header: Text("Account",),
                               
                                backgroundColor: lightColor,
                                children: [
                                   CupertinoListTile.notched(
                                  title: Text("Edit profile"),
                                  padding: EdgeInsets.all(15),
                                 // backgroundColor: widget_color,
                                 //onTap: account_page ,
                                
                                  leading: Icon(CupertinoIcons.pencil_circle,color: primary_color,size: 20,),
                                ),
                                 CupertinoListTile.notched(
                                  title: Text("Change Password"),
                                  padding: EdgeInsets.all(15),
                                 // backgroundColor: widget_color,
                                  leading: Icon(CupertinoIcons.lock_circle,color: primary_color,),
                                  //trailing: Icon(CupertinoIcons.chevron_right,color: primary_color,size: 20,),
                                ),
                                CupertinoListTile.notched(
                                  title: Text("Delete Account"),
                                  padding: EdgeInsets.all(15),
                                  onTap: (){
                                    popsheet(context);
                                  },
                                 // backgroundColor: widget_color,
                                  leading: Icon(CupertinoIcons.delete,color: redcolor,),
                                  //trailing: Icon(CupertinoIcons.chevron_right,color: primary_color,size: 20,),
                                ),
        ],
      )
      
    );
  }
}