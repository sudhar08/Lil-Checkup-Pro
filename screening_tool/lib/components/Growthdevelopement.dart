import "package:flutter/material.dart";
import "package:screening_tool/utils/colors_app.dart";
import "package:screening_tool/utils/tropography.dart";
import "package:sizer/sizer.dart";

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