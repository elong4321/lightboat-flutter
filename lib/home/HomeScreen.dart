import 'package:flutter/material.dart';
import 'package:lightboat/history/HistoryDropDown.dart';
import 'package:lightboat/widget/search/SearchBar.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'Wallpaper.dart';

import '../widget/search/HomeSearchBar.dart';

class HomePage extends Page {
  static String NAME = "home";

  HomePage(): super(key: ValueKey(NAME), name: NAME);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) {
          return HomeScreen();
        });
  }
  
}

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SearchBarBehaviour? searchBarBehaviour;

  _HomeScreenState() {
    searchBarBehaviour = SearchBarBehaviour();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child:ChangeNotifierProvider<FocusNode>.value(
          value:searchBarBehaviour!.focusNode,
          child: Consumer<FocusNode>(
            builder: (context, node, widget){
              return GestureDetector(onTap:_onBlankTap, child:Stack(
                children: [
                  WallPaper(status: node.hasFocus ? WallPaper.BLURRED : WallPaper.NOMARL),
                  Center(child: HomeSearchBar(behaviour: searchBarBehaviour,),)
                ],
              ));
            },
          ),
        )
    );
  }

  void _onBlankTap() {
    FocusNode focusNode = searchBarBehaviour!.focusNode;
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

}

