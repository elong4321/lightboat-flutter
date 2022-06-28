import 'package:flutter/widgets.dart';
import 'package:lightboat/home/HomeScreen.dart';
import 'package:lightboat/web/WebScreen.dart';

class LBPageGenerator {

  static Page generate(String route) {
    Page? page = null;
    switch(route) {
      case '/':
        page = HomePage();
        break;
      default:
        if (route.startsWith('/web/')) {
          page = generateWebPage(route);
        }
        break;
    }
    page ??= HomePage();
    return page;
  }

  static Page generateWebPage(String route) {
    String url = route.substring(5);
    return WebPage(url);
  }
}