import 'package:screening_tool/components/class/checkboxstore.dart';

class behaviourpage_result{
Future  data() async {
  checkboxvalues_behavior b1 = checkboxvalues_behavior();

  var datas = await b1.checkedbox_behaviour;
return datas;
}

void show_result()async{
  var result = await data();
  print(result);
}

}