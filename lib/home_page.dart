import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_tv_program/services/xml_parser.dart';
import 'package:my_tv_program/utils/channel_utils.dart';
import 'package:my_tv_program/utils/theme_utils.dart';

import 'models/channel_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<ChannelModel> channels =
      ChannelUtils.sortChannelForFrenchOrder(XmlParser().channels);

  @override
  void initState() {
    super.initState();

    channels.forEach((element) {
      element.currentProgramme = element.programmes.firstWhere((programme) {
        return programme.start.isBefore(DateTime.now()) &&
            programme.stop.isAfter(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: channels.length,
            itemBuilder: (context, index) => Container(
                color: ThemeUtils.color[600],
                child: Card(
                    color: ThemeUtils.color[700],
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
                                    child: Image.network(channels[index].icon,
                                        height: 40),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 6.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(channels[index].name,
                                              style: TextStyle(
                                                  color: ThemeUtils.color[400],
                                                  fontSize: 18.0)),
                                          Text(
                                              channels[index]
                                                  ?.currentProgramme
                                                  ?.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ThemeUtils.color[600],
                                                  fontSize: 16.0)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                        channels[index]?.currentProgramme?.icon,
                                        height: 60),
                                  ),
                                ),
                                Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          channels[index]
                                              ?.currentProgramme
                                              ?.desc,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: ThemeUtils.color[500])),
                                    ))
                              ],
                            )
                            // Text(channels[index]?.currentProgramme?.title),
                          ],
                        ))))));
  }
}
