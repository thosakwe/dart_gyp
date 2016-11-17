class Target {
  final String targetName, type, winDelayLoadHook;
  final List<String> sources = [], includeDirs = [], dependencies = [];
  final List<List> conditions = [];
  final List<Map> copies = [];
  final Map<String, String> msvsSettings = {}, xcodeSettings = {};

  Target(
      {this.targetName,
      this.type,
      this.winDelayLoadHook: 'false',
      List<String> sources: const [],
      List<String> includeDirs: const [],
      List<String> dependencies: const [],
      List<List> conditions: const [],
      List<Map> copies: const [],
      Map<String, String> msvsSettings: const {},
      Map<String, String> xcodeSettings: const {}}) {
    this.sources.addAll(sources);
    this.includeDirs.addAll(includeDirs);
    this.dependencies.addAll(dependencies);
    this.conditions.addAll(conditions);
    this.copies.addAll(copies);
    this.msvsSettings.addAll(msvsSettings);
    this.xcodeSettings.addAll(xcodeSettings);
  }

  factory Target.fromMap(Map data) {
    return new Target(
        targetName: data['target_name'],
        type: data['type'],
        winDelayLoadHook: data['win_delay_load_hook'] ?? 'false',
        sources: data['sources'] ?? [],
        includeDirs: data['include_dirs'] ?? [],
        dependencies: data['dependencies'] ?? [],
        conditions: data['conditions'] ?? [],
        copies: data['copies'] ?? [],
        msvsSettings: data['msvs_settings'] ?? {},
        xcodeSettings: data['xcode_settings'] ?? {});
  }

  Map toJson() {
    return {
      'target_name': targetName,
      'type': type,
      'win_delay_load_hook': winDelayLoadHook,
      'sources': sources,
      'include_dirs': includeDirs,
      'conditions': conditions,
      'dependencies': dependencies,
      'copies': copies,
      'msvs_settings': msvsSettings,
      'xcode_settings': xcodeSettings
    };
  }
}
