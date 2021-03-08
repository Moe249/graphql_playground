import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void showStarsToast(int stars, BuildContext context) {
  Toast.show(
    "$stars " + ((stars == 1) ? "star" : "stars"),
    context,
    duration: Toast.LENGTH_SHORT,
    gravity: Toast.BOTTOM,
  );
}
