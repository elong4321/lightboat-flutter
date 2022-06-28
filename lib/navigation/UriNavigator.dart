import 'package:lightboat/main.dart';
import 'package:lightboat/navigation/UriDecorator.dart';
import 'package:lightboat/web/WebScreen.dart';

class UriNavigator {
  static const String SCHEME_HTTP = "http";
  static const String SCHEME_HTTPS = "https";
  static bool goto(Uri uri) {
    bool handled = true;
    uri = UriDecorator.parseUri(uri);
    if (uri.hasScheme) {
      switch(uri.scheme) {
        case SCHEME_HTTPS:
        case SCHEME_HTTP:
          app.routerDelegate.setNewRoutePath("/web/${uri.toString()}");
          break;
        default:
          handled = false;
          break;
      }
    }
    return handled;
  }
}