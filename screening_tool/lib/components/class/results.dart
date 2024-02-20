import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:get/get.dart';

int BehavoiourPageScore =0 ;
int AnexitiyPageScore = 0;
int DepressionPageScore = 0;
class BehavoiourPageResult{
  
  late var checkboxvalues_Behaviour;
   List valuesOfAnswer =[];

  void getValues(Map checkboxvalues){
    checkboxvalues_Behaviour = checkboxvalues;
  }

  void showresults(){
    for (final entry in checkboxvalues_Behaviour.entries){
     final checkboxList = entry.value;
    final index = checkboxList.indexOf(true);
    if (index != -1) {
      valuesOfAnswer.add(index); 
      
    } else {
    
    }

      
    }
          
    BehavoiourPageScore =   valuesOfAnswer.reduce((a, b) => a+b);
    print(BehavoiourPageScore);
   

  }


}


class AnextiyPageResult{
  
  
  late Map checkboxvalues_axienty;
  List valuesOfAnswer =[];
  void getValues(Map checkboxvalues){
    checkboxvalues_axienty = checkboxvalues;
  }
  
  void showresults(){
    for (final entry in checkboxvalues_axienty.entries){
     final checkboxList = entry.value;
    final index = checkboxList.indexOf(true);
    if (index != -1) {
      valuesOfAnswer.add(index); 
      
    } else {
    
    }

      
    }
    AnexitiyPageScore = valuesOfAnswer.reduce((a, b) => a+b);
    print(BehavoiourPageScore);
    print(AnexitiyPageScore);
    print(BehavoiourPageScore+AnexitiyPageScore);
    

  }


}


class DepressionPageresult{
  late Map checkboxvalues_depression;
  List valuesOfAnswer =[];
  void getValues(Map checkboxvalues){
    checkboxvalues_depression = checkboxvalues;
  }
  void showresults(){
    for (final entry in checkboxvalues_depression.entries){
     final checkboxList = entry.value;
    final index = checkboxList.indexOf(true);
    if (index != -1) {
      valuesOfAnswer.add(index); 
      
    } else {
    
    }

      
    }

    DepressionPageScore = valuesOfAnswer.reduce((a, b) => a+b);
     print(BehavoiourPageScore);
    print(AnexitiyPageScore);
    print(DepressionPageScore);
    print(BehavoiourPageScore+AnexitiyPageScore+DepressionPageScore);
    


  }



}


int total(){
  return BehavoiourPageScore+AnexitiyPageScore+DepressionPageScore;
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

