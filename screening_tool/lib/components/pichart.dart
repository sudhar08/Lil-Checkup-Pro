
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../utils/colors_app.dart';

class pieChart extends StatefulWidget {
  final double attention;
  final double anextiy;
  final double depression;
  final double adhd;
   pieChart({super.key, required this.attention, required this.anextiy, required this.depression, required this.adhd});

  @override
  State<pieChart> createState() => _pieChartState();
}

class _pieChartState extends State<pieChart> {
    int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio:4,
      child: Row(
        children: <Widget>[
           SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(widget.attention, widget.anextiy,widget.depression,widget.adhd,touchedIndex)
                ),
              ),
            ),
          ),
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Indicator(
                color: Colors.blue, 
                text: "Attention", 
                isSquare: true),
                // Indicator(
                // color: Colors.yellow, 
                // text: "Anxiety", 
                // isSquare: true),
                Indicator(
                color: Colors.purple, 
                text: "Depression", 
                isSquare: true),
                Indicator(
                color: Colors.orange, 
                text: "ADHD", 
                isSquare: true)
              
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }
  }


  List<PieChartSectionData> showingSections(double attention,double anxiety,double depression,double adhd,int touchedIndex ){
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: attention,
            title: '$attention',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:darkColor,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: anxiety,
            title: '$anxiety',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: darkColor,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: depression,
            title: '$depression',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: darkColor,
              shadows: shadows,
            ),
          );
        
           case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: adhd,
            title: '$adhd',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: darkColor,
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }







class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}