import 'package:animated_snack_bar/animated_snack_bar.dart';

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





class GrossMotopage{
  late Map checkboxvalues_grossmotor;
  List valuesOfAnswer =[];


  void getValues(Map checkboxvalues){
    checkboxvalues_grossmotor = checkboxvalues;
  }


  void showresults(){
    for (final entry in checkboxvalues_grossmotor.entries){
     final checkboxList = entry.value;
    final index = checkboxList.indexOf(true);
    if (index != -1) {
      valuesOfAnswer.add(index); 
      
    } else {
    
    }

      
    }

    

  }

}