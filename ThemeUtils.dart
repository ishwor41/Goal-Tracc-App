import 'package:flutter/material.dart';


bool isThemeCurrentlyDark(BuildContext context) =>
    (Theme.of(context).brightness == Brightness.dark);

Color invertColors(BuildContext context) =>
    isThemeCurrentlyDark(context) ? Color(0xffeceff1):Color(0xff455a64);

Brightness getInvertTheme(BuildContext context) =>
    isThemeCurrentlyDark(context) ? Brightness.light : Brightness.dark;
