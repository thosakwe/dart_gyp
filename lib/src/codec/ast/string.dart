import 'ast_node.dart';
import '../lexer.dart';

class StringContext extends ExpressionContext {
  final Token STRING;

  StringContext(this.STRING) : super() {
    tokens.add(STRING);
  }

  @override
  String get text => "'${STRING.text}'";
}
