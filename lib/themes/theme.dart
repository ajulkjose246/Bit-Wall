import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: const Color.fromRGBO(242, 242, 224, 1),
    primary: const Color.fromRGBO(225, 229, 193, 1),
    secondary: const Color.fromRGBO(228, 227, 210, 1),
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
);
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: const Color.fromRGBO(36, 37, 30, 1),
    primary: const Color.fromRGBO(27, 28, 18, 1),
    secondary: const Color.fromRGBO(27, 28, 21, 1),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
);
