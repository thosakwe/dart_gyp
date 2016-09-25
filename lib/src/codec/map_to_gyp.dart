import 'dart:convert';

class MapToGyp extends Converter<Map, String> {
  @override
  String convert(Map input) => encode(input);

  String encode(value) {
    if (value is String)
      return "'$value'";
    else if (value is List)
      return '[${value.map(encode).join(",")}]';
    else if (value is Map<String, dynamic>) {
      var buf = new StringBuffer('{');
      var i = 0;
      value.forEach((k, v) {
        if (i++ > 0) buf.write(',');
        buf.write("'$k':${encode(v)}");
      });

      buf.write('}');
      return buf.toString();
    } else
      throw new ArgumentError(
          'Cannot serialize a ${value.runtimeType} to GYP.');
  }
}
