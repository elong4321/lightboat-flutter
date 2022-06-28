import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lightboat/home/HomeScreen.dart';
import 'package:lightboat/route/LBRouterDelegate.dart';
import 'package:lightboat/web/WebScreen.dart';
import 'package:provider/provider.dart';

import 'PagesModel.dart';
import 'AppState.dart';

GlobalKey routeKey = GlobalKey(debugLabel: "route");

AppState app = AppState();

void main() {
  app.routerDelegate.setInitialRoutePath('/');
  runApp(const LightboatApp());
}

class LightboatApp extends StatefulWidget {
  const LightboatApp({super.key});

  @override
  State<StatefulWidget> createState() => LightboatAppState();
}

class LightboatAppState extends State<LightboatApp> {

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: app.routeParser,
      routerDelegate: app.routerDelegate,
    );
  }

}

bool onPopPage(Route route, dynamic result) {
  if (route is WebPage) {

  }
  return route.didPop(result);
}

