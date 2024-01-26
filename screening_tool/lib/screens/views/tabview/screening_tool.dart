// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar.dart';
import 'package:screening_tool/components/widget_page.dart';
import 'package:screening_tool/screens/views/patient/Add_child.dart';
import 'package:screening_tool/screens/views/screening_%20page.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class screening_tool extends StatefulWidget {
  screening_tool({
    super.key,
  });

  @override
  State<screening_tool> createState() => _screening_toolState();
}

class _screening_toolState extends State<screening_tool> {
  var result, name, no_of_patients, list_of_patients;
  String? doc_image_path;

  bool _isloading = false;
  @override
  void initState() {
    super.initState();
    Doc_info();
    fetch_detials();
  }

  var child_name, conditions, lenght;
 
  bool _loading = false;

  Future fetch_detials() async {
    var data = {"id": userid};
    var url = patientviewurl;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message['Status']) {
        return message['pateintinfo'];
        
      }
    }
  }

  
  Future Doc_info() async {
    var data = {"id": userid};
    var url = homeUrl;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    var detials;
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message['Status']) {
        print(doc_image_path.runtimeType);
        detials = message['detials'];
        CupertinoActivityIndicator(radius: 20.0);
        Future.delayed(Duration(milliseconds: 10), () {
          setState(() {
            result = detials;
            name = result['doctor_name'];
            no_of_patients = result['no_of_patient'];
            list_of_patients = int.parse(no_of_patients);
            doc_image_path = result['image_path'].toString().substring(2);

            _isloading = true;
          });
        });
      } else {
        print("no user found");
      }
    } else {
      print("check the internet connection");
    }
  }



  Future <void> _refreshon() async {
    await Future.delayed(Duration(milliseconds: 1000));
    
    await fetch_detials();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {


    return doc_image_path == null
        ? Center(child: CupertinoActivityIndicator(radius: 20.0))
        : Scaffold(
            appBar: PreferredSize(
              child: app_bar(
                title: 'Screening',
                doc_name: name,
                Image_path: doc_image_path!,
              ),
              preferredSize: Size.fromHeight(24.2.h),
            ),
            body: CupertinoPageScaffold(
                child: Column(children: [
              SizedBox(
                height: 25,
              ),
              serach_bar(),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(future: fetch_detials() , builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                    return CupertinoActivityIndicator(radius: 15,);
                    
                  }
                  else if (snapshot.connectionState ==ConnectionState.done){
                    var pateintinfo = snapshot.data;
                    if (snapshot.hasData){
                   return Expanded(
                     child: CustomScrollView(
                          slivers: [
                            CupertinoSliverRefreshControl(
                              onRefresh: _refreshon,
                            ),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext, index) {
                              var patient = pateintinfo![index];
                              child_name = patient['child_name'];
                              conditions = patient['conditions'];
                              var image_path = patient['image_path'];
                              var patient_id = patient['patient_id'];
                              image_path = image_path.toString().substring(2);
                     
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => screeening_page(
                                              patient_id: patient_id,
                                            )));
                                  },
                                  child: List_patient(
                                    name: child_name,
                                    conditions: conditions,
                                    image_path: image_path,
                                  ));
                            }, childCount: pateintinfo.length))
                          ],
                        ),
                   );
              

                      
  }

              }
              else if (snapshot.hasError){
                      return Text("something went wrong");
                    }

                    return  Expanded(
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
                    child: Container(
                      width: 80.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: widget_color,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("NO CHILD FOUND 🫣",style: TextStyle(fontFamily: 'SF-Pro-Bold',fontSize: 13.sp),),
                          GestureDetector(
                            onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => add_new_child()));
                            },
                            child: Text("ADD CHILD",style: TextStyle(fontFamily: 'SF-Pro',fontSize: 13.sp,color: primary_color),))
                      ]),
                    ),
                                  );
                      },childCount: 1)
                        )
                      
                        ]),
                );
              
              
              
              
              
              })






            ])),
          );
  }
}















class List_patient extends StatelessWidget {
  final name, conditions, image_path;
  const List_patient(
      {super.key,
      required this.name,
      required this.conditions,
      required this.image_path});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          name,
          style: TextStyle(
              fontFamily: 'SF-Pro-Bold', fontSize: 17, color: darkColor),
        ),
        subtitle: Text(conditions,
            style: TextStyle(
                fontFamily: 'SF-Pro', fontSize: 17, color: apple_grey)),
        trailing: Icon(
          CupertinoIcons.chevron_right_circle_fill,
          color: primary_color,
          size: 19,
        ),
        leading: SizedBox(
            width: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage("http://$ip/screening$image_path"),
            )));
  }
}
