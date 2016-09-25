import 'ast_node.dart';
import 'object.dart';

class CompilationUnitContext extends AstNode {
  ObjectContext body;

  CompilationUnitContext(this.body):super() {
    tokens.add(body);
  }
}