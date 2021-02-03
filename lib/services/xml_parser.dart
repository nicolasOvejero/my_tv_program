import 'dart:convert' show utf8;

import 'package:my_tv_program/models/channel_model.dart';
import 'package:my_tv_program/models/programme_model.dart';
import 'package:xml/xml.dart';

class XmlParser {
  static final XmlParser _singleton = XmlParser._internal();
  final List<ChannelModel> channels = List<ChannelModel>();

  factory XmlParser() {
    return _singleton;
  }

  XmlParser._internal();

  xmlStringToModel(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    _parseChannels(document);
    _parseProgrammes(document, channels);
  }

  static List<ChannelModel> _parseChannels(XmlDocument document) {
    final Iterable<XmlElement> findChannels =
        document.findAllElements('channel');
    findChannels.forEach((element) {
      XmlParser().channels.add(ChannelModel(
          element.getAttribute('id'),
          utf8.decode(element.getElement('display-name')?.text?.runes?.toList()),
          element.getElement('icon')?.getAttribute('src')));
    });
  }

  static _parseProgrammes(XmlDocument document, List<ChannelModel> channels) {
    final Iterable<XmlElement> findProgrammes =
        document.findAllElements('programme');

    findProgrammes.forEach((programme) {
      final ProgrammeModel p = new ProgrammeModel();

      p.title = utf8.decode(programme.getElement('title')?.text?.runes?.toList() ?? []);
      p.desc = utf8.decode(programme.getElement('desc')?.text?.runes?.toList() ?? []);
      p.category = utf8.decode(programme.getElement('category')?.text?.runes?.toList() ?? []);
      p.length = int.parse(programme.getElement('length')?.text);
      p.icon = programme.getElement('icon')?.getAttribute('src');
      p.previouslyShown = programme.getElement('previously-shown') != null;

      final String start = programme.getAttribute('start');
      p.start = new DateTime(
          int.parse(start.substring(0, 4)),
          int.parse(start.substring(5, 6)),
          int.parse(start.substring(7, 8)),
          int.parse(start.substring(9, 10)),
          int.parse(start.substring(11, 12)),
          int.parse(start.substring(13, 14)));

      final String stop = programme.getAttribute('stop');
      p.stop = new DateTime(
          int.parse(stop.substring(0, 4)),
          int.parse(stop.substring(5, 6)),
          int.parse(stop.substring(7, 8)),
          int.parse(stop.substring(9, 10)),
          int.parse(stop.substring(11, 12)),
          int.parse(stop.substring(13, 14)));

      final String channel = programme.getAttribute('channel');
      channels.firstWhere((c) => c.id == channel).programmes.add(p);
    });
  }
}
