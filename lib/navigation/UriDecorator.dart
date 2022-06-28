class UriDecorator {

  static Uri parseUriStr(String url) {
    Uri uri = Uri.parse(url);
    return parseUri(uri);
  }

  static Uri parseUri(Uri uri) {
    if (!uri.hasScheme) {
      return Uri.https("${uri.authority}", uri.path, uri.queryParameters);
    }
    return uri;
  }

  static String unwrapTitle(Uri uri) {
    String authorityStr = uri.authority.startsWith("www.") ? uri.authority.substring(4) : uri.authority;
    return "${authorityStr}${uri.path}";
  }
}