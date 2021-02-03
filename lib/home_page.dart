import 'package:flutter/material.dart';
import 'package:my_tv_program/services/service.dart';
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
  List<ChannelModel> channels = List<ChannelModel>();

  Future<void> _fillChannelsAndProgrammes() async {
    final String xml = await Service.getXmlValuesFormServer();
    XmlParser().xmlStringToModel(xml);
    setState(() {
      channels = ChannelUtils.sortChannelForFrenchOrder(XmlParser().channels);
    });
  }

  @override
  void initState() {
    super.initState();

    _fillChannelsAndProgrammes();
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
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Image.network(channels[index].icon,
                                height: 40, width: 40),
                          ),
                          Flexible(
                              flex: 3,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text(channels[index].name,
                                      style: TextStyle(color: ThemeUtils.color[50])
                                  )
                              )
                          )
                        ],
                      ),
                    )
                )
            )
        )
    );
  }
}
