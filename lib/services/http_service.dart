import 'package:http/http.dart' as http;

class HttpService {
  static Future<String> getXmlValuesFormServer() async {
    final Map<String, String> headers = {"Accept": "text/html,application/xml"};
    final response = await http.get('https://xmltv.ch/xmltv/xmltv-tnt.xml', headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    }

    throw new Exception("No content to show");
  }
}