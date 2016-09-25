import '../lexer.dart';
import 'ast_node.dart';
import 'key_value_pair.dart';

class ObjectContext extends ExpressionContext {
  List<KeyValuePairContext> pairs;

  ObjectContext(List<KeyValuePairContext> this.pairs) : super() {
    for (int i = 0; i < pairs.length; i++) {
      if (i > 0) tokens.add(new Token(TokenType.COMMA, ','));
      tokens.add(pairs[i]);
    }
  }

  @override
  String get text => '{${pairs.map((pair) => pair.text).join(",")}}';
}
