class Logger {
  static List<String> logs = List.empty(growable: true);

  //One instance, needs factory
  static Logger? _instance;
  factory Logger() => _instance ??= Logger._();
  Logger._();

  void log(String s) {
    logs.add(s);
  }
}
