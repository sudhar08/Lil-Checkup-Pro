import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSProgressBar extends StatelessWidget {
  final double progress; // Progress value between 0 and 1
  final int currentStep; // Current step
  final int totalSteps; // Total steps

  IOSProgressBar({
    required this.progress,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label with currentStep/totalSteps format
        Text(
          '$currentStep/$totalSteps',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.activeBlue,
          ),
        ),
        
       
        SizedBox(height: 8),
        // Styled Progress Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: LinearProgressIndicator(
            value: progress, // Current progress (from 0 to 1)
            color: CupertinoColors.activeBlue,
            
          ),
        ),
      ],
    );
  }
}
