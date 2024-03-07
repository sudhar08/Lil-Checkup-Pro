
import 'package:flutter/material.dart';
import 'package:screening_tool/components/class/checkboxstore.dart';
import 'package:screening_tool/utils/colors_app.dart';
import 'package:screening_tool/utils/tropography.dart';
import 'package:sizer/sizer.dart';


// ignore: must_be_immutable
class Questionwidget extends StatefulWidget {
  final String sno;
  final String Q;
  final int index;
   bool never;
   bool often;
   bool always;

  final ValueChanged onchanged_never;
   final ValueChanged onchanged_often;
    final ValueChanged onchanged_always;
   Questionwidget({super.key, required this.sno, required this.Q, required this.index, required this.never, required this.onchanged_never, required this.often, required this.always, required this.onchanged_often, required this.onchanged_always});

  @override
  State<Questionwidget> createState() => _QuestionwidgetState();
}

class _QuestionwidgetState extends State<Questionwidget> {
  


  @override
  
  Widget build(BuildContext context) {
   
      
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 0),
      child: Container(
        width: 88.w,
        height: 29.h,
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
                padding:  EdgeInsets.all(8.0),
                child: Text(
                  "${widget.sno} .${widget.Q} ",
                  style: style_text_bold,
                ),
              ),
              
            ),
            Divider(height: 0.3.h,),
            

            CheckboxListTile(
              title: Text("NEVER",style: style_text_bold,),
              activeColor: Colors.green,
      
              value: widget.never,
              onChanged:widget.onchanged_never,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("OFTEN",style: style_text_bold),
              activeColor: Colors.orange,
      
              value: widget.often,
              onChanged: widget.onchanged_often,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("SOMETIMES",style: style_text_bold),
              activeColor: Colors.red,
      
              value: widget.always,
              onChanged: widget.onchanged_always,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            )
          ],
        ),
      ),
    );
  }
}
