import 'ast_node.dart';

class ArrayContext extends ExpressionContext {
  List<ExpressionContext> items = <ExpressionContext>[];

  ArrayContext(this.items) : super() {
    tokens.addAll(items);
  }

  @override
  String get text => '[${items.map((e) => e.text).join(",")}]';
}
