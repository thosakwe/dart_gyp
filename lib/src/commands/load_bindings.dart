import 'dart:async';
import 'dart:io';
import '../../gyp.dart';

final file = new File.fromUri(Directory.current.uri.resolve('./binding.gyp'));

Future<Map> loadBinding() {
  return file.readAsString().then(GYP.decode);
}
