import 'package:data/core/config/config.dart';

class EDDEndpoints {
  static final String _baseUrl = Config.EDD_HOST + "/talks/";

  static String getAllTalks() => _baseUrl;

  static String getTalksById(int id) => '$_baseUrl/$id';

  static String getTalkByTrack(String track) => '$_baseUrl?track=$track';
}
