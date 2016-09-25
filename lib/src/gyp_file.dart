import 'codec/codec.dart';

class GypFile {
  GypFile();

  factory GypFile.fromMap(Map data) {
    return new GypFile();
  }

  factory GypFile.parse(String text) => new GypFile.fromMap(GYP.decode(text));
}