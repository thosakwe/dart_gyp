import 'package:string_editor/chars.dart' as Chars;
import 'package:string_editor/string_editor.dart';

enum TokenType { COLON, COMMA, CURLY_L, CURLY_R, SQUARE_L, SQUARE_R, STRING }

class Token {
  TokenType type;
  String text;

  Token(this.type, this.text);

  @override
  String toString() => "'$text' -> $type";
}

class Lexer {
  List<Token> scan(String text) {
    var tokens = <Token>[];
    var it = new StringEditor(text).iterator;

    while (it.moveNext()) {
      if (it.current.isWhitespace())
        continue;
      else if (it.current == Chars.COLON)
        tokens.add(new Token(TokenType.COLON, ':'));
      else if (it.current == Chars.COMMA)
        tokens.add(new Token(TokenType.COMMA, ','));
      else if (it.current == Chars.CURLY_L)
        tokens.add(new Token(TokenType.CURLY_L, '{'));
      else if (it.current == Chars.CURLY_R)
        tokens.add(new Token(TokenType.CURLY_R, '}'));
      else if (it.current == Chars.SQUARE_L)
        tokens.add(new Token(TokenType.SQUARE_L, '['));
      else if (it.current == Chars.SQUARE_R)
        tokens.add(new Token(TokenType.SQUARE_R, ']'));
      else if (it.current == Chars.SINGLE_QUOTE && it.moveNext()) {
        var str = new StringBuffer(it.current);

        while (it.moveNext() && it.current != Chars.SINGLE_QUOTE)
          str.write(it.current);

        tokens.add(new Token(TokenType.STRING, str.toString()));
      } else if (it.current == Chars.POUND) {
        while (it.current != Chars.NEWLINE) it.moveNext();
      } else
        throw new Exception(
            "Unexpected character in GYP string: '${it.current}'");
    }

    return tokens;
  }
}
