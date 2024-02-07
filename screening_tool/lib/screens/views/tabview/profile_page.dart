import 'dart:convert';


import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/components/custom_widget.dart';
import 'package:screening_tool/screens/auth_screens/login_page.dart';

import 'package:screening_tool/screens/views/tabview/profile/edit_profile.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;




class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {

void alertdilog(){
      showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Are sure to Logout?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context,"no");
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {

             
                  Navigator.of(context,rootNavigator: true).pop();


                 Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                    builder: (context) => Login_page()));
                 
             
              
             
              
                
              
              
              
            },
            child: const Text('Yes'),
          ),
        
      ]),
    );

    }

  void btn_fun() {
   alertdilog();
  }
  void editbtn(){
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => edit_profile()));
  } 


@override
void initState(){
  super.initState();
  doctor_info();

  
}



var result,name,age,image_path,location,no_of_patient;


Future doctor_info() async {
    var data = {"id": userid};
    var url = doctorurl;
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        if (message['Status']) {
        
         
        return message['doctorinfo'];
              

  
       
        }
      }
    } catch (e) {
      CupertinoActivityIndicator(
          radius: 30.0, color: CupertinoColors.activeBlue);
    }
  }


 Future<void> _refreshon() async{
    await Future.delayed( Duration(milliseconds: 1000));
    doctor_info();
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return 
    
    Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: 
            
            SafeArea(child: appbar_default(title: "Profile",))),



        body: FutureBuilder(future: doctor_info() , 
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if (snapshot.connectionState == ConnectionState.waiting){
                    return CupertinoActivityIndicator(radius: 15.0,);}

          else if (snapshot.connectionState ==ConnectionState.done){
                    var Doctorinfo = snapshot.data;
                    if (snapshot.hasData){
                     return CustomScrollView(
                       slivers: [
                        CupertinoSliverRefreshControl(onRefresh: _refreshon,),
                         SliverList(delegate: SliverChildBuilderDelegate(
                           (BuildContext, index){
                             
                           name = Doctorinfo['doctor_name'];
                           age = Doctorinfo['age'];
                           no_of_patient = Doctorinfo['no_of_patient'];
                           location = Doctorinfo['location'];
                           image_path = Doctorinfo['image_path'].toString().substring(2);
                           
                                      
                     
                     
                                      return Column(children: [
                               
                               
                               
                                 //name card starts!!!!!!!
                               
                                 Padding(
                                   padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                                   child: Container(
                                     width: size.width.w,
                                     height: 20.h,
                                     decoration: BoxDecoration(
                       color: widget_color, borderRadius: BorderRadius.circular(20)),
                               
                                     // inside name card startss!!!!!
                               
                                     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                     // profile picture starts!!!
                     
                     Padding(
                       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                       child: Container(
                         width: 25.w,
                         height: 12.h,
                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: NetworkImage("http://$ip/screening$image_path")),
                             shape: BoxShape.circle),
                       ),
                     ),
                               
                               
                     //space
                               
                     SizedBox(
                       width: 5.w,
                     ),
                               
                     // detials label starts!!
                               
                     Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         SizedBox(
                           height: 1.h,
                         ),
                         Text(
                           "Name :",
                           style: TextStyle(fontSize: 17.sp, fontFamily: 'SF-Pro'),
                         ),
                         Text(
                           "Age : ",
                           style: TextStyle(fontFamily: 'SF-Pro', fontSize: 17.sp),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(right: 30),
                           child: Icon(
                             CupertinoIcons.pin_fill,
                             size: 25,
                             color: primary_color,
                           ),
                         )
                       ],
                     ),
                               
                     // detials starts!!!!!
                               
                     Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         SizedBox(
                           height: 1.h,
                         ),
                         Text(
                           "Dr.$name",
                           style: TextStyle(fontFamily: 'SF-Pro', fontSize: 17.sp),
                         ),
                         Text(
                           "$age yrs",
                           style: TextStyle(fontFamily: 'SF-Pro', fontSize: 17.sp),
                         ),
                         Text(
                           location!=""?location:"Location",
                           style: TextStyle(fontFamily: 'SF-Pro', fontSize: 17.sp),
                         )
                       ],
                     ),
                                     ]),
                                   ),
                                 ),
                               
                                 /// button starts here  !!!!!!!
                               
                                 custom_buttom(
                                   text: "Edit Profile",
                                   width: 70,
                                   textSize: 15,
                                   height: 6,
                                   backgroundColor: widget_color,
                                   textcolor: darkColor,
                                   icon: CupertinoIcons.pencil,
                                   button_funcation: () {
                                     editbtn();
                                   }, fontfamily: 'SF-Pro',
                                 ),
                               // spacer fro padding
                               
                                 SizedBox(
                                   height: 8.h,
                                 ),
                               
                                 /// report widget starts here !!!!!!!
                               
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     custom_widget(
                     width: 35,
                     height: 15,
                     backgroundColor: widget_color,
                     borderradius: 20,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Icon(
                           CupertinoIcons.person_2_fill,
                           size: 28,
                           color: darkColor,
                         ),
                         Text(
                           "No of Patients ",
                           style: TextStyle(
                               fontFamily: 'SF-Pro-Bold',
                               fontSize: 12.sp,
                               color: darkColor),
                         ),
                         Text(
                           no_of_patient,
                           style: TextStyle(
                               fontFamily: 'SF-Pro-Bold',
                               fontSize: 17,
                               color: primary_color),
                         ),
                       ],
                     ),
                                     ),
                                     custom_widget(
                     width: 40,
                     height: 15,
                     backgroundColor: widget_color,
                     borderradius: 20,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Icon(
                           CupertinoIcons.doc_chart,
                           size: 28,
                           color: darkColor,
                         ),
                         Text(
                           "Completed Report ",
                           style: TextStyle(
                               color: darkColor,
                               fontFamily: 'SF-Pro-Bold',
                               fontSize: 12.sp),
                         ),
                         Text(
                           "100",
                           style: TextStyle(
                               color: primary_color,
                               fontFamily: 'SF-Pro-Bold',
                               fontSize: 17),
                         )
                       ],
                     ),
                                     ),
                                   ],
                                 ),
                               
                                 SizedBox(
                                   height: 15.5.h,
                                 ),
                               
                                 // logut button for the page that displays
                               
                                 custom_buttom(
                                     text: "LOGOUT ",
                                     width: 75,
                                     height: 6.5,
                                     backgroundColor: widget_color,
                                     textSize: 18,
                                     button_funcation: (){
                                      btn_fun();
                     
                                     },
                                     icon: Icons.logout,
                                     textcolor:redcolor, fontfamily: 'SF-Pro-Bold',)
                               ]);
                               },
                               childCount: 1
                                   ))
                                 ],
                     
                     
                               );
          // profile main page;
  }
  else{
    return Text("data");
  }
  
  }

  
 return Text("Something went wrong");



})

        );
  }
}







