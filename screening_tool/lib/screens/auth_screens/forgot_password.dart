import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screening_tool/utils/colors_app.dart';

class Forgot_password extends StatefulWidget {
  const Forgot_password({super.key});

  @override
  State<Forgot_password> createState() => _Forgot_passwordState();
}

class _Forgot_passwordState extends State<Forgot_password> {
  @override
  Widget build(BuildContext context) {
    var Screen_size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            // image of the page 
            Container(
                width: Screen_size.width,
                height: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/forgot.jpg"),
                      fit: BoxFit.cover),
                )),
        
        
                //title of the page
        
            
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Center(
                child: Text(
                  "FORGOT PASSWORD",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        
            // text box 
        
            Padding(
              padding: const EdgeInsets.only(top:50),
              child: SizedBox(
                width: 360,
                height: 40,
                child: CupertinoTextField(
                  placeholder: "Email",
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color:lightColor),
                ),
              ),
            ),
            SizedBox(height: 50,),
            CupertinoButton(child: Text("SUBMIT"), onPressed: (){},
            color: submit_button,
            ),

            
        
        
        
          ]),
        ),
      ),
    );
  }
}
