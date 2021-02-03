import 'package:my_tv_program/models/channel_model.dart';
import 'package:my_tv_program/models/programme_model.dart';
import 'package:xml/xml.dart';

class XmlParser {
  static xmlStringToModel(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final List<ChannelModel> channels = _parseChannels(document);
    _parseProgrammes(document, channels);
  }

  static List<ChannelModel> _parseChannels(XmlDocument document) {
    final List<ChannelModel> channels = new List<ChannelModel>();

    final Iterable<XmlElement> findChannels = document.findAllElements('channel');
    findChannels.forEach((element) {
      channels.add(ChannelModel(
          element.attributes.first.value,
          element.findElements('display-name').first.text,
          element.findElements('icon').first.text
      ));
    });

    return channels;
  }

  static _parseProgrammes(XmlDocument document, List<ChannelModel> channels) {
    final Iterable<XmlElement> findProgrammes = document.findAllElements('programme');

    findProgrammes.forEach((programme) {
      final ProgrammeModel p = new ProgrammeModel();

      programme.attributes.forEach((e) {
        switch (e.name.toString()) {
          case 'start':
            p.start = new DateTime(
                int.parse(e.value.substring(0, 4)),
                int.parse(e.value.substring(5, 6)),
                int.parse(e.value.substring(7, 8)),
                int.parse(e.value.substring(9, 10)),
                int.parse(e.value.substring(11, 12)),
                int.parse(e.value.substring(13, 14))
            );
            break;
          case 'stop':
            p.stop = new DateTime(
                int.parse(e.value.substring(0, 4)),
                int.parse(e.value.substring(5, 6)),
                int.parse(e.value.substring(7, 8)),
                int.parse(e.value.substring(9, 10)),
                int.parse(e.value.substring(11, 12)),
                int.parse(e.value.substring(13, 14))
            );
            break;
          case 'channel':
            channels.firstWhere((c) => c.id == e.value).programmes.add(p);
            break;
        }
      });
    });
  }
}