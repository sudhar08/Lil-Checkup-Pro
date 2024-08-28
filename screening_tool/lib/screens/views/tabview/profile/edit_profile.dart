import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/widgets.dart';


import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sizer/sizer.dart';

import '../../../../API/urlfile.dart';
import '../../../../components/app_bar_all.dart';
import '../../../../components/custom_button.dart';
import '../../../../utils/colors_app.dart';


class edit_profile extends StatefulWidget {
   Map? Doctorinfo;
   edit_profile({super.key, this.Doctorinfo});

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  var name = TextEditingController();
  var email = TextEditingController();
  var phone_no = TextEditingController();
  var age = TextEditingController();
  var location = TextEditingController();

  String image_path = "";
    String doc_name ="";
    String doc_age = "";
    String doc_phoneNO = "";
    String doc_email = "";
    String doc_location = "";

@override
 @override
  void initState() {
    super.initState();
   
    doctor_info();
  }


















void doctor_info() async {
    var data = {"id": userid};
    var url = doctorurl;
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        if (message['Status']) {
        
         setState(() {
           
       
        name.text = message['doctorinfo']['doctor_name'];
        age.text = message['doctorinfo']['age'];
        image_path = message['doctorinfo']['image_path'].toString().substring(2);
        phone_no.text = message['doctorinfo']['phone_no'];
        email.text = message['doctorinfo']['email_id'];
        location.text = message['doctorinfo']['location'];

  });
        
              

  
       
        }
      }
    } catch (e) {
      CupertinoActivityIndicator(
          radius: 30.0, color: CupertinoColors.activeBlue);
    }
  }





  File? imagefile;
  var base64encode;

  void getimage({required ImageSource source}) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 100);
    if (file != null) {
      final imageBytes = await file.readAsBytes();
      var base64encoder = base64Encode(imageBytes);
      setState(() {
        base64encode = base64encoder;
      });
    }

    if (file?.path != null) {
      setState(() {
        imagefile = File(file!.path);
      });
    }
  }

  void photo_picker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    child: const Text('Camera'),
                    isDefaultAction: true,
                    onPressed: () {
                      getimage(source: ImageSource.camera);
                    }),
                CupertinoActionSheetAction(
                    child: const Text('Gallery'),
                    isDefaultAction: true,
                    onPressed: () {
                      getimage(source: ImageSource.gallery);
                    }),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text("cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ));
  }
bool isLoading = false;
  void updateptofile()  async{
    setState(() {
              isLoading = true;
            });
   
    
    if (phone_no.text.isNotEmpty &&
        email.text.isNotEmpty &&
        name.text.isNotEmpty &&
        location.text.isNotEmpty &&
        age.text.isNotEmpty) {
        try{
          var profileData = {
          "id": userid,
          "name": name.text,
          "age": age.text,
          "phone_no": phone_no.text,
          "emailid": email.text,
          "location": location.text,
        };

        if (base64encode != null && base64encode.toString().isNotEmpty) {
          profileData["base64Image"] = base64encode;
          print(profileData);
        }
          var url = editprofileurl;
          final response =  await http.post(Uri.parse(url),body: jsonEncode(profileData));
          if (response.statusCode ==200){
            var message = jsonDecode(response.body);
            if (message['status']){
              setState(() {
              isLoading = false;
            });
            AnimatedSnackBar.material(
                      'Profile has been updated successfully',
                      type: AnimatedSnackBarType.success,
                      duration: Duration(seconds: 1),
                      animationCurve: Curves.fastOutSlowIn,
                      mobileSnackBarPosition: MobileSnackBarPosition.bottom
                  ).show(context);
Future.delayed(Duration(seconds: 1), () {
            
  clear();
  Navigator.pop(context); 

});
            }
            else{
              setState(() {
              isLoading = false;
            });
              AnimatedSnackBar.material(
    'Something went wrong with updating your profile',
    type: AnimatedSnackBarType.error,
    duration: Duration(seconds: 2),
    animationCurve: Curves.fastOutSlowIn,
    mobileSnackBarPosition: MobileSnackBarPosition.top
).show(context);



            }

          }


        }
        catch(e) {
          setState(() {
              isLoading = false;
            });
          print(e);
           AnimatedSnackBar.material(
    'Something went wrong',
    type: AnimatedSnackBarType.error,
    duration: Duration(seconds: 2),
    animationCurve: Curves.fastOutSlowIn,
    mobileSnackBarPosition: MobileSnackBarPosition.top
).show(context);


        }
        }
        else{
      
          AnimatedSnackBar.material(
    'FIll all the fields ',
    type: AnimatedSnackBarType.warning,
    duration: Duration(seconds: 2),
    animationCurve: Curves.fastOutSlowIn,
    mobileSnackBarPosition: MobileSnackBarPosition.top
).show(context);

    setState(() {
              isLoading = false;
            });
        }
        

  }

  

void clear(){
  phone_no.clear();
  email.clear();
  name.clear();
  age.clear();
  location.clear();
  base64encode = null;
}


void setter(doc_name,doc_age,doc_phone,doc_email,doc_location){
  name.text =doc_name;
  age.text =doc_age;
  phone_no.text =doc_phone;
  email.text =doc_email;
  location.text =doc_location;
}





  @override
  Widget build(BuildContext context) {

   // setter(doc_name, doc_age, doc_phoneNO, doc_email, doc_location);
    
    
    
    
    return BounceInUp(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: SafeArea(
                child: appbar_default(
              title: "Profile", back: true,
            ))),
        body: BounceInDown(
          delay: Duration(milliseconds: 500),
          child: SingleChildScrollView(
            child: Column(
                
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (imagefile == null)
                    Stack(
                      alignment: Alignment.center,
                      children: [Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                        child: GestureDetector(
                          onTap: () {
                            photo_picker();
                          },
                          child: Container(
                            width: 40.w,
                            height: 15 .h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:NetworkImage("http://$ip/screening/$image_path"),
                                    fit: BoxFit.fitWidth)),
                          ),
                        ),
                      ),


                      GestureDetector(
                        onTap: () {
                            photo_picker();
                          },
                        child: Icon(Icons.camera_alt_rounded,size: 28,color: lightColor,))
                ])
                  else
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 23.w, vertical: 3.h),
                      child: GestureDetector(
                        onTap: () {
                          photo_picker();
                        },
                        child: Container(
                          width: 55.w,
                          height: 13.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(imagefile!),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                    ),
                  Gap(1.h),
                  Padding(
                    padding: EdgeInsets.only(right: 80.w),
                    child: Text(
                      "NAME",
                      style: TextStyle(fontSize: 12.sp, fontFamily: 'SF-Pro'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 95.w,
                        height: 6.h,
                        child: CupertinoTextField(
                          
                          placeholder: 'Name',
                          controller: name,
                           onChanged: (value){
                            setState(() {
                              name.text =value;
                            });
                           },
                          onTapOutside: (event) {
                  
                    FocusManager.instance.primaryFocus?.unfocus();
                },
                         // textInputAction: TextInputAction.next,
                          decoration: BoxDecoration(
                              color: widget_color,
                             
                              borderRadius: BorderRadius.circular(12)),
                          cursorColor: primary_color,
                        )),
                  ),
                  Gap(1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: Text(
                              "Age",
                              style:
                                  TextStyle(fontSize: 12.sp, fontFamily: 'SF-Pro'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SizedBox(
                                width: 40.w,
                                height: 6.h,
                                child: CupertinoTextField(
                                  placeholder: 'Age',
                                  onChanged: (value){
                            setState(() {
                              age.text =value;
                            });
                           },
                                  onTapOutside: (event) {
                  
                    FocusManager.instance.primaryFocus?.unfocus();
                },
                                  textInputAction: TextInputAction.next,
                                  controller: age,
                                  decoration: BoxDecoration(
                                      color: widget_color,
                                      borderRadius: BorderRadius.circular(12)),
                                  cursorColor: primary_color,
                                  keyboardType: TextInputType.number,
                                )),
                          ),
                        ],
                      ),
                
                      //phonee noo code goes here.................
                
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Text(
                              "Phone No",
                              style:
                                  TextStyle(fontSize: 12.sp, fontFamily: 'SF-Pro'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SizedBox(
                                width: 40.w,
                                height: 6.h,
                                child: CupertinoTextField(
                                  textInputAction: TextInputAction.next,
                                  placeholder: 'Phone No',
                                  onChanged: (value){
                            setState(() {
                              phone_no.text =value;
                            });
                           },
                                  onTapOutside: (event) {
                  
                    FocusManager.instance.primaryFocus?.unfocus();
                },
                                  controller: phone_no,
                                  decoration: BoxDecoration(
                                      color: widget_color,
                                      borderRadius: BorderRadius.circular(12)),
                                  cursorColor: primary_color,
                                  keyboardType: TextInputType.number,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(1.h),
                  Padding(
                    padding: EdgeInsets.only(right: 75.w),
                    child: Text(
                      "Email Id",
                      style: TextStyle(fontSize: 12.sp, fontFamily: 'SF-Pro'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                        width: 95.w,
                        height: 6.h,
                        child: CupertinoTextField(
                          placeholder: 'Email Id',
                          textInputAction: TextInputAction.next,
                          controller: email,
                          onChanged: (value){
                            setState(() {
                              email.text =value;
                            });
                           },
                          onTapOutside: (event) {
                  
                    FocusManager.instance.primaryFocus?.unfocus();
                },
                          decoration: BoxDecoration(
                              color: widget_color,
                              borderRadius: BorderRadius.circular(12)),
                          cursorColor: primary_color,
                          keyboardType: TextInputType.emailAddress,
                        )),
                  ),
                  Gap(1.h),
                  Padding(
                    padding: EdgeInsets.only(right: 75.w),
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 12.sp, fontFamily: 'SF-Pro'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                        width: 95.w,
                        height: 6.h,
                        child: CupertinoTextField(
                          placeholder: 'Location',
                          onTapOutside: (event) {
                  
                    FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value){
                            setState(() {
                              location.text =value;
                            });
                           },
                          textInputAction: TextInputAction.done,
                          controller: location,
                          decoration: BoxDecoration(
                              color: widget_color,
                              borderRadius: BorderRadius.circular(12)),
                          cursorColor: primary_color,
                        )),
                  ),
                  Gap(1.5.h),
                  custom_buttom(
                      text: "SUBMIT",
                      width: 55,
                      height: 6,
                      backgroundColor: submit_button,
                      textSize: 15,
                      button_funcation: () {
                       
                
                       updateptofile();
                      },
                      textcolor: lightColor,
                      isLoading: isLoading,
                      fontfamily: 'SF-Pro-Bold')
                ]),
          ),
        ),
      ),
    );
  }
}
