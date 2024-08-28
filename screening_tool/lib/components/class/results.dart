import 'package:EarlyGrowthAndBehaviourCheck/components/bottomsheet.dart';
import 'package:EarlyGrowthAndBehaviourCheck/components/growthscreening.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/Screening/behaviour/ADHD.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/Screening/behaviour/finalpage.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/Screening/growth/finemotor.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/Screening/growth/social.dart';
import 'package:EarlyGrowthAndBehaviourCheck/screens/views/Screening/growth/speechs.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

int BehavoiourPageScore = 0;
int AnexitiyPageScore = 0;
int AdhdpageScore = 0;
int DepressionPageScore = 0;

class BehavoiourPageResult {
  

  void showresults(BuildContext context, var patient_id,Map RadioValues) {
    final RadioValuescollector = [];
    
     for(final entry  in RadioValues.entries){
      print(entry);
      if(entry.value>=0){
        RadioValuescollector.add(entry.value);
      }
     }
   


    if (RadioValuescollector.isNotEmpty &&
        RadioValuescollector.length == RadioValues.length) {
      BehavoiourPageScore = RadioValuescollector.reduce((a, b) => a + b);
      print(BehavoiourPageScore);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ADHDpage(
                patient_id: patient_id,
              )));
    } else {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

// class AnextiyPageResult {
  

//   void showresults(BuildContext context, var patient_id,Map Radiovalues){
//     final RadioValuescollector = [];
//     for (final entry in Radiovalues.entries) {
//       if (entry.value>=0){
//         RadioValuescollector.add(entry.value);
//       }
//     }
    

//     if (RadioValuescollector.isNotEmpty &&
//         RadioValuescollector.length == RadioValuescollector.length) {
//       AnexitiyPageScore = RadioValuescollector.reduce((a, b) => a + b);
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => ADHDpage(
//                 patient_id: patient_id,
//               )));
//     } else {
//       Fluttertoast.showToast(
//           msg: "Please Answer All the Question",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM_RIGHT,
//           timeInSecForIosWeb: 1,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//   }
// }

class AdhdPageResult {
  

  void showresults(BuildContext context, var patient_id,Map RadioValues ) {
    final RadioValuescollector = [];
    for (final entry in RadioValues.entries) {
      if (entry.value>=0){
        RadioValuescollector.add(entry.value);
      }
     
    }
    

    if (RadioValuescollector.isNotEmpty &&
        RadioValuescollector.length == RadioValuescollector.length) {
      AdhdpageScore = RadioValuescollector.reduce((a, b) => a + b);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => finalpage(
                patient_id: patient_id,
              )));
    } else {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}





class DepressionPageresult {
 

  void showresults(BuildContext context, var patient_id,Map RadioValues) {
     final RadioValuescollector = [];
    for (final entry in RadioValues.entries) {
      if (entry.value>=0){
        RadioValuescollector.add(entry.value);
      }
     
    }
    if (RadioValuescollector.isNotEmpty &&
        RadioValuescollector.length == RadioValuescollector.length) {
      DepressionPageScore = RadioValuescollector.reduce((a, b) => a + b);
      resultpopsheet(context, patient_id);
    } else {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_RIGHT,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

void resultpopsheet(BuildContext context, var patient_id) {
  List ConditonsName = conditions();
  int TotalScore = total();
  showCupertinoModalBottomSheet(
    isDismissible: true,
    enableDrag: true,
    expand: true,
    backgroundColor: Colors.transparent,
    //duration: Duration(milliseconds: 500),
    builder: (context) => ModalWithNavigator(
      Score: TotalScore,
      behaviour: BehavoiourPageScore,
      anextiy: AnexitiyPageScore,
      depression: DepressionPageScore,
      ConditionName: ConditonsName,
      patient_id: patient_id,
      adhd: AdhdpageScore,
    ),
    context: context,
  );
}

int total() {
  return BehavoiourPageScore +
      DepressionPageScore +
      AdhdpageScore;
}

List<dynamic> conditions() {
  List conditionNames = [];
  
  if (BehavoiourPageScore >= 7) {
    conditionNames.add("ASD");
  }
  // if (AnexitiyPageScore >= 7) {
  //   conditionNames.add("Anxiety");
  // }
  if (DepressionPageScore >= 7) {
    conditionNames.add("Mood disorders");
  }
  if (AdhdpageScore >= 7) {
    conditionNames.add("ADHD");
  }
  
  return conditionNames.isNotEmpty ? conditionNames : ["Normal"];
}


/// growth developmental page score calculations




List results = [];

class grossmotor_results {
  

  void showresults(List values, var patient_age, BuildContext context, var patient_id){
    print(values);
    if(values.isEmpty){
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

    }

    else{
      var age = int.parse(patient_age);
      var score =  values.first / age *100;
      print(score);
      if (score < 50) {
        results.add("Gross Motor");
        print(results);
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FineMotor(Age: patient_age, patient_id: patient_id ,)));
      } else {
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FineMotor(Age: patient_age, patient_id: patient_id,)));
      }

    }
  }
}

class finemotor_result {
  void showresults(List values, var patient_age, BuildContext context, var patient_id){
    if(values.isEmpty){
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

    }

    else{
      var age = int.parse(patient_age);
      var score =  values.first / age *100;
      print(score);
      if (score < 50) {
        results.add("Fine Motor");
        print(results);
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => speechs(Age: patient_age, patient_id: patient_id ,)));
      } else {
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => speechs(Age: patient_age, patient_id: patient_id,)));
      }

    }
  }
}

class speech_result {
   void showresults(List values, var patient_age, BuildContext context, var patient_id){
    if(values.isEmpty){
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);

    }

    else{
      var age = int.parse(patient_age);
      var score =  values.first / age *100;
      print(score);
      if (score < 50) {
        results.add("speech");
        print(results);
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => social_q(Age: patient_age, patient_id: patient_id ,)));
      } else {
         Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => social_q(Age: patient_age, patient_id: patient_id,)));
      }

    }
  }
  
}

class social_result {
  List storeResult_social = [];
 void showresults(List values, BuildContext context,  var patient_id, var patient_age){
    if (values.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var age = int.parse(patient_age);
      var score =  values.first / age *100;
        print(score);
      if (score < 50) {
        results.add("Social");
        print(results);
        resultpopsheetGrowth(context, patient_id);
      } else {
        resultpopsheetGrowth(context,patient_id);
      }
      print(results);
    }
  }
}



void resultpopsheetGrowth(BuildContext context,var patient_id){

    showCupertinoModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      expand: false,
      backgroundColor: Colors.transparent,
      //duration: Duration(milliseconds: 500),
      builder: (context) => Container(
        width: 100.w,
        height: 60.h,
        
        child: Growthbottomsheet(Conditions:results, patient_id: patient_id,)), context: context,
    );
    
  }

