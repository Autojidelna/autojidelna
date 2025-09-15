class Url {
  static final RegExp _cleanUrlRegExp = RegExp(r'^(?:https?:\/\/)?([^\/:]+)(?::(\d+))?(\/.*)?$');
  static bool isSame(String url, String url2) {
    final RegExp regex = _cleanUrlRegExp;
    final RegExpMatch? match = regex.firstMatch(url);
    final RegExpMatch? match2 = regex.firstMatch(url2);

    if (match == null || match2 == null) return false;
    return match.group(1) == match2.group(1);
  }

  static String clean(String url) {
    final RegExp regex = _cleanUrlRegExp;
    final RegExpMatch? match = regex.firstMatch(url);

    if (match == null || match.group(1) == null) return '';

    final host = match.group(1)!;
    final port = match.group(2) != null ? ':${match.group(2)}' : '';
    final path = match.group(3) ?? '';

    return '$host$port$path';
  }
}
