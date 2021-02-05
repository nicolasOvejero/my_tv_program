import 'package:flutter/material.dart';
import 'package:my_tv_program/services/http_service.dart';
import 'package:my_tv_program/services/xml_parser.dart';
import 'package:my_tv_program/utils/theme_utils.dart';

import 'home_page.dart';

Future<void> main() async {
  final String xml = await HttpService.getXmlValuesFormServer();
  XmlParser().xmlStringToModel(xml);

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
      home: HomePage(),
    );
  }
}
