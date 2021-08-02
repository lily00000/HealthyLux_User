import 'dart:math';

import 'package:flutter/material.dart';

class CalculateResult {
  CalculateResult(this.weight, this.height);
  final int height;
  final int weight;
  double result;
  String msg = "";

  String calculateResult() {
    result = weight / pow(height / 100, 2);
    return result.toStringAsFixed(1);
  }

  String getDescription() {
    if (result > 25) {
      msg = "Overweight";
      return " Overweight \n You have a higher weight then normal.";
    } else if (result > 18.5) {
      msg = "Normal";
      return "Normal \n You have a normal weight";
    } else if (result < 18.6) {
      msg = "Underweight";
      return "Underweight \n Your weight is less then normal weight";
    }
  }
}
