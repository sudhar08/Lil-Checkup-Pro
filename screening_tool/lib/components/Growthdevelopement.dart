import "package:flutter/material.dart";

import "package:sizer/sizer.dart";

import "../utils/colors_app.dart";
import "../utils/tropography.dart";

class Questionsgrowth extends StatefulWidget {
 final bool yes;
final bool no;
final String index;
final String Question;
final ValueChanged onchanged_no;
final ValueChanged onchanged_yes;
  const Questionsgrowth({super.key, required this.yes, required this.no, required this.onchanged_yes, required this.onchanged_no, required this.index, required this.Question});

  @override
  State<Questionsgrowth> createState() => _QuestionsgrowthState();
}

class _QuestionsgrowthState extends State<Questionsgrowth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 22.h,
      decoration: BoxDecoration(
        color: widget_color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
                  BoxShadow(
                    color: primary_color_shadow,
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(0, 3.54),
                  )
                ]
      ),
      child: Column(
        children: [
          Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${widget.index} . ${widget.Question}",
                  style: style_text_bold,
                ),
              ),
              Divider(height: 2.h, thickness: 4.0,),
              CheckboxListTile(
              title: Text("Yes",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold'),),
              activeColor: Colors.green,
              
      
              value: widget.yes,
              onChanged:widget.onchanged_yes,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            CheckboxListTile(
              title: Text("No",style: TextStyle(fontSize: 13.sp,fontFamily: 'SF-Pro-Bold'),),
              activeColor: red_aceent,
              
      
              value: widget.no,
              onChanged:widget.onchanged_no,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
            

              

      ]),
    );
  }
}


class Newgrowth extends StatefulWidget {
  final String sno;
  final String Q;
  final int index;
    int? never;
    int? often;
   
   
  final  onchanged_yes;
   
    final ValueChanged onchanged_no;
   Newgrowth({super.key, required this.sno, required this.Q, required this.index, required this.onchanged_no, required this.never, required this.often, this.onchanged_yes});

  @override
  State<Newgrowth> createState() => _NewgrowthState();
}

class _NewgrowthState extends State<Newgrowth> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 0),
      child: Container(
        width: 88.w,
        height: 22.h,
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
            
            RadioListTile<int>(
            title: Text('YES'),
            activeColor: never,
            value: 0,
            groupValue: widget.never,
            onChanged: widget.onchanged_yes
            
          ),
          
RadioListTile(
            title: Text('NO'),
            value: 1,
            activeColor: sometimes,
            groupValue: widget.never,
            onChanged:  widget.onchanged_no
          ),
          
            
          ],
        ),
      ),
    );
  }
}