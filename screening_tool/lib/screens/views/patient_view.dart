import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:screening_tool/API/urlfile.dart';
import 'package:get/get.dart';
import 'package:screening_tool/components/app_bar.dart';
import 'package:screening_tool/components/widget_page.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:screening_tool/screens/auth_screens/signuppage.dart';
import 'package:screening_tool/screens/views/patient/Add_child.dart';
import 'package:screening_tool/screens/views/patient/child_report.dart';
import 'package:screening_tool/screens/views/patient/edit_child_detials.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';



var GlobalKey_deleted;
class Patient_screen extends StatefulWidget {
  final String image_path;

  final String name;
  const Patient_screen({
    super.key,
    required this.name,
    required this.image_path,
  });

  @override
  State<Patient_screen> createState() => _Patient_screenState();
}

class _Patient_screenState extends State<Patient_screen> {
  
  var name,
      age,
      patient_id,
      parent_name,
      conditions,
      imagepath,
      list_of_patients,
      length;
  bool _loading = false;
  var summa;

  @override
  void initState() {
    super.initState();
   
    Patient_info();
  }

 
  Future<dynamic> Patient_info() async {
    var data = {"id": userid};
    var url = patientviewurl;
    try {
      
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        if (message['Status']) {
    
        return message['pateintinfo'];
    
        }
      }
    } catch (e) {
      CupertinoActivityIndicator(
          radius: 15.0, color: CupertinoColors.activeBlue);
    }
  }

  Future<void> _refreshon() async {
    await Future.delayed(Duration(milliseconds: 1000));
    
    await Patient_info();
    setState(() {});
  }


Stream <dynamic> mystream() {
  return Stream.fromFuture(this.Patient_info());
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(24.h),
          child: app_bar(
            title: "Patient Record",
            icon: CupertinoIcons.chevron_back,
            doc_name: widget.name,
            Image_path: widget.image_path,
          )),
      body:  Column(children: <Widget>[
              SizedBox(
                height: 3.h,
              ),
              serach_bar(),
              Gap(2.h),
              FutureBuilder(future:Patient_info(), builder: (BuildContext context, AsyncSnapshot snapshot){
                var pateint = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting){
                    return CupertinoActivityIndicator(radius: 15,);
                    
                  }
                  else if (snapshot.connectionState ==ConnectionState.done){
                    if (snapshot.hasData){
                   
                      return Expanded(
                        child: CupertinoScrollbar(
                          child: CustomScrollView(
                            scrollBehavior: CupertinoScrollBehavior(),
                            
                            slivers: [
                              CupertinoSliverRefreshControl(
                                onRefresh: _refreshon,
                                refreshTriggerPullDistance: 80,
                              ),
                             
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext, int index) {
                                var items = pateint![index];
                                name = items['child_name'];
                                age = items['age'];
                                conditions = items['conditions'];
                                patient_id = items['patient_id'];
                                imagepath = items['image_path'];
                                imagepath = imagepath.toString().substring(2);
                                conditions = conditions.toString();
                                print(GlobalKey_deleted);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 18),
                                  child: FadeInUp(
                                    duration: Duration(milliseconds: 700),
                                    child: patient_widget(
                                      name: name,
                                      age: age,
                                      conditions: conditions,
                                      patient_id: patient_id,
                                      imagepath: imagepath, index: index,
                                    ),
                                  ),
                                );
                              }, childCount: pateint.length))
                            ],
                          ),
                        ),
                      );
                    }

                    else if (snapshot.hasError){
                      return Text("something went wrong");
                    }




                  }
                  
                

                return Expanded(
                  child: CustomScrollView(
                    
                    slivers: [
                      CupertinoSliverRefreshControl(
                              onRefresh: _refreshon,
                              refreshTriggerPullDistance: 80,
                            ),
                      SliverPadding(padding: EdgeInsets.symmetric(vertical: 50)
                      ),
                      SliverList(delegate: SliverChildBuilderDelegate(
                     ( BuildContext, int index) {
                        return Center(
                    child: Column(
                      children: [
                        Container(
                          width: 80.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            //color: widget_color,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             SizedBox(
                              width: 80.w,
                              height: 25.h,
                              child: RiveAnimation.asset("assets/animation/cat_no_results_found.riv"),
                             ),
                              
                          ]),
                        ),
                        GestureDetector(
                            onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => add_new_child()));
                            },
                            child: Text("ADD CHILD",style: TextStyle(fontFamily: 'SF-Pro',fontSize: 13.sp,color: primary_color),))
                      ],
                    ),
                                  );
                      },childCount: 1)
                        )
                      
                        ]),
                );
                

              })
            ])
          
    );
  }
}

class patient_widget extends StatefulWidget {
  final patient_id;
  final String name;
  final String age;
  final String conditions;
  final String imagepath;
  final int index;
  const patient_widget(
      {super.key,
      required this.patient_id,
      required this.name,
      required this.age,
      required this.conditions,
      required this.imagepath, required this.index
      
      
      });

  @override
  State<patient_widget> createState() => _patient_widgetState();
}

class _patient_widgetState extends State<patient_widget> {


  @override
  void initState(){
     super.initState();
  }






  @override
  Widget build(BuildContext context) {


    void animated(){
      AnimatedSnackBar.material("messageText", type: AnimatedSnackBarType.success);
    }






    void Delete_child() async {
      var data = {"patient_id": widget.patient_id};
      var url = delete_childurl;

      final responses = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (responses.statusCode == 200) {
        var msg = jsonDecode(responses.body);
        if (msg['status']) {
        animated();
        } else {
          print("unable to delete");
        }
      } else {
        print("something went wrong");
      }
    }

   


void showToast(BuildContext context){
  Fluttertoast.showToast(
                    msg: "Login sucessfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
}
    return CupertinoContextMenu(
      previewBuilder:
          (BuildContext context, Animation<double> animation, Widget child) {
        return SizedBox(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(84),
            child: Image.network(
              "http://$ip/screening/${widget.imagepath}",
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      actions: [
        Builder(
          builder: (context) {
            return CupertinoContextMenuAction(
              onPressed: () {
                
                 
                 Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.of(context).pop();
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => Edit_new_child(
                            patient_id: widget.patient_id!,
                           )));
                 });
              },
              isDefaultAction: true,
              trailingIcon: CupertinoIcons.pencil_circle,
              child: const Text('Edit'),
            );
          }
        ),
        Builder(
          builder: (context) {
            return CupertinoContextMenuAction(
              onPressed: () {
                 
                Navigator.of(context,rootNavigator: true).pop();
                showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Delete'),
          content: const Text('Are sure to delete?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context, "no");
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction( 
              isDestructiveAction: true,
              onPressed: () {
                Delete_child();
                
        
                 Future.delayed(Duration(seconds: 1), () {
                
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                    msg: "Deleted successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
                    

                 });
                 
                 
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
              },
              isDestructiveAction: true,
              trailingIcon: CupertinoIcons.trash,
              child: const Text('Delete'),
            );
          }
        )
      ],

      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        child: SizedBox(
          width: 100.h,
          child: Container(
            width: 50.w,
            height: 25.h,
            decoration: BoxDecoration(
                color: widget_color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primary_color_shadow,
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(0, 3.54),
                  )
                ]),
            child: Column(
              children: [
                Gap(2.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // profile picture fro the  patient table
                    Container(
                      width: 17.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //color: apple_grey
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://$ip/screening${widget.imagepath}"),
                              fit: BoxFit.fill)),
                    ),

                    // title FOR THE patient table

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Patient ID",
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                        Gap(0.5.h),
                        Text(
                          "Name",
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                        Gap(0.5.h),
                        Text(
                          "Age",
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ":",
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                        Gap(0.5.h),
                        Text(
                          ":",
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                        Gap(0.5.h),
                        Text(
                          ":",
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.patient_id,
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                        Gap(0.5.h),
                        Text(
                          widget.name,
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                        Gap(0.5.h),
                        Text(
                          widget.age,
                          style:
                              TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(1.h),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    widget.conditions.toString(),
                    style: TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 17),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => child_report(
                                patient_id: widget.patient_id,
                              )));
                    },
                    child: Text(
                      "View",
                      style: TextStyle(
                          fontFamily: 'SF-Pro-Bold',
                          fontSize: 15.sp,
                          color: primary_color),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
