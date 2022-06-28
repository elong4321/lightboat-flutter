import 'package:flutter/material.dart';
import 'package:lightboat/route/LBRouteParser.dart';
import 'package:lightboat/route/LBRouterDelegate.dart';

import 'storage/LBStorage.dart';
import 'PagesModel.dart';

class AppState {
  LBStorage storage = LBStorage();
  BuildContext? context;
  LBRouterDelegate routerDelegate = LBRouterDelegate();
  LBRouteParser routeParser = LBRouteParser();

  List<String> _histories = [];
  bool _historiesLoaded = false;

  Future<List<String>> loadHistory() async {
    return await storage.queryHistories(10);
  }

  Future<List<String>> get histories async {
    if (!_historiesLoaded) {
      _histories = await loadHistory();
      _historiesLoaded = true;
    }
    return _histories;
  }
}