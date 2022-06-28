import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'LBPageGenerator.dart';

class LBRouterDelegate extends RouterDelegate<String> with PopNavigatorRouterDelegateMixin<String>, ChangeNotifier {
  final List<String> stack = [];

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>(debugLabel: "navigatorKey");

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.generate(stack.length, (index) => LBPageGenerator.generate(stack[index])),
      onPopPage: onPopPage,
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    stack.add(configuration);
    notifyListeners();
    return SynchronousFuture(null);
  }

  bool onPopPage(Route route, dynamic result) {
    return route.didPop(result);
  }
  
}