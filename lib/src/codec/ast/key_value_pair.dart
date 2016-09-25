import '../lexer.dart';
import 'ast_node.dart';
import 'string.dart';

class KeyValuePairContext extends AstNode {
  StringContext key;
  ExpressionContext value;

  KeyValuePairContext(this.key, this.value) {
    tokens.add(key);
    tokens.add(new Token(TokenType.COLON, ':'));
    tokens.add(value);
  }

  @override
  String get text => "${key.text}:${value.text}";
}