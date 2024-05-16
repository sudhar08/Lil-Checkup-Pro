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








class checkboxvalues_growth extends ChangeNotifier{
   final Map<int,int> _GrowthRadiovalues = {};
   final List<int> _GrowthageValues = [];
   Map<int,int> get GROWTHRadiovalues => _GrowthRadiovalues;
  List<int> get  GrowthageValues => _GrowthageValues;
  addNewvalue(int index){
    _GrowthRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _GrowthRadiovalues[index] = value;
    notifyListeners();
    
  }
  void addage(int age){
    _GrowthageValues.add(age);
    notifyListeners();
  }
  void removeage(int age){
    _GrowthageValues.remove(age);
    notifyListeners();
  }


}

class checkboxvalues_fine extends ChangeNotifier{
 final Map<int,int> _FineRadiovalues = {};
  final List<int> _FineageValues = [];
   Map<int,int> get FineRadiovalues => _FineRadiovalues;
  List<int> get  FineageValues => _FineageValues;
  addNewvalue(int index){
    _FineRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _FineRadiovalues[index] = value;
    notifyListeners();
    
  }
  void addage(int age){
    _FineageValues.add(age);
    notifyListeners();
  }
  void removeage(int age){
    _FineageValues.remove(age);
    notifyListeners();
  }
}

class checkboxvalues_speechs extends ChangeNotifier{
  final Map<int,int> _speechRadiovalues = {};
  final List<int> _speechageValues = [];
   Map<int,int> get speechRadiovalues => _speechRadiovalues;
  List<int> get  speechageValues => _speechageValues;
  addNewvalue(int index){
    _speechRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _speechRadiovalues[index] = value;
    notifyListeners();
    
  }
  void addage(int age){
    _speechageValues.add(age);
    notifyListeners();
  }
  void removeage(int age){
    _speechageValues.remove(age);
    notifyListeners();
  }

}

class checkboxvalues_social extends ChangeNotifier{
  final Map<int,int> _socialRadiovalues = {};
  final List<int> _socialageValues = [];
   Map<int,int> get socialRadiovalues => _socialRadiovalues;
  List<int> get  socialageValues => _socialageValues;
  addNewvalue(int index){
    _socialRadiovalues.addAll({index:-1});
    notifyListeners();
  }
  void update(int index ,int value){
    _socialRadiovalues[index] = value;
    notifyListeners();
    
  }
  void addage(int age){
    _socialageValues.add(age);
    notifyListeners();
  }
  void removeage(int age){
    _socialageValues.remove(age);
    notifyListeners();
  }

 

}