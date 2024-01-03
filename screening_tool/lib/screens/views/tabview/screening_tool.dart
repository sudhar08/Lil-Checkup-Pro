// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar.dart';
import 'package:screening_tool/screens/views/screening_%20page.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class screening_tool extends StatefulWidget {
 
  
  screening_tool({super.key, });

  @override
  State<screening_tool> createState() => _screening_toolState();
}

class _screening_toolState extends State<screening_tool> {

   var result,name,no_of_patients,list_of_patients;
   String? doc_image_path;
  
bool _isloading = false;
  @override
  void initState() {
    super.initState();
    Doc_info();
    fetch_detials();
  }

  var child_name, conditions, lenght;
  List patient_info = [];
  bool _loading = false;




  void fetch_detials() async {
    var data = {"id": userid};
    var url = patientviewurl;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message['Status']){
        var detials  = message['pateintinfo'];
        setState(() {
          patient_info = detials;
          lenght = patient_info.length;
          
          _isloading = true;
        });

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


  @override
  Widget build(BuildContext context) {
    print(doc_image_path);
    print(patient_info);

    return doc_image_path== null? 
    Center(child: CupertinoActivityIndicator(radius: 20.0))
    :
    
    
    Scaffold(
      appBar: PreferredSize(
        child:
        
         app_bar(
          title: 'Screening',
          doc_name: name, Image_path: doc_image_path! , 
        ),
        preferredSize: Size.fromHeight(24.2.h),
      ),
      body: CupertinoPageScaffold(
              child:
              
               Column(children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: 96.w,
                  child: CupertinoSearchTextField(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: lenght,
                    itemBuilder: (BuildContext context, int index) {
                      var patient = patient_info[index];
                      child_name = patient['child_name'];
                      conditions = patient['conditions']; 
                      var image_path = patient['image_path'];
                      var patient_id = patient['patient_id'];
                      image_path = image_path.toString().substring(2);
                      return GestureDetector(
                        onTap: (){
                           Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>  screeening_page(patient_id: patient_id,)));
                        },
                          child: List_patient(
                        name: child_name,
                        conditions: conditions, image_path: image_path,
                      ));
                    }),
              ),
            ])),
    );
  }
}

class List_patient extends StatelessWidget {
  final name, conditions ,image_path;
  const List_patient({super.key, required this.name, required this.conditions,required this.image_path});
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
