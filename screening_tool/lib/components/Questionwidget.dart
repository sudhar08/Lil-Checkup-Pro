
import 'package:flutter/material.dart';
import 'package:screening_tool/components/class/behaviour.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';


class Questionwidget extends StatefulWidget {
  final String sno;
  final String Q;
  final int lenght;
  const Questionwidget({super.key, required this.sno, required this.Q, required this.lenght});

  @override
  State<Questionwidget> createState() => _QuestionwidgetState();
}

class _QuestionwidgetState extends State<Questionwidget> {
  bool checkedValue_never = false;
  bool checkedValue_often = false;
  bool checkedValue_sometimes = false;

  
  @override
  
  Widget build(BuildContext context) {
   
   behaviourpages b1 = behaviourpages();
   b1.add(widget.lenght);
   
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 0),
      child: Container(
        width: 88.w,
        height: 27.h,
        decoration: BoxDecoration(
            color: widget_color_1, borderRadius: BorderRadius.circular(15),
             boxShadow: [
                  BoxShadow(
                    color: primary_color_shadow,
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(0, 3.54),
                  )
                ],
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 92.w,
              height: 5.3.h,
              decoration: BoxDecoration(
                color: widget_color_1,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Text(
                  "${widget.sno} .${widget.Q} ",
                  style: style_text_bold,
                ),
              ),
            ),
            CheckboxListTile(
              title: Text("NEVER",style: style_text_bold,),
              activeColor: Colors.green,
      
              value: checkedValue_never,
              onChanged: (Newvalue) {
                setState(() {
                  checkedValue_never = Newvalue!;
                  checkedValue_often = false;
                  checkedValue_sometimes = false;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("OFTEN",style: style_text_bold),
              activeColor: Colors.orange,
      
              value: checkedValue_often,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_never = false;
                  b1.values[widget.lenght]![1] = newValue!;
                  checkedValue_sometimes = false;
                  
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("SOMETIMES",style: style_text_bold),
              activeColor: Colors.red,
      
              value: checkedValue_sometimes,
              onChanged: (newValue) {
                setState(() {
                  checkedValue_never = false;
                  checkedValue_often = false;
                  checkedValue_sometimes = newValue!;
                  
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            )
          ],
        ),
      ),
    );
  }
}
