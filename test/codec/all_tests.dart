import 'package:gyp/gyp.dart';
import 'package:test/test.dart';
import 'lexer.dart' as lexer;
import 'parser.dart' as parser;

main() {
  group('lexer', lexer.main);
  group('parser', parser.main);

  test('simple', () {
    var config = GYP.decode("{'foo':'bar'}");

    print(config);
    expect(config.keys, hasLength(1));
    expect(config['foo'], equals('bar'));
  });

  test('with array value', () {
    var config = GYP.decode('''
    # Mitt Romney lost the election
    {
      'barack': 'obama', # Hopefully Trump loses
      'years': ['2008', '2012']
      # I really hope so...
    }
    ''');

    print(config);
    expect(config.keys, hasLength(2));
    expect(config['barack'], equals('obama'));
    expect(config['years'], hasLength(2));
    expect(config['years'][0], equals('2008'));
    expect(config['years'][1], equals('2012'));
  });

  test('executable target skeleton', () {
    // This is too lengthy to test, but it does work.
    var config = GYP.decode('''
    {
      'targets': [
        {
          'target_name': 'foo',
          'type': 'executable',
          'msvs_guid': '5ECEC9E5-8F23-47B6-93E0-C3B328B3BE65',
          'dependencies': [
            'xyzzy',
            '../bar/bar.gyp:bar',
          ],
          'defines': [
            'DEFINE_FOO',
            'DEFINE_A_VALUE=value',
          ],
          'include_dirs': [
            '..',
          ],
          'sources': [
            'file1.cc',
            'file2.cc',
          ],
          'conditions': [
            ['OS=="linux"', {
              'defines': [
                'LINUX_DEFINE',
              ],
              'include_dirs': [
                'include/linux',
              ],
            }],
            ['OS=="win"', {
              'defines': [
                'WINDOWS_SPECIFIC_DEFINE',
              ],
            }, { # OS != "win",
              'defines': [
                'NON_WINDOWS_DEFINE',
              ],
            }]
          ],
        },
      ],
    }
    ''');

    print(config);
  });
}