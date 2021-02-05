import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:my_tv_program/details_page.dart';
import 'package:my_tv_program/services/xml_parser.dart';
import 'package:my_tv_program/utils/channel_utils.dart';
import 'package:my_tv_program/utils/theme_utils.dart';

import 'models/channel_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<ChannelModel> channels = ChannelUtils.sortChannelForFrenchOrder(XmlParser().channels);

  @override
  void initState() {
    super.initState();

    channels.forEach((element) {
      if (element.programmes != null && element.programmes.isNotEmpty) {
        element.currentProgramme = element.programmes.firstWhere((programme) {
          return programme.start.isBefore(DateTime.now()) && programme.stop.isAfter(DateTime.now());
        }, orElse: () => null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('En ce moment'),
        ),
        backgroundColor: ThemeUtils.color[700],
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(color: ThemeUtils.color[50], height: 1),
            itemCount: channels.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  if (channels[index].currentProgramme != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DetailsPage(channelId: channels[index].id)),
                    );
                  }
                },
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Image.network(channels[index].icon, height: 40),
                              ),
                              Flexible(
                                  flex: 10,
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 6.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(channels[index].name,
                                            style: TextStyle(color: ThemeUtils.color[400], fontSize: 18.0)),
                                        Text(channels[index]?.currentProgramme?.title ?? '-',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ThemeUtils.color[600],
                                                fontSize: 16.0)),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: channels[index]?.currentProgramme?.icon != null
                                      ? Image.network(channels[index]?.currentProgramme?.icon, height: 60)
                                      : Image.asset('assets/default_image.jpg', height: 60),
                                ),
                              ),
                              Flexible(
                                  flex: 3,
                                  fit: FlexFit.tight,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(channels[index]?.currentProgramme?.desc ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(color: ThemeUtils.color[500])),
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
                                  TextSpan(text: DateFormat('HH:mm').format(channels[index]?.currentProgramme?.start)),
                                ],
                              ),
                            ),
                            Text(' | ', style: TextStyle(color: ThemeUtils.color[50], fontSize: 13)),
                            _formatLength(channels[index]?.currentProgramme?.length),
                            Text(' | ', style: TextStyle(color: ThemeUtils.color[50], fontSize: 13)),
                            Text(
                              channels[index]?.currentProgramme?.category ?? '',
                              style: TextStyle(color: ThemeUtils.color[600], fontSize: 12),
                            )
                          ],
                        )
                        // Text(channels[index]?.currentProgramme?.title),
                      ],
                    )))));
  }

  Widget _formatLength(int lengthMin) {
    final duration = Duration(minutes: lengthMin ?? 0);
    String twoDigits(int n) => n >= 10 ? "$n" : "0$n";

    if (lengthMin < 60) {
      return Text(
        '${twoDigits((duration.inMinutes.remainder(60))).toString()} min',
        style: TextStyle(color: ThemeUtils.color[400], fontSize: 12),
      );
    }

    return RichText(
        text: TextSpan(
      text: (duration.inHours.remainder(24)).toString(),
      style: TextStyle(color: ThemeUtils.color[400], fontSize: 12),
      children: <TextSpan>[
        TextSpan(text: 'h'),
        TextSpan(text: twoDigits((duration.inMinutes.remainder(60))).toString()),
      ],
    ));
  }
}
