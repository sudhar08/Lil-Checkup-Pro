import 'dart:convert';
import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';


import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screening_tool/API/urlfile.dart';
import 'package:screening_tool/components/app_bar_all.dart';
import 'package:screening_tool/components/custom_button.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:sizer/sizer.dart';

class edit_profile extends StatefulWidget {
  const edit_profile({super.key});

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  var name = TextEditingController();
  var email = TextEditingController();
  var phone_no = TextEditingController();
  var age = TextEditingController();
  var location = TextEditingController();

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

  void updateptofile()  async{

    
    if (phone_no.text.isNotEmpty &&
        email.text.isNotEmpty &&
        name.text.isNotEmpty &&
        location.text.isNotEmpty &&
        age.text.isNotEmpty && base64encode.toString().isNotEmpty) {
        try{
          var profileData = {
            "id": userid,
            "name":name.text,
             "age": age.text,
             "phone_no":phone_no.text,
             "emailid":email.text,
             "location":location.text,
             "base64Image":base64encode,
          };
          var url = editprofileurl;
          final response =  await http.post(Uri.parse(url),body: jsonEncode(profileData));
          if (response.statusCode ==200){
            var message = jsonDecode(response.body);
            if (message['status']){
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
              AnimatedSnackBar.material(
    'Something went wrong with updating your profile',
    type: AnimatedSnackBarType.error,
    duration: Duration(seconds: 2),
    animationCurve: Curves.fastOutSlowIn,
    mobileSnackBarPosition: MobileSnackBarPosition.top
).show(context);

clear();

            }

          }


        }
        catch(e) {
           AnimatedSnackBar.material(
    'Something went wrong',
    type: AnimatedSnackBarType.error,
    duration: Duration(seconds: 2),
    animationCurve: Curves.fastOutSlowIn,
    mobileSnackBarPosition: MobileSnackBarPosition.top
).show(context);
clear();

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

void snackbar(){
  AnimatedSnackBar.material(
    'This a snackbar with info type',
    type: AnimatedSnackBarType.error,
    duration: Duration(seconds: 2),
    animationCurve: Curves.fastOutSlowIn,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom
).show(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: SafeArea(
              child: appbar_default(
            title: "Edit Profile",
          ))),
      body: SingleChildScrollView(
        child: Column(

            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (imagefile == null)
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
                              image: AssetImage("assets/images/default_2.jpg"),
                              fit: BoxFit.contain)),
                    ),
                  ),
                )
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
                              placeholder: 'Phone No',
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
                      controller: email,
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
                  fontfamily: 'SF-Pro-Bold')
            ]),
      ),
    );
  }
}
