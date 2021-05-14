import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HttpService {
  static Future<String> getXmlValuesFormServer() async {
    WidgetsFlutterBinding.ensureInitialized();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/programmes.txt');

    if (await file.exists()) {
      DateTime lastModifies = await file.lastModified();
      if (DateTime.now().subtract(Duration(hours: 2)).isBefore(lastModifies)) {
        return await file.readAsString();
      } else {
        file.writeAsString('');
      }
    }

    final Map<String, String> headers = {"Accept": "text/html,application/xml"};
    print(Uri.https('xmltv.ch', 'xmltv/xmltv-tnt.xml'));
    final response = await http.get(Uri.https('xmltv.ch', 'xmltv/xmltv-tnt.xml'), headers: headers);

    if (response.statusCode == 200) {
      file.writeAsString(response.body);
      return response.body;
    }

    throw new Exception("No content to show");
  }
}