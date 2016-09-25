import 'ast/ast.dart';
import 'gyp_syntax_error.dart';
import 'lexer.dart';

class Parser {
  Iterator<Token> _it;

  Parser(List<Token> tokens) {
    _it = tokens.iterator..moveNext();
  }

  CompilationUnitContext compilationUnit() {
    var body = object();

    if (body == null) {
      if (_it.current != null)
        throw new GypSyntaxError("Expected an object, 'found ${_it.current.text}' instead.");
      else throw new GypSyntaxError('Expected an object, found nothing.');
    }

    return new CompilationUnitContext(body);
  }

  KeyValuePairContext keyValuePair() {
    var key = string();

    if (key == null)
      return null;
    else if (!_it.moveNext() || _it.current.type != TokenType.COLON)
      return null;

    if (!_it.moveNext())
      throw new GypSyntaxError(
          'Unexpected end of file while expecting expression.');

    var expr = expression();

    if (expr == null)
      throw new GypSyntaxError(
          'Expected expression, but found ${_it.current.text} instead..');

    return new KeyValuePairContext(key, expr);
  }

  ExpressionContext expression() {
    var arr, obj, str;

    if ((arr = array()) != null)
      return arr;
    else if ((obj = object()) != null)
      return obj;
    else if ((str = string()) != null) return str;

    return null;
  }

  ArrayContext array() {
    if (_it.current == null ||
        _it.current.type != TokenType.SQUARE_L ||
        !_it.moveNext()) return null;

    var items = <ExpressionContext>[];
    var item = expression();

    while (item != null) {
      items.add(item);
      _it.moveNext();

      if (_it.current != null &&
          (_it.current.type == TokenType.COMMA ||
              _it.current.type == TokenType.SQUARE_R)) {
        if (_it.moveNext()) item = expression();
      } else if (_it.current != null)
        throw new GypSyntaxError(
            "Expect ',' or ']', found '${_it.current.text}' instead.");
      else
        break;
    }

    while (_it.current != null &&
        _it.current.type != TokenType.SQUARE_R &&
        _it.moveNext() &&
        _it.current.type == TokenType.COMMA) {
      // Skip trailing commas
    }

    return new ArrayContext(items);
  }

  ObjectContext object() {
    if (_it.current == null ||
        _it.current.type != TokenType.CURLY_L ||
        !_it.moveNext()) return null;

    var pairs = <KeyValuePairContext>[];
    var pair = keyValuePair();

    while (pair != null) {
      pairs.add(pair);
      _it.moveNext();

      if (_it.current != null &&
          (_it.current.type == TokenType.COMMA ||
              _it.current.type == TokenType.CURLY_R)) {
        if (_it.moveNext()) pair = keyValuePair();
      } else if (_it.current != null)
        throw new GypSyntaxError(
            "Expect ',' or '}', found '${_it.current.text}' instead.");
      else
        break;
    }

    while (_it.current != null &&
        _it.current.type != TokenType.CURLY_R &&
        _it.moveNext() &&
        _it.current.type == TokenType.COMMA) {
      // Skip trailing commas
    }

    return new ObjectContext(pairs);
  }

  StringContext string() {
    if (_it.current != null && _it.current.type == TokenType.STRING)
      return new StringContext(_it.current);
    else
      return null;
  }
}
