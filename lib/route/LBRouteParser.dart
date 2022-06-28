import 'package:flutter/material.dart';

class LBRouteParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    return Future.value(routeInformation!.location);
  }
}