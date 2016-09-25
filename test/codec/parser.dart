import 'package:gyp/src/codec/ast/ast.dart';
import 'package:gyp/src/codec/lexer.dart';
import 'package:gyp/src/codec/parser.dart';
import 'package:test/test.dart';

final Lexer _lexer = new Lexer();

main() {
  group('key value pair context', () {
    test('string value', () {
      var parser = _parse('''
      # This is a comment
      'foo'       :
\t      'bar'
      ''');
      var ctx = parser.keyValuePair();

      print(ctx);
      expect(ctx, isNotNull);
      expect(ctx.tokens, hasLength(3));
      expect(ctx.key, isNotNull);
      expect(ctx.key, new isInstanceOf<StringContext>());
      expect(ctx.key.text, equals("'foo'"));
      expect(ctx.value, isNotNull);
      expect(ctx.value, new isInstanceOf<StringContext>());
      expect(ctx.value.text, equals("'bar'"));
    });
  });

  test('object context', () {
    var parser = _parse('''
    {
      'foo': 'bar',
      'hello':
      {
        'world': 'sekai',
        'abc': ['1', '2', '3']
      }
    }
    ''');
    var ctx = parser.object();

    print(ctx);
    expect(ctx, isNotNull);
  });

  test('string context', () {
    var parser = _parse('''
    'Hello, world!'
    ''');
    var ctx = parser.string();

    print(ctx);
    expect(ctx, isNotNull);
    expect(ctx.tokens, hasLength(1));
    expect(ctx.tokens.first.type, equals(TokenType.STRING));
    expect(ctx.tokens.first.text, equals('Hello, world!'));
  });
}

Parser _parse(String text) => new Parser(_lexer.scan(text));
