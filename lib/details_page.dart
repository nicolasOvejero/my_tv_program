import 'package:flutter/material.dart';
import 'package:my_tv_program/models/channel_model.dart';
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
              child: _channel?.currentProgramme?.icon != null
                  ? Image.network(_channel.currentProgramme.icon)
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
                    child: Text(_channel.currentProgramme.title,
                        style: TextStyle(color: ThemeUtils.color[200], fontSize: 24, fontWeight: FontWeight.bold))),
                Visibility(
                  visible: _channel?.currentProgramme?.subTitle?.isNotEmpty,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(_channel.currentProgramme.subTitle,
                          style: TextStyle(color: ThemeUtils.color[400], fontSize: 16))),
                ),
                Visibility(
                  visible: _channel?.currentProgramme?.desc?.isNotEmpty,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(_channel.currentProgramme.desc,
                          style: TextStyle(color: ThemeUtils.color[500], fontSize: 15))),
                ),
                Row(
                  children: [
                    Text(_channel.currentProgramme.previouslyShown ? 'Rediffusion' : 'Inedit',
                        style: TextStyle(color: ThemeUtils.color[600], fontSize: 15)),
                    Text(' | ', style: TextStyle(color: ThemeUtils.color[600], fontSize: 17)),
                    _formatLength(_channel.currentProgramme.length),
                    Text(' | ', style: TextStyle(color: ThemeUtils.color[600], fontSize: 17)),
                    Text(_channel.currentProgramme.category,
                        style: TextStyle(color: ThemeUtils.color[600], fontSize: 15)),
                  ],
                ),
              ]),
            )
          ]),
        ));
  }
}
