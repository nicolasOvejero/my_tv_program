import 'package:flutter/material.dart';
import 'package:my_tv_program/utils/theme_utils.dart';

import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon programme TV',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff343a40, ThemeUtils.color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Mon programme TV'),
    );
  }
}
