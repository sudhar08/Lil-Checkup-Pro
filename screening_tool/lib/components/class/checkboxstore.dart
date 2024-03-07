import 'dart:async';

class checkboxvalues_behavior {

  
    Map<int,List<bool>> checkedbox_behaviour = {};



 
  void value(int index) {
    checkedbox_behaviour.addAll({index:[false,false,false]});

    _controller.add(checkedbox_behaviour);
  }
   // Stream controller to notify listeners about changes
  final StreamController<Map<int, List<bool>>> _controller =
      StreamController<Map<int, List<bool>>>.broadcast();

  // Stream getter
  Stream<Map<int, List<bool>>> get checkBoxStream => _controller.stream;
}
  



class checkboxvalues_axienty{
  Map<int,List> checkedbox_axienty = {};
  void value(int index) {
    checkedbox_axienty.addAll({index:[false,false,false]});
    
  }

}



class checkboxvalues_final{
  Map<int,List> checkedbox_final = {};
  void value(int index) {
    checkedbox_final.addAll({index:[false,false,false]});
    
  }

}





class checkboxvalues_adhd{
  Map<int,List> checkedbox_adhd = {};
  void value(int index) {
    checkedbox_adhd.addAll({index:[false,false,false]});
    
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