class Makefile {
  final List<MakeTarget> targets = [];

  String generate() {
    final buf = new StringBuffer();

    for (final target in targets) {
      buf.write('${target.name}:');

      if (target.dependencies.isNotEmpty) {
        for (int i = 0; i < target.dependencies.length; i++) {
          if (i > 0)
            buf.write(', ');
          buf.write(target.dependencies[i]);
        }
      }

      buf.writeln();

      for (final command in target.commands) {
        buf.writeln('\t$command');
      }

      buf.writeln();
    }

    return buf.toString().trim();
  }
}

class MakeTarget {
  final String name;
  final List<String> commands = [], dependencies= [];

  MakeTarget({this.name, List<String> commands: const [], List<String> dependencies: const []}) {
    this.commands.addAll(commands);
    this.dependencies.addAll(dependencies);
  }
}
