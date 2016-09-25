import 'dart:convert';
import 'gyp_to_map.dart';
import 'map_to_gyp.dart';
export 'gyp_syntax_error.dart';

final GypCodec GYP = new GypCodec();

class GypCodec extends Codec<Map, String> {
  final Converter<String, Map> decoder = new GypToMap();
  final Converter<Map, String> encoder = new MapToGyp();
}