import 'dart:convert';
import 'dart:io';


import 'package:path_provider/path_provider.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/auth_screens/login_page.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/tabview/profile/Accountpage.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/tabview/profile/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../API/urlfile.dart';
import '../../../components/app_bar_all.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_widget.dart';
import '../../../utils/colors_app.dart';




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

                  // Fluttertoast.showToast(
                  //   msg: "invalid username or password",
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.BOTTOM,
                  //   timeInSecForIosWeb: 1,
                  //   textColor: Colors.white,
                  //   fontSize: 16.0);
                 Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => Login_page()),(route)=>false);
                 
             
              
             
              
                
              
              
              
            },
            child: const Text('Yes'),
          ),
        
      ]),
    );

    }

  void btn_fun() {
   alertdilog();
  }
  void editbtn(var Data){
    Navigator.of(context).push(MaterialPageRoute(builder:(context) => edit_profile(
      Doctorinfo: Data,
    )));
  } 


@override
void initState(){
  super.initState();
  doctor_info();
  //_getAppVersion();
  
}


void _showDownloadAlertDialog(BuildContext context,String Format) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Export File'),
        content: Text('Are Sure to Export the Reports into $Format'),
        actions: [


           CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            isDestructiveAction: true,
            child: Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); 
              
              Format=="CSV"?downloadCSV(context):downloadPdf(context);
              
            },
            child: Text('Export'),
          ),
        
         
        ],
      );
    },
  );
}



bool _isDownloading = false;

// Function to download the CSV file from the PHP backend
Future<void> downloadCSV(BuildContext context) async {
  try {
    setState(() {
      _isDownloading = true;
    });
Fluttertoast.showToast(
        msg: "Exporting..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    // Replace with your PHP backend URL that serves the CSV
    final String url = "$exporturl?id=$userid";

    // Make the HTTP request to get the CSV file
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Request storage permissions for Android
      // if (Platform.isAndroid) {
      //   var status = await Permission.storage.request();
      //   if (!status.isGranted) {
      //     Fluttertoast.showToast(
      //       msg: "Storage permission is required to save the file",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //     );
      //     return;
      //   }
      // }

      // Get the directory to store the file
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Unable to get the directory');
      }

      final path = '${directory.path}/Reports.csv';
      File file = File(path);

      // Write the content to the file
      await file.writeAsBytes(response.bodyBytes);
  print(path);
      // Notify the user that the download is complete
      Fluttertoast.showToast(
        msg: "File saved successfully at $path",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      // Handle error if the request fails
      Fluttertoast.showToast(
        msg: "Failed to download file, please try again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    // Handle exceptions
    Fluttertoast.showToast(
      msg: "An error occurred: ${e.toString()}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } finally {
    setState(() {
      _isDownloading = false;
    });
  }
}


Future<void>  downloadPdf(BuildContext context) async {
  try {
    setState(() {
      _isDownloading = true;
    });
   Fluttertoast.showToast(
        msg: "Exporting..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
      );
   
    // Replace with your PHP backend URL that serves the CSV
    final String url = "$exporturl?id=$userid";

    // Make the HTTP request to get the CSV file
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {

      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Unable to get the directory');
      }

      // Parse CSV data
      String csvData = response.body;
      final rows = csvData.split('\n').map((row) => row.split(',')).toList();

      // Create a PDF document
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          
          pageFormat: PdfPageFormat.a3,
          build: (pw.Context context) {
            return pw.Table.fromTextArray(
              data: rows,
              cellAlignment: pw.Alignment.centerLeft,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellStyle: pw.TextStyle(fontSize: 10),
              border: pw.TableBorder.all(),
            );
          },
        ),
      );

      // Save the PDF file
      final pdfPath = '${directory.path}/Reports.pdf';
      final pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(await pdf.save());

      // Notify the user
      Fluttertoast.showToast(
        msg: "PDF file saved successfully at $pdfPath",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print("PDF saved at: $pdfPath");
    } else {
      // Handle error if the request fails
      Fluttertoast.showToast(
        msg: "Failed to download file, please try again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    // Handle exceptions
    Fluttertoast.showToast(
      msg: "An error occurred: ${e.toString()}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } finally {
    setState(() {
      _isDownloading = false;
    });
  }
}







  // Show confirmation dialog before starting the download
  void _showDownloadDialog(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text("Export"),
              actions: [
                CupertinoActionSheetAction(
                    child: const Text('Export CSV'),
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      _showDownloadAlertDialog(context,"CSV");
                    }),
                CupertinoActionSheetAction(
                    child: const Text('Export PDF'),
                    isDefaultAction: true,
                    onPressed: () {
                     
                      Navigator.of(context, rootNavigator: true).pop();
                      _showDownloadAlertDialog(context,"PDF");
                    }),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text("cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
  );
}






var result,name,age,image_path,location,no_of_patient;


Future doctor_info() async {
    var data = {"id": userid};
    var url = doctorurl;
    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(data)).timeout(const Duration(seconds: 10));
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


_launchURLBrowser() async {
  var url = "http://$ip/screening/privacy.html";
  if (await canLaunchUrl(Uri.parse(url))) {
    await launch(url,
    forceSafariVC: false
    
    );
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLmail() async {
  var url = Uri(
    scheme: "mailto",
    path: "sudharsanan080@gmail.com",

  );
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}




 Future<void> _refreshon() async{
    await Future.delayed( Duration(milliseconds: 1000));
    doctor_info();
    setState(() {});
  }

void account_page(){
   Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Accountpage()));
}

void Appinfo(BuildContext context){
  _showDownloadDialog(context);
}
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return 
    
    Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: 
            
            SafeArea(child: appbar_default(title: "Profile", back: false,))),



        body: FutureBuilder(future: doctor_info() , 
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CupertinoActivityIndicator(radius: 15.0,));}

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
                           var Completed_patient =Doctorinfo['completed_patient'];
                           
                                      
                     
                     
                                      return Column(children: [
                               
                               
                               
                                 //name card starts!!!!!!!
                               
                                 Padding(
                                   padding: EdgeInsets.symmetric(vertical: 22, horizontal: 15),
                                   child: Container(
                                     width: size.width.w,
                                     height: 20.h,
                                     decoration: BoxDecoration(
                       color: lightColor, borderRadius: BorderRadius.circular(20),border: Border.all(color: darkColor,width: 0.5)),
                               
                                     // inside name card startss!!!!!
                               
                                     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                     // profile picture starts!!!
                     
                     CupertinoContextMenu(
        
                       actions: [ CupertinoContextMenuAction(child: Text(name))],
                       child: Padding(
                         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                         child: Container(
                           width: 25.w,
                           height: 12.h,
                           decoration: BoxDecoration(
                               image: DecorationImage(
                                   image: NetworkImage("http://$ip/screening$image_path"),fit: BoxFit.cover),
                               shape: BoxShape.circle),
                         ),
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
                           " $name",
                           style: TextStyle(fontFamily: 'SF-Pro', fontSize: 17.sp),
                         ),
                         Text(
                           "$age yrs",
                           style: TextStyle(fontFamily: 'SF-Pro', fontSize: 17.sp),
                         ),
                         Text(
                           location==null?"location":location,
                           style: TextStyle(fontFamily: 'SF-Pro', fontSize: 17.sp),
                         )
                       ],
                     ),
                                     ]),
                                   ),
                                 ),
    
                               
                               CupertinoListSection(
                               
                                backgroundColor: lightColor,
                                children: [
                                   CupertinoListTile.notched(
                                  title: Text("Account"),
                                  padding: EdgeInsets.all(15),
                                 // backgroundColor: widget_color,
                                 onTap: account_page ,
                                  leading: Icon(CupertinoIcons.person_crop_circle,color: primary_color,),
                                  trailing: Icon(CupertinoIcons.chevron_right,color: primary_color,size: 20,),
                                ),
                                 CupertinoListTile.notched(
                                  title: Text("Privacy Policy"),
                                  padding: EdgeInsets.all(15),
                                 onTap: (){
                                  _launchURLBrowser();
                                  
                                 },
                                  leading: Icon(CupertinoIcons.lock_shield,color: primary_color,),
                                  //trailing: Icon(CupertinoIcons.chevron_right,color: primary_color,size: 20,),
                                ),
                                CupertinoListTile.notched(
                                  title: Text("contact us"),
                                  padding: EdgeInsets.all(15),
                                 // backgroundColor: widget_color,
                                 onTap: (){
                                  _launchURLmail();
                                 },
                                  leading: Icon(CupertinoIcons.mail,color: primary_color,),
                                  //trailing: Icon(CupertinoIcons.chevron_right,color: primary_color,size: 20,),
                                ),
                                CupertinoListTile.notched(
                                  title: Text("Export Reports"),
                                  padding: EdgeInsets.all(15),
                                  onTap: (){
                                    Appinfo(context);
                                  },
                                 // backgroundColor: widget_color,
                                  leading: Icon(CupertinoIcons.cloud_download ,color: primary_color,),
                                  //trailing: Icon(CupertinoIcons.chevron_right,color: primary_color,size: 20,),
                                ),
                              
                                ],
                               ),



                                SizedBox(height: 10.5.h,), 










                                 // logut button for the page that displays
                               
                                 custom_buttom(
                                     text: "LOGOUT ",
                                     width: 75,
                                     height: 6.5,
                                     backgroundColor: bar_color,
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
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: RiveAnimation.asset("assets/animation/404_cat.riv"),
                               ),
                                
                            ]),
                          ),
                          GestureDetector(
                              onTap: (){
                                _refreshon();
                                 
                              },
                              child: Text("Try again",style: TextStyle(fontFamily: 'SF-Pro',fontSize: 13.sp,color: primary_color),))
                        ],
                      ));
  }
  
  }

  
 return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: RiveAnimation.asset("assets/animation/404_cat.riv"),
                               ),
                                
                            ]),
                          ),
                          GestureDetector(
                              onTap: (){
                                _refreshon();
                                 
                              },
                              child: Text("Try again",style: TextStyle(fontFamily: 'SF-Pro',fontSize: 13.sp,color: primary_color),))
                        ],
                      ));



})

        );
  }
}







