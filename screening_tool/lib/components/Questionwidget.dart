
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
   int? never;
   int? often;
   int? always;
   
  final  onchanged_never;
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
            
            RadioListTile<int>(
            title: Text('Never'),
            activeColor: never,
            value: 0,
            groupValue: widget.never,
            onChanged: widget.onchanged_never
            
          ),
          
RadioListTile(
            title: Text('often'),
            value: 1,
            activeColor: sometimes,
            groupValue: widget.never,
            onChanged:  widget.onchanged_never
          ),
          RadioListTile(
            title: Text('Always'),
            value: 2,
            activeColor: redcolor,
            groupValue: widget.never,
            onChanged: widget.onchanged_never
          ),
            
          ],
        ),
      ),
    );
  }
}


class newWidget extends StatefulWidget {
  final String sno;
  final String Q;
  final int index;
  final int? selectedValue; // Receive the entire list
  final ValueChanged<int> onchanged;
  const newWidget({super.key, required this.sno, required this.Q, required this.index,  required this.onchanged, required this.selectedValue});

  @override
  State<newWidget> createState() => _newWidgetState();
}

class _newWidgetState extends State<newWidget> {
  @override
  
  Widget build(BuildContext context) {
    final _selectedValue = widget.selectedValue;
   
      
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
            
            RadioListTile<int>(
            title: Text('Never'),
            activeColor: never,
            value: 1,
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                widget.onchanged(value!);
              });
              }
            
          ),
          
RadioListTile(
            title: Text('often'),
            value: 2,
            activeColor: sometimes,
            groupValue: _selectedValue,
            onChanged: (value) => widget.onchanged(value!)
          ),
          RadioListTile(
            title: Text('Always'),
            value: 3,
            activeColor: redcolor,
            groupValue: _selectedValue,
            onChanged: (value) => widget.onchanged(value!)
          )])));
  }}


