import 'package:test/test.dart';
import 'lexer.dart' as lexer;
import 'parser.dart' as parser;

main() {
  group('lexer', lexer.main);
  group('parser', parser.main);
}