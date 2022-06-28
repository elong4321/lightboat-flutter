import 'package:flutter/material.dart';
import 'package:lightboat/navigation/UriNavigator.dart';

abstract class SearchBarState<T extends StatefulWidget> extends State<T> {
  late SearchBarBehaviour behaviour;

  SearchBarState({SearchBarBehaviour? behaviour}) {
    this.behaviour = behaviour ?? SearchBarBehaviour();
  }

}

class SearchBarBehaviour {
  String input = '';
  TextEditingController? _controller = null;
  FocusNode? _focusNode = null;

  SearchBarBehaviour();

  void onChange(String value) {
    input = value;
  }

  void onSubmit(String value) {
    input = value;
    search();
  }

  void search() {
    UriNavigator.goto(Uri.parse(input));
  }

  FocusNode get focusNode {
    _focusNode ??= FocusNode();
    return _focusNode!;
  }

  set focusNode(value) {
    _focusNode = value;
  }

  TextEditingController get controller {
    _controller ??= TextEditingController();
    return _controller!;
  }

  set controller(value) {
    _controller = value;
  }
}