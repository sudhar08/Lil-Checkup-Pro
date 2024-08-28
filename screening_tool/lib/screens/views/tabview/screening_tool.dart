// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/screens/views/patient/Add_child.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/screening_%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../API/urlfile.dart';
import '../../../components/app_bar.dart';
import '../../../utils/colors_app.dart';

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
 
  

  Future fetch_detials() async {
    var data = {"id": userid};
    var url = patientviewurl;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data)).timeout(const Duration(seconds: 10));
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


String serachKeyword = "";
TextEditingController controller = new TextEditingController();

 List _search(String Keyword,List data){
 if (Keyword.isEmpty) return data;
    return data.where((item) => item["child_name"].toString().toLowerCase().contains(Keyword.toLowerCase())).toList();
 }
 
  @override
  Widget build(BuildContext context) {


    return doc_image_path == null
        ? Center(child: CupertinoActivityIndicator(radius: 15.0))
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
                height: 20,
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
              SizedBox(
                height: 18,
              ),
              
       
              FutureBuilder(future: fetch_detials() , builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                    return CupertinoActivityIndicator(radius: 15,);
                    
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
                              ),
                              

                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext, index) {

                                    
                                var patient = filterd_list[index];
                                child_name = patient['child_name'];
                                conditions = patient['patient_id'];
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
                              }, childCount: filterd_list.length))
                            ],
                          ),
                     ),
                   );
              

                      
  }

              }
              else if (snapshot.hasError){
                      return Text("something went wrong");
                    }
 
                  else if (snapshot.data==null){
                      return Text("null");
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
              fontFamily: 'SF-Pro', fontSize: 15.sp, color: darkColor),
        ),
        subtitle: Text("Id : $conditions",
            style: TextStyle(
                fontFamily: 'SF-Pro', fontSize: 12.sp, color: darkColor)),
        trailing: Icon(
          CupertinoIcons.chevron_right_circle,
          color: primary_color,
          size: 20,
        ),
        leading: SizedBox(
            width: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage("http://$ip/screening$image_path"),
            )));
  }
}
