import 'dart:async';

import 'package:flutter/material.dart';




class checkboxvaluesbehavior extends ChangeNotifier{
  final Map<int,int> _BehaviourRadiovalues = {};
  Map<int,int> get BehaviourRadiovalues => _BehaviourRadiovalues;
  
  addNewvalue(int index){
    _BehaviourRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _BehaviourRadiovalues[index] = value;
    notifyListeners();
    
  }



}





class checkboxvaluesAxienty  extends ChangeNotifier{
  final Map<int,int> _AxientyRadiovalues = {};
  Map<int,int> get AxientyRadiovalues => _AxientyRadiovalues;
  addNewvalue(int index){
    _AxientyRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _AxientyRadiovalues[index] = value;
    notifyListeners();
    
  }


}



class checkboxvalues_final extends ChangeNotifier{
  final Map<int,int> _finalRadiovalues = {};
  Map<int,int> get finalRadiovalues => _finalRadiovalues;
  addNewvalue(int index){
    _finalRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _finalRadiovalues[index] = value;
    notifyListeners();
    
  }

}





class checkboxvalues_adhd extends ChangeNotifier{
  final Map<int,int> _ADHDRadiovalues = {};
  Map<int,int> get ADHDRadiovalues => _ADHDRadiovalues;
  addNewvalue(int index){
    _ADHDRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _ADHDRadiovalues[index] = value;
    notifyListeners();
    
  }

  
}








class checkboxvalues_growth{
  Map<int,List> checkedbox_growth = {};
  Map<dynamic,dynamic> goss ={};
  
  void value(int index) {
    checkedbox_growth.addAll({index:[false,false]});
    
  }

}

class checkboxvalues_fine{
  Map<int,List> checkedbox_fine = {};
  Map fine ={};
  
  void value(int index) {
    checkedbox_fine.addAll({index:[false,false]});
    
  }

}

class checkboxvalues_speechs{
  Map<int,List> checkedbox_speechs = {};
  Map speech = {};

  
  void value(int index) {
    checkedbox_speechs.addAll({index:[false,false]});
    
  }

}

class checkboxvalues_social{
  Map<int,List> checkedbox_social = {};
  Map social = {};
  
  
  void value(int index) {
    checkedbox_social.addAll({index:[false,false]});
    
  }

}