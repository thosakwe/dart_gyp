import 'target.dart';

class Bindings {
  final List<Target> targets = [];
  final Map<String, String> variables = {};
  final List<String> includes = [];
  final Map targetDefaults = {};
  final List<List> conditions = [];

  Bindings(
      {List<Target> targets: const [],
      Map<String, String> variables: const {},
      List<String> includes: const [],
      Map targetDefaults: const {},
      List<List> conditions: const []}) {
    this.targets.addAll(targets);
    this.variables.addAll(variables);
    this.targetDefaults.addAll(targetDefaults);
    this.conditions.addAll(conditions);
  }

  factory Bindings.fromMap(Map data) {
    return new Bindings(
        targets: data['targets'].map((target) => new Target.fromMap(target)),
        variables: data['variables'] ?? {},
        includes: data['includes'] ?? [],
        targetDefaults: data['target_defaults'],
        conditions: data['conditions'] ?? []);
  }

  Map toJson() {
    final result = {
      'targets': targets.map((target) => target.toJson()),
      'variables': variables,
      'includes': includes,
      'conditions': conditions
    };

    if (targetDefaults.length > 0) {
      result['target_defaults'] = targetDefaults;
    }

    return result;
  }
}
