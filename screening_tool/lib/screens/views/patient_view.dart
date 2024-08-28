import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/screens/views/patient/Add_child.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/patient/child_report.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/patient/edit_child_detials.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../../API/urlfile.dart';
import '../../components/app_bar.dart';
import '../../utils/colors_app.dart';



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

String serachKeyword = "";
TextEditingController controller = new TextEditingController();

 List _search(String Keyword,List data){
 if (Keyword.isEmpty) return data;
    return data.where((item) => item["child_name"].toString().toLowerCase().contains(Keyword.toLowerCase())).toList();
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
               Padding(
      padding: const EdgeInsets.only(left: 10,right: 10 ),
      child: SizedBox(
        width: 380,
      
        child: CupertinoSearchTextField(
          backgroundColor: widget_color,autocorrect: true,
          placeholder: "eg: John",
          controller: controller,
         onChanged: (value) => setState(() => serachKeyword = value),
        ),
      ),
    ),
              Gap(2.h),
              FutureBuilder(future:Patient_info(), builder: (BuildContext context, AsyncSnapshot snapshot){
                
                if (snapshot.connectionState == ConnectionState.waiting){
                    return CupertinoActivityIndicator(radius: 10,);
                    
                  }
                  else if (snapshot.connectionState ==ConnectionState.done){
                    if (snapshot.hasData){
                       final filterd_list = _search(serachKeyword, snapshot.data!);
                   
                      return Expanded(
                        child: CupertinoScrollbar(
                          child: CustomScrollView(
                            
                             
                            slivers: [
                              CupertinoSliverRefreshControl(
                                onRefresh: _refreshon,
                                refreshTriggerPullDistance: 80,
                              ),
                             
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    
                                      (BuildContext, int index) {

                                var items = filterd_list[index];
                                name = items['child_name'];
                                age = items['age'];
                                conditions = items['problem'];
                                patient_id = items['patient_id'];
                                imagepath = items['image_path'];
                                imagepath = imagepath.toString().substring(2);
                                
                                print(GlobalKey_deleted);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                                  child: FadeInUp(
                                    duration: Duration(milliseconds: 700),
                                    child: patient_widget(
                                      name: name,
                                      age: age,
                                      
                                      patient_id: patient_id,
                                      imagepath: imagepath, index: index,
                                    ),
                                  ),
                                );
                              }, childCount: filterd_list.length))
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

  final String imagepath;
  final int index;
  const patient_widget(
      {super.key,
      required this.patient_id,
      required this.name,
      required this.age,
      
      required this.imagepath, required this.index
      
      
      });

  @override
  State<patient_widget> createState() => _patient_widgetState();
}

class _patient_widgetState extends State<patient_widget> {


  @override
  void initState(){
     super.initState();
     agecal();
  }


String? Age;


void agecal(){
  var age = DateTime.parse(widget.age);
  var cal = AgeCalculator.age(age);
          if (cal.years <= 0) {
             Age = cal.months.toString() + "months";
           
          } else {
            Age = cal.years.toString() + "yrs";
            
          }


}



  @override
  Widget build(BuildContext context) {
     //final ValueNotifier<bool> isMenuOpen = ValueNotifier(false);

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



    return CupertinoContextMenu.builder(
      
      enableHapticFeedback: true,
      // previewBuilder:
      //     (BuildContext context, Animation<double> animation, Widget child) {
      //   return SizedBox(
      //     height: 150,
      //     width: 150,
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(84),
      //       child: Image.network(
      //         "http://$ip/screening/${widget.imagepath}",
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   );
      // },
      actions: [
        CupertinoContextMenuAction(
          child: Text("Name : ${widget.name}"),
          isDefaultAction: true,
          
          
          ),


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
        ),

      ],

      builder: (BuildContext context, Animation<double> animation) {  

          
        // print("open values : ${animation.}");





       return animation.isCompleted? SizedBox(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(84),
            child: Image.network(
              "http://$ip/screening/${widget.imagepath}",
              fit: BoxFit.cover,
            ),
          ))
:Container(
        width: 50.w,
        height: 23.h,
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
                      Age!,
                      style:
                          TextStyle(fontFamily: 'SF-Pro', fontSize: 15.sp),
                    ),
                  ],
                ),
              ],
            ),
            Gap(1.h),
      
      
      
      
      
         
      
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
              child: Container(
                width: 100.w,
                height: 6.h,
                //color: darkColor,
                child: Text(
                    "View",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'SF-Pro-Bold',
                        fontSize: 15.sp,
                        color: primary_color),
                  ),
              ),
            )
          ],
        ),
      );
      
      
      
      
      
      
      }
    );
  }
}
