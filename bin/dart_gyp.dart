import 'package:args/command_runner.dart';
import 'package:gyp/src/commands/commands.dart';

main(List<String> args) {
  final runner = new CommandRunner('dart_gyp', 'Dart native addon build tool.');
  runner.addCommand(new ConfigureCommand());
  return runner.run(args);
}
