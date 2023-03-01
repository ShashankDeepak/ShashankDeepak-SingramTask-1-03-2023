// ignore_for_file: public_member_api_docs, sort_constructors_first

//This is model for the Box Widget
import 'package:flutter/material.dart';

class Box {
  String text = "";
  int? index;
  Color color = Colors.blue;
  bool isRed = false;
  bool isEnabledBlue = false;
  Color textColor = Colors.blue;

  Box({
    required this.text,
    required this.index,
    required this.color,
    required this.isRed,
    required this.isEnabledBlue,
    required this.textColor,
  });
}
