import 'dart:io';
import 'package:args/command_runner.dart';
import '../make/makefile.dart';
import 'load_bindings.dart';

class ConfigureCommand extends Command {
  String get name => 'configure';
  String get description {
    final fileType = Platform.isWindows ? 'MSVC project files' : 'Makefile';
    return 'Generates a $fileType for the current module.';
  }

  @override
  run() async {
    final binding = await loadBinding();

    final makefile = new Makefile();
    final all = new MakeTarget(name: 'all');
    final outFile = new File.fromUri(Directory.current.uri.resolve('./Makefile'));

    // Just testing, haha

    for (final target in binding['targets']) {
      final executableName = target['target_name'];

      var buildCmd = 'g++ -o $executableName';

      final sources = (() {
        final buf = new StringBuffer();

        for (final source in target['sources']) {
          buf.write('$source ');
        }

        return buf.toString();
      })().trim();

      if (sources.isNotEmpty)
        buildCmd += ' $sources';


      makefile.targets.add(new MakeTarget(name: executableName, commands: [buildCmd]));
      all.dependencies.add(executableName);
    }

    makefile.targets.add(all);
    await outFile.writeAsString(makefile.generate());
  }
}
