// <channel id="C47.api.telerama.fr">
//    <display-name>France 5</display-name>
//    <icon src="https://television.telerama.fr/sites/tr_master/files/sheet_media/tv/500x500/47.png" />
// </channel>

import 'package:my_tv_program/models/programme_model.dart';

class ChannelModel {
  String id;
  String name;
  String icon;
  List<ProgrammeModel> programmes;
  ProgrammeModel currentProgramme;
  ProgrammeModel nightProgramme;

  ProgrammeModel programToShow;


  ChannelModel(String id, String name, String icon) {
    this.id = id;
    this.name = name;
    this.icon = icon;
    this.programmes = new List<ProgrammeModel>();
  }
}
