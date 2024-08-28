import 'dart:convert';

import 'package:EarlyGrowthAndBehaviourCheck/screens/views/tabview/homepage.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/tabview/profile/regiter_profile.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/tabview/profile_page.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/tabview/screening_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../API/urlfile.dart';
import '../../utils/colors_app.dart';

class Home_page extends StatefulWidget {
  final String userid;
  
  const Home_page({super.key, required this.userid, });

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {


late CupertinoTabController _tabController;
@override
void initState(){
  super.initState();
  
  Doc_info();
  _tabController = CupertinoTabController();

}
var result,name,no_of_patients,list_of_patients,age;
bool _isloading = false;
  Future Doc_info() async {
    var data = {"id": userid};
    var url = homeUrl;

    final response = await http.post(Uri.parse(url), body: jsonEncode(data));
    var detials;
    if (response.statusCode == 200) {
      var message = jsonDecode(response.body);
      if (message['Status']) {
        detials = message['detials'];
        CupertinoActivityIndicator(radius: 20.0);
        
          setState(() {
            result = detials;
            name = result['doctor_name'];
            no_of_patients = result['no_of_patient'];
            list_of_patients = int.parse(no_of_patients);
            age =result['age'];
            
           _isloading = true;
          });
       
      } else {
        print("no user found");
      }
    } else {
      print("check the internet connection");
    }
  }


  Future<bool> _onWillPop() async {
    final currentNavigator = Navigator.of(context);
   print(currentNavigator.widget.onGenerateRoute);
    if (currentNavigator.canPop()) {
      currentNavigator.pop();
      return Future.value(false);
    }

    if (_tabController.index != 0) {
     
      _tabController.index =0; // Switch to the first tab on back press
      return Future.value(false);
    }

    return Future.value(true);
  }


  @override
  Widget build(BuildContext context) {

  List<Widget> data = [
    const Home_screen(),
     screening_tool(),
    const Profile_page()
  ];
 
    return _isloading?(age == null?  register_profile():
      WillPopScope(
        onWillPop: _onWillPop,
        child: CupertinoTabScaffold(
            controller: _tabController,
        
            tabBar: CupertinoTabBar(
              backgroundColor: widget_color,
              activeColor: primary_color,
              inactiveColor: apple_grey,
        
        
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "Home",
                    activeIcon: Icon(CupertinoIcons.house_fill)
        
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.doc),
                    label: "Screening",
                    activeIcon: Icon(CupertinoIcons.doc_fill)
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: "Profile",
                    activeIcon: Icon(CupertinoIcons.person_fill)
                )
              ],
            ),
            tabBuilder:
                (BuildContext context, int index) {
              return
                CupertinoTabView(
                  navigatorKey: GlobalObjectKey<NavigatorState>(context),
                  builder: (BuildContext context) {
                  return data[index];
                });
          }),
      )
          
          ):const CupertinoActivityIndicator(radius: 20.0);
   
  }
  
  
  
  }
