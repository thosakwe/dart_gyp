import 'dart:convert';
import 'ast/ast.dart';
import 'lexer.dart';
import 'parser.dart';

class GypToMap extends Converter<String, Map> {
  final Lexer _lexer = new Lexer();
  @override
  Map convert(String input) {
    var tokens = _lexer.scan(input);
    var parser = new Parser(tokens);
    var compilationUnit = parser.compilationUnit();
    var result = {};

    for (var pair in compilationUnit.body.pairs) {
      result[pair.key.STRING.text] = visitExpression(pair.value);
    }

    return result;
  }

  visitExpression(ExpressionContext ctx) {
    if (ctx is StringContext)
      return ctx.STRING.text;
  }
}
