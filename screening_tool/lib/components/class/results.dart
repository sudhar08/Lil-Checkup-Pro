import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:screening_tool/components/bottomsheet.dart';
import 'package:screening_tool/components/growthscreening.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/ADHD.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/anextiy.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/finalpage.dart';
import 'package:screening_tool/screens/views/Screening/growth/finemotor.dart';
import 'package:screening_tool/screens/views/Screening/growth/social.dart';
import 'package:screening_tool/screens/views/Screening/growth/speechs.dart';
import 'package:sizer/sizer.dart';

int BehavoiourPageScore = 0;
int AnexitiyPageScore = 0;
int AdhdpageScore = 0;
int DepressionPageScore = 0;

class BehavoiourPageResult {
  late var checkboxvalues_Behaviour;
  List valuesOfAnswer = [];

  void getValues(Map checkboxvalues) {
    checkboxvalues_Behaviour = checkboxvalues;
  }

  void showresults(BuildContext context, String patient_id) {
    for (final entry in checkboxvalues_Behaviour.entries) {
      final checkboxList = entry.value;
      final index = checkboxList.indexOf(true);
      if (index != -1) {
        valuesOfAnswer.add(index);
      } else {}
    }

    if (valuesOfAnswer.isNotEmpty &&
        valuesOfAnswer.length == checkboxvalues_Behaviour.length) {
      BehavoiourPageScore = valuesOfAnswer.reduce((a, b) => a + b);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => anextiy(
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

class AnextiyPageResult {
  late Map checkboxvalues_axienty;
  List valuesOfAnswer = [];
  void getValues(Map checkboxvalues) {
    checkboxvalues_axienty = checkboxvalues;
  }

  void showresults(BuildContext context, String patient_id) {
    for (final entry in checkboxvalues_axienty.entries) {
      final checkboxList = entry.value;
      final index = checkboxList.indexOf(true);
      if (index != -1) {
        valuesOfAnswer.add(index);
      } else {}
    }
    ;

    if (valuesOfAnswer.isNotEmpty &&
        valuesOfAnswer.length == checkboxvalues_axienty.length) {
      AnexitiyPageScore = valuesOfAnswer.reduce((a, b) => a + b);
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

class AdhdPageResult {
  late Map checkboxvalues_adhd;
  List valuesOfAnswer = [];
  void getValues(Map checkboxvalues) {
    checkboxvalues_adhd = checkboxvalues;
  }

  void showresults(BuildContext context, String patient_id) {
    for (final entry in checkboxvalues_adhd.entries) {
      final checkboxList = entry.value;
      final index = checkboxList.indexOf(true);
      if (index != -1) {
        valuesOfAnswer.add(index);
      } else {}
    }
    ;

    if (valuesOfAnswer.isNotEmpty &&
        valuesOfAnswer.length == checkboxvalues_adhd.length) {
      AdhdpageScore = valuesOfAnswer.reduce((a, b) => a + b);
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
  late Map checkboxvalues_depression;
  List valuesOfAnswer = [];
  final int questionlenght = 0;

  void getValues(Map checkboxvalues, int questionlenght) {
    checkboxvalues_depression = checkboxvalues;
    questionlenght = questionlenght;
  }

  void showresults(BuildContext context, var patient_id) {
    for (final entry in checkboxvalues_depression.entries) {
      final checkboxList = entry.value;
      final index = checkboxList.indexOf(true);
      if (index != -1) {
        valuesOfAnswer.add(index);
      } else {}
    }

    if (valuesOfAnswer.isNotEmpty &&
        valuesOfAnswer.length == checkboxvalues_depression.length) {
      DepressionPageScore = valuesOfAnswer.reduce((a, b) => a + b);
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
      AnexitiyPageScore +
      DepressionPageScore +
      AdhdpageScore;
}

List<dynamic> conditions() {
  List ConditonsName = [];
  ConditonsName.addIf(BehavoiourPageScore >= 7, "Attendtion");
  ConditonsName.addIf(AnexitiyPageScore >= 7, "Anexitiy");
  ConditonsName.addIf(DepressionPageScore >= 5, "Depression");
  ConditonsName.addIf(AdhdpageScore >= 9, "ADHD");
  return ConditonsName;
}

/// growth developmental page score calculations
List results = [];

class grossmotor_results {
  List storeResult_gross = [];

  void showresults(Map values, BuildContext context, var Age, var patient_id) {
    if (values.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var score = values.entries.first.key / values.entries.first.value * 100;

      if (score < 50) {
        results.add("Gross Motor");
        print(results);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FineMotor(Age: Age, patient_id: patient_id,)));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FineMotor(Age: Age, patient_id: patient_id,)));
      }
      print(results);
    }
  }
}

class finemotor_result {
  List storeResult_finemoto = [];

  void showresults(Map values, BuildContext context, var Age,var patient_id) {
    if (values.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var score = values.entries.first.key / values.entries.first.value * 100;
        print(score);
      if (score < 50) {
        results.add("Fine Motor");
        print(results);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => speechs(Age: Age, patient_id: patient_id,)));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => speechs(Age: Age, patient_id: patient_id,)));
      }
      print(results);
    }
  }
}

class speech_result {
  List storeResult_speech = [];
  void showresults(Map values, BuildContext context, var Age,var patient_id) {
    if (values.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var score = values.entries.first.key / values.entries.first.value * 100;
        print(score);
      if (score < 50) {
        results.add("Speech");
        print(results);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => social_q(Age: Age, patient_id: patient_id,)));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => social_q(Age: Age, patient_id: patient_id,)));
      }
      print(results);
    }
  }
}

class social_result {
  List storeResult_social = [];
 void showresults(Map values, BuildContext context, var Age, var patient_id) {
    if (values.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Answer All the Question",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var score = values.entries.first.key / values.entries.first.value * 100;
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

