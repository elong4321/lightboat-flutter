import 'package:flutter/material.dart';
import 'package:lightboat/widget/search/SearchBar.dart';

import '../../System.dart';

class WebSearchBar extends StatefulWidget {
  SearchBarBehaviour behaviour;

  WebSearchBar(this.behaviour);

  @override
  createState() => _WebSearchBarState(behaviour: behaviour);
}

class _WebSearchBarState extends SearchBarState<WebSearchBar> {

  _WebSearchBarState({SearchBarBehaviour? behaviour = null}): super(behaviour: behaviour);

  @override
  Widget build(BuildContext context) {
    Navigator navigator;
    return Material(
        child: TextField(
          controller: behaviour.controller,
          maxLines: 1,
          style: TextStyle(fontSize: 12),
          decoration: _WebSearchInputDecoration(),
          focusNode: behaviour.focusNode,
          onChanged: behaviour.onChange,
          onSubmitted: behaviour.onSubmit,
        )
    );
  }
}

class _WebSearchInputDecoration extends InputDecoration {
  _WebSearchInputDecoration(): super(
    filled: true,
    fillColor: Colors.white.withOpacity(0.6),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
      borderRadius: BorderRadius.circular(2),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
        borderRadius: BorderRadius.circular(2)
    ),
  );
}