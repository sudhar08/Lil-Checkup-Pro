import 'dart:convert';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/bottomsheet.dart';
import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart'as http;

class screeening_page extends StatefulWidget {
  final patient_id;
  const screeening_page({super.key,  required this.patient_id});

  @override
  State<screeening_page> createState() => _screeening_pageState();
}

class _screeening_pageState extends State<screeening_page> {

@override
void initState(){
  super.initState();
  fetch_child_detials();
  fetch_Q_A();
}


List length = [];
void fetch_Q_A()async{
  var url = questionurl;
  
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200){
    var message = jsonDecode(response.body);
    List<dynamic> index = message[0];

    setState(() {
      length = index;
    });
   

    
  }


}

var name,image_path;
bool screeening_page_loading = false;
String? Age;
void fetch_child_detials() async{
  var data = {"patient_id": widget.patient_id};
    var url = child_info;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message['Status']){
        var detials  = message['pateintinfo'];
         DateTime age =  DateTime.parse(detials['age']) ;
        setState(() {
          name = detials['child_name'];
          image_path = detials['image_path'].toString().substring(2);
          var cal = AgeCalculator.age(age);
          if (cal.years<=0){
            Age  = cal.months.toString()+"months";
          }else{
            Age = cal.years.toString()+"yrs";
          }
         
          screeening_page_loading = true;
          
        });
       
        

      }
    }
}

void resultpopsheet(){
  showCupertinoModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        expand: true,
        backgroundColor: Colors.transparent,
        //duration: Duration(milliseconds: 500),
        builder: (context) => ModalWithNavigator(), context: context,
        
          
        
  );
}


void submit_btn(){
resultpopsheet();

}





  @override
  Widget build(BuildContext context) {
   print(length.length);
    return screeening_page_loading ==false?Center(child: CupertinoActivityIndicator(radius: 20.0,),):
    
    Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: SafeArea(child: appbar_default(title: "Screening")),
      ),
      body: Column(
        children: [
          Container(
            width: 100.w,
            height: 15.h,
            //color: apple_grey,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoContextMenu(

                previewBuilder:
          (BuildContext context, Animation<double> animation, Widget child) {
        return SizedBox(
          height: 30.h,
          width: 60.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "http://$ip/screening/$image_path",
              fit: BoxFit.cover,
            ),
          ),
        );
      },





                  actions: [Center(child: CupertinoContextMenuAction(child: Text(name)))],
                  child: Container(
                    width: 35.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage("http://$ip/screening$image_path"),fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, right: 5),
                  child: Column(
                    children: [
                      Text(
                        "Name",
                        style:
                            TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 20),
                      ),
                      Text(
                        "Age",
                        style:
                            TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, right: 10),
                  child: Column(
                    children: [
                      Text(
                        ":",
                        style:
                            TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 20),
                      ),
                      Text(
                        ":",
                        style:
                            TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, right: 10),
                  child: Column(
                    children: [
                      Text(
                        name,
                        style:
                            TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 20),
                      ),
                      Text(
                        Age!,
                        style:
                            TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Flexible(
            child: CupertinoScrollbar(
              child: ListView.builder(
                  
                  itemCount: length.length+1,
                  itemBuilder: (BuildContext context, int index) {
                    
                   
                    if (index==length.length) {
                      

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 22),
                        child: custom_buttom(
                            text: "submit",
                            width: 60,
                            height: 6,
                            backgroundColor: submit_button,
                            textSize: 15,
                            button_funcation: (){
                              submit_btn();
                            },
                            textcolor: lightColor,
                            fontfamily: 'SF-Pro-Bold',),
                      );
                    } else {
                      var indexing = length[index];
                    var s_no = indexing['S.no'];
                    var Questions = indexing['Questions'];
                    
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
                        child: Question_widget(s_no: s_no, questions: Questions,),
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class Question_widget extends StatefulWidget {
  final String s_no;
  final String questions;
  const Question_widget({
    super.key, required this.s_no, required this.questions,
  });

  @override
  State<Question_widget> createState() => _Question_widgetState();
}

bool _checkbox_never = false;
bool _checkbox_sometimes = false;
bool _checkbox_always = false;

class _Question_widgetState extends State<Question_widget> {





  @override
  Widget build(BuildContext context) {
   //print(question);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: 85.w,
        height: 28.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: widget_color.withOpacity(0.9)),
        child:
            Column( children: [
              Padding(
            padding: EdgeInsets.all(10.0),
         child: Text(
            "Q${widget.s_no} : ${widget.questions}",
            style: TextStyle(fontSize: 13.sp, fontFamily: 'SF-Pro-Bold'),
          ), ),
          Divider(
            height: 2.h,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: SizedBox(
              width: 50.w,
              height: 5.h,
              child: CheckboxListTile(
                value: _checkbox_never,
                onChanged: (value) {
                  setState(() {
                    _checkbox_never = value!;
                    _checkbox_sometimes = false;
                    _checkbox_always = false;
                    
                  });
                },
                title: Text(
                  "Never",
                  style: TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: never,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: SizedBox(
              width: 50.w,
              height: 5.h,
              child: CheckboxListTile(
                value: _checkbox_sometimes,
                onChanged: (value) {
                  setState(() {
                    _checkbox_sometimes = value!;
                    _checkbox_never = false;
                    _checkbox_always = false;
                    
                  });
                },
                title: Text(
                  "Sometimes",
                  style: TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: sometimes,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: SizedBox(
              width: 50.w,
              height: 5.h,
              child: CheckboxListTile(
                value: _checkbox_always,
                onChanged: (value) {
                  setState(() {
                    _checkbox_always = value!;
                    _checkbox_sometimes = false;
                    _checkbox_never = false;
                    
                  });
                },
                title: Text(
                  "Always",
                  style: TextStyle(fontFamily: 'SF-Pro-Bold', fontSize: 13.sp),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: red_aceent,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
