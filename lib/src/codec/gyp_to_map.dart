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
    return visitExpression(compilationUnit.body);
  }

  visitExpression(ExpressionContext ctx) {
    if (ctx is StringContext)
      return ctx.STRING.text;
    else if (ctx is ArrayContext)
      return ctx.items.map(visitExpression).toList();
    else if (ctx is ObjectContext) {
      var result = {};

      for (var pair in ctx.pairs) {
        result[pair.key.STRING.text] = visitExpression(pair.value);
      }

      return result;
    }
  }
}
