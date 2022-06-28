import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef Pages = List<Page>;

class PagesModel extends ChangeNotifier {
  final Pages _pages = [];

  addPage(Page page) {
    _pages.add(page);
    notifyListeners();
  }

  removePage(Page page) {
    _pages.remove(page);
    notifyListeners();
  }

  Pages get pages {
    Pages list = [];
    list.addAll(_pages);
    print("pages: $list");
    return list;
  }
}