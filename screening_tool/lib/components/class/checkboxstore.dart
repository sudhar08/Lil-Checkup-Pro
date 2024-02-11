

import 'dart:async';

class checkboxvalues_behavior {
   Map<int,List> checkedbox_behaviour = {};
   final StreamController valueschanges = StreamController();
  void value(int index) {
    checkedbox_behaviour.addAll({index:[false,false,false]});
   
    
  }
  dynamic get_values() {
    valueschanges.add(checkedbox_behaviour);
    Stream val = valueschanges.stream;
  }

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