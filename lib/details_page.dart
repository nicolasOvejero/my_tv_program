import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_tv_program/models/channel_model.dart';
import 'package:my_tv_program/models/programme_model.dart';
import 'package:my_tv_program/services/xml_parser.dart';
import 'package:my_tv_program/utils/theme_utils.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key, this.channelId}) : super(key: key);

  final String channelId;

  @override
  _DetailsPage createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  ChannelModel _channel;
  int _index;

  Widget _formatLength(int lengthMin) {
    final duration = Duration(minutes: lengthMin ?? 0);
    String twoDigits(int n) => n >= 10 ? "$n" : "0$n";

    if (lengthMin < 60) {
      return Text(
        '${twoDigits((duration.inMinutes.remainder(60))).toString()} min',
        style: TextStyle(color: ThemeUtils.color[600], fontSize: 15),
      );
    }

    return RichText(
        text: TextSpan(
      text: (duration.inHours.remainder(24)).toString(),
      style: TextStyle(color: ThemeUtils.color[600], fontSize: 15),
      children: <TextSpan>[
        TextSpan(text: 'h'),
        TextSpan(text: twoDigits((duration.inMinutes.remainder(60))).toString()),
      ],
    ));
  }

  @override
  void initState() {
    super.initState();

    _channel = XmlParser().channels.firstWhere((e) => e.id == widget.channelId);
    if (_channel != null) {
      _index = _channel.programmes.indexWhere((element) =>
          element.start == _channel.programToShow.start && element.stop == _channel.programToShow.stop);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail ${_channel.name}'),
        ),
        backgroundColor: ThemeUtils.color[700],
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FittedBox(
              child: _channel?.programToShow?.icon != null
                  ? Image.network(_channel.programToShow.icon)
                  : Image.asset('assets/default_image.jpg'),
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Image.network(_channel.icon, width: 50),
                  Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(_channel.name, style: TextStyle(color: ThemeUtils.color[50], fontSize: 20)))
                ]),
                Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(_channel.programToShow.title,
                        style: TextStyle(color: ThemeUtils.color[200], fontSize: 24, fontWeight: FontWeight.bold))),
                Visibility(
                  visible: _channel?.programToShow?.subTitle?.isNotEmpty,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(_channel.programToShow.subTitle,
                          style: TextStyle(color: ThemeUtils.color[400], fontSize: 16))),
                ),
                Visibility(
                  visible: _channel?.programToShow?.desc?.isNotEmpty,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(_channel.programToShow.desc,
                          style: TextStyle(color: ThemeUtils.color[500], fontSize: 15))),
                ),
                Row(
                  children: [
                    Text(_channel.programToShow.previouslyShown ? 'Rediffusion' : 'Inedit',
                        style: TextStyle(color: ThemeUtils.color[600], fontSize: 15)),
                    Text(' | ', style: TextStyle(color: ThemeUtils.color[600], fontSize: 17)),
                    _formatLength(_channel.programToShow.length),
                    Text(' | ', style: TextStyle(color: ThemeUtils.color[600], fontSize: 17)),
                    Text(_channel.programToShow.category,
                        style: TextStyle(color: ThemeUtils.color[600], fontSize: 15)),
                  ],
                ),
                if (_channel.programmes.length > _index + 1)
                  Divider(color: Color(0xff212529), height: 40, thickness: 2, indent: 75, endIndent: 75),
                if (_channel.programmes.length > _index + 1)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text('Après ce programme',
                        style: TextStyle(color: ThemeUtils.color[200], fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                if (_channel.programmes.length > _index + 1) _nextProgrammes(_channel?.programmes[_index + 1]),
                if (_channel.programmes.length > _index + 2)
                  Divider(color: Color(0xff212529), height: 20, thickness: 1),
                if (_channel.programmes.length > _index + 2) _nextProgrammes(_channel?.programmes[_index + 2]),
              ]),
            ),
          ]),
        ));
  }

  Widget _nextProgrammes(ProgrammeModel programme) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(programme?.title ?? '-',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, color: ThemeUtils.color[600], fontSize: 16.0)),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: programme?.icon != null
                    ? Image.network(programme?.icon, height: 60)
                    : Image.asset('assets/default_image.jpg', height: 60),
              ),
            ),
            Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(programme?.desc ?? '',
                      overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(color: ThemeUtils.color[500])),
                ))
          ],
        ),
      ),
      Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Début : ',
              style: TextStyle(color: ThemeUtils.color[200], fontSize: 12),
              children: <TextSpan>[
                TextSpan(text: programme?.start != null ?
                  DateFormat('HH:mm').format(programme?.start) :
                  '-'
                ),
              ],
            ),
          ),
          Text(' | ', style: TextStyle(color: ThemeUtils.color[50], fontSize: 13)),
          _formatLength(programme?.length),
          Text(' | ', style: TextStyle(color: ThemeUtils.color[50], fontSize: 13)),
          Text(programme?.category ?? '', style: TextStyle(color: ThemeUtils.color[600], fontSize: 12))
        ],
      )
    ]);
  }
}
