import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:screening_tool/components/bottomsheet.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/anextiy.dart';
import 'package:screening_tool/screens/views/Screening/behaviour/finalpage.dart';

int BehavoiourPageScore =0 ;
int AnexitiyPageScore = 0;
int DepressionPageScore = 0;


class BehavoiourPageResult{
  
  late var checkboxvalues_Behaviour;
   List valuesOfAnswer =[];

  void getValues(Map checkboxvalues){
    checkboxvalues_Behaviour = checkboxvalues;
  }
  
  void showresults(BuildContext context,String patient_id){
    for (final entry in checkboxvalues_Behaviour.entries){
     final checkboxList = entry.value;
    final index = checkboxList.indexOf(true);
    if (index != -1) {
      valuesOfAnswer.add(index); 
      
    } else {
    
    }

      
    }
          
    if (valuesOfAnswer.isNotEmpty) {
  BehavoiourPageScore =   valuesOfAnswer.reduce((a, b) => a+b);
  Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => anextiy
                            (
                                  patient_id: patient_id,
                                )));
}else{
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


class AnextiyPageResult{
  
  
  late Map checkboxvalues_axienty;
  List valuesOfAnswer =[];
  void getValues(Map checkboxvalues){
    checkboxvalues_axienty = checkboxvalues;
  }
  
  void showresults(BuildContext context,String patient_id){
    for (final entry in checkboxvalues_axienty.entries){
     final checkboxList = entry.value;
    final index = checkboxList.indexOf(true);
    if (index != -1) {
      valuesOfAnswer.add(index); 
      
    } else {
    
    }

      
    };


    if (valuesOfAnswer.isNotEmpty) {
  AnexitiyPageScore = valuesOfAnswer.reduce((a, b) => a+b);
 Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => finalpage(
              patient_id:patient_id,
            )));

}else{
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


class DepressionPageresult{
  late Map checkboxvalues_depression;
  List valuesOfAnswer =[];
  final int questionlenght = 0;

  void getValues(Map checkboxvalues, int questionlenght){
    checkboxvalues_depression = checkboxvalues;
    questionlenght = questionlenght;
  }
  void showresults(BuildContext context,var patient_id){
    for (final entry in checkboxvalues_depression.entries){
     final checkboxList = entry.value;
    final index = checkboxList.indexOf(true);
    if (index != -1) {
      valuesOfAnswer.add(index); 
      
    } else {
    
    }

      
    }

    if (valuesOfAnswer.isNotEmpty) {
    
  DepressionPageScore = valuesOfAnswer.reduce((a, b) => a+b);
  resultpopsheet(context,patient_id);
  

}else{
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



   void resultpopsheet(BuildContext context,var patient_id) {
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
        depression: DepressionPageScore, ConditionName: ConditonsName, patient_id: patient_id,
      ),
      context: context,
    );
  }

int total(){
  return BehavoiourPageScore+AnexitiyPageScore+DepressionPageScore;
}
List<dynamic> conditions(){
  List ConditonsName = [];
  ConditonsName.addIf(BehavoiourPageScore>=7, "Attendtion");
  ConditonsName.addIf(AnexitiyPageScore>=7, "Anexitiy");
  ConditonsName.addIf(DepressionPageScore>=5, "Depression");
  return ConditonsName;


}


/// growth developmental page score calculations
List results = [];

class grossmotor_results {

List storeResult_gross = [];

void showresults(Map values){
  
  if(values.isEmpty){
    print("No problem in gross motor results");

  }else{
   values.forEach((key, value) {
    var value_gross = (key/value)*100;
    if(value_gross < 50 ){
      storeResult_gross.add(value_gross);
      if(results.contains("GrossMotor")==false){
        results.add("GrossMotor");
      }

    }
    
    
  });}
  

  
 
}

}

class finemotor_result {
List storeResult_finemoto = [];

void showresults(Map values){
  if(values.isEmpty){
    print("No problem in gross motor results");

  }else{
   values.forEach((key, value) {
    var value_fine = (key/value)*100;
    if(value_fine < 50 ){
      storeResult_finemoto.add(value_fine);
       if(results.contains("FineMotor")==false){
        results.add("FineMotor");
      }
    }
    
  });}
  

  
 
}

}


class speech_result {

List storeResult_speech = [];
void showresults(Map values){
  if(values.isEmpty){
    print("No problem in gross motor results");

  }else{
   values.forEach((key, value) {
    var value_speech = (key/value)*100;
    if(value_speech < 50 ){
      storeResult_speech.add(value_speech);
       if(results.contains("Speech Development")==false){
        results.add("Speechn Development");
      }
    }
    
  });}
  

  
 
}

}

class social_result {

List storeResult_social = [];
void showresults(Map values){
  if(values.isEmpty){
    print("No problem in gross motor results");

  }else{
   values.forEach((key, value) {
   var value_social = (key/value)*100;
    if(value_social < 50 ){
      storeResult_social.add(value_social);
       if(results.contains("Social Development ")==false){
        results.add("Social Development ");
      }
    }
    
  });}
  

  
 
}

}



  List showresults(){
   return results;
   
  }

