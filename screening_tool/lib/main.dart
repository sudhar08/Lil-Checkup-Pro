import 'dart:io';

import 'package:EarlyGrowthAndBehaviourCheck/components/class/checkboxstore.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/auth_screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp( const MyApp());
}






class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create:  (context) => checkboxvaluesbehavior(),),
        ChangeNotifierProvider(create: (context)=> checkboxvaluesAxienty()),
        ChangeNotifierProvider(create: (context)=> checkboxvalues_adhd()),
        ChangeNotifierProvider(create: (context)=> checkboxvalues_final()),
        ChangeNotifierProvider(create: (context)=> checkboxvalues_growth()),
        ChangeNotifierProvider(create: (context)=> checkboxvalues_fine()),
        ChangeNotifierProvider(create: (context)=> checkboxvalues_speechs()),
        ChangeNotifierProvider(create: (context)=> checkboxvalues_social()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return CupertinoApp(
              theme: CupertinoThemeData(brightness: Brightness.light),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                resizeToAvoidBottomInset: false,
          
                // ignore: prefer_const_constructors
                body: Login_page(),
              ));}),
    );

      
    }
  }
