import '../lexer.dart';

class AstNode extends Token {
  @override
  String get text => tokens.map((t) => t.text).join();

  AstNode():super(null, '');

  List<Token> tokens = <Token> [];

  @override
  String toString() => "'$text' -> $runtimeType";
}

class ExpressionContext extends AstNode {
  ExpressionContext():super();
}