import 'package:my_tv_program/models/channel_model.dart';

class ChannelUtils {
  static List<String> frenchOrder = [
    'C192.api.telerama.fr',
    'C4.api.telerama.fr',
    'C80.api.telerama.fr',
    'C34.api.telerama.fr',
    'C47.api.telerama.fr',
    'C47.api.telerama.fr',
    'C118.api.telerama.fr',
    'C111.api.telerama.fr',
    'C445.api.telerama.fr',
    'C119.api.telerama.fr',
    'C195.api.telerama.fr',
    'C446.api.telerama.fr',
    'C444.api.telerama.fr',
    'C234.api.telerama.fr',
    'C78.api.telerama.fr',
    'C481.api.telerama.fr',
    'C226.api.telerama.fr',
    'C458.api.telerama.fr',
    'C482.api.telerama.fr',
    'C1404.api.telerama.fr',
    'C1401.api.telerama.fr',
    'C1403.api.telerama.fr',
    'C1402.api.telerama.fr',
    'C1400.api.telerama.fr',
    'C2111.api.telerama.fr',
    'C1399.api.telerama.fr',
    'C112.api.telerama.fr',
  ];

  static List<ChannelModel> sortChannelForFrenchOrder(
      List<ChannelModel> toSort) {
    toSort.sort((ChannelModel a, ChannelModel b) {
      return ChannelUtils.frenchOrder
          .indexOf(a.id)
          .compareTo(ChannelUtils.frenchOrder.indexOf(b.id));
    });
    return toSort;
  }
}
