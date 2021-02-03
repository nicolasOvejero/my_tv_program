// <programme start="20210203125500 +0100" stop="20210203133600 +0100" channel="C34.api.telerama.fr">
//    <title>The Tonight Show Starring Jimmy Fallon</title>
//    <desc lang="fr">Présenté par le talentueux Jimmy Fallon, The Tonight Show, diffusé d'abord aux Etats-Unis, propose un moment unique : interviews décalées, gags délirants, parodies hilarantes, sketchs mythiques, défis rocambolesques. Une pléiade de stars est invitée chaque soir pour contribuer à ce grand moment de divertissement et d'humour.</desc>
//    <category lang="fr">talk-show</category>
//    <length units="minutes">41</length>
//    <icon src="https://television.telerama.fr/sites/tr_master/files/sheet_media/media/996c68e5b9f8758ed8deac014626dc8d3a6b600f.jpg" />
//    <previously-shown />
//    <subtitles type="onscreen">
//       <language>fr</language>
//    </subtitles>
//    <rating system="CSA">
//       <value>Tout public</value>
//    </rating>
// </programme>

class ProgrammeModel {
  DateTime start;
  DateTime stop;
  String title;
  String desc;
  String category;
  int length;
  String icon;
  bool previouslyShown;
  String subtitles;
  String rating;
}
