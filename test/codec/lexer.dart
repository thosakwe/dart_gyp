import 'package:gyp/src/codec/lexer.dart';
import 'package:test/test.dart';

main() {
  var lexer = new Lexer();

  test('complex', () {
    var tokens = lexer.scan('''
    'includes': [
      '../build/common.gypi',
    ]
    ''');

    print(tokens.join('\n'));
    expect(tokens, hasLength(6));
    expect(tokens[0].type, equals(TokenType.STRING));
    expect(tokens[0].text, equals('includes'));
    expect(tokens[1].type, equals(TokenType.COLON));
    expect(tokens[2].type, equals(TokenType.SQUARE_L));
    expect(tokens[3].type, equals(TokenType.STRING));
    expect(tokens[3].text, equals('../build/common.gypi'));
    expect(tokens[4].type, equals(TokenType.COMMA));
    expect(tokens[5].type, equals(TokenType.SQUARE_R));
  });

  test('object', () {
    // Purposely formatted weirdly
    var tokens = lexer.scan('''
    {       'foo'
          :     'bar'
                      }
    ''');

    print(tokens.join('\n'));
    expect(tokens, hasLength(5));
    expect(tokens[0].type, equals(TokenType.CURLY_L));
    expect(tokens[1].type, equals(TokenType.STRING));
    expect(tokens[1].text, equals('foo'));
    expect(tokens[2].type, equals(TokenType.COLON));
    expect(tokens[3].type, equals(TokenType.STRING));
    expect(tokens[3].text, equals('bar'));
    expect(tokens[4].type, equals(TokenType.CURLY_R));
  });

  test('string', () {
    var tokens = lexer.scan('''
    'Hello, world!'
    ''');

    print(tokens);
    expect(tokens, hasLength(1));
    expect(tokens[0].type, equals(TokenType.STRING));
    expect(tokens[0].text, equals('Hello, world!'));
  });
}