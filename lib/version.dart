class Version {
  String extraText = '';

  static Version? _instance;
  factory Version() => _instance ??= Version._();

  get selectedTabOnStartUp => Uri.base.toString().contains('http') ? 0 : 4;

  String mainTitle() {
    String extraText = '';
    String uri = Uri.base.toString();
    if (!uri.contains('125')) {
      extraText = '(555 $uri';
    }
    return 'Lynda\'s Super Jukebox $extraText';
  }

  Version._() {
    extraText = '643';
  }
}
