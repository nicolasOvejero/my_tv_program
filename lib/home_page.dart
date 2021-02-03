import 'package:flutter/material.dart';
import 'package:my_tv_program/models/channel_model.dart';
import 'package:my_tv_program/models/programme_model.dart';
import 'package:my_tv_program/services/service.dart';
import 'package:my_tv_program/xml_parser.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _counter = 0;
  List<ChannelModel> channels = List();

  void _incrementCounter() {
    _getAndParse();
    setState(() {
      _counter++;
    });
  }

  Future<void> _getAndParse() async {
    final String xml = await Service.getXmlValuesFormServer();
    XmlParser.xmlStringToModel(xml);
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
