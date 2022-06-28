import 'package:flutter/material.dart';
import 'package:lightboat/main.dart';
import 'package:lightboat/widget/search/SearchBar.dart';

import '../../history/HistoryDropDown.dart';

class HomeSearchBar extends StatefulWidget {
  Key? key;
  SearchBarBehaviour? behaviour;
  HomeSearchBar({this.key, this.behaviour}): super(key: key);

  createState() => _HomeSearchBarState(behaviour: behaviour);
}

class _HomeSearchBarState extends SearchBarState<HomeSearchBar> with SingleTickerProviderStateMixin {
  double smallWidth = 200, bigWidth = 300;
  int animtionTime = 100;
  final GlobalKey? searchBarKey = GlobalKey(debugLabel: "homeSearchBar");
  List<String>? histories = null;
  late AnimationController animationController;
  late Animation<double> tween;
  OverlayEntry? historiesDropdown;

  _HomeSearchBarState({SearchBarBehaviour? behaviour}): super(behaviour: behaviour);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: animtionTime), vsync: this);
    tween = Tween<double>(begin: 0, end:1).animate(animationController);
    animationController.addStatusListener(onAnimationStatus);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (behaviour.focusNode.hasFocus && animationController.status == AnimationStatus.dismissed ||
        !behaviour.focusNode.hasFocus && animationController.status == AnimationStatus.completed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (behaviour!.focusNode.hasFocus) {
          animationController.forward(from: animationController.value);
        } else {
          animationController.reverse(from: animationController.value);
        }
      });
    }
    double height = 40;
    return AnimatedBuilder(
        animation: tween,
        builder: (context, child) {
          return Container(
              key: searchBarKey,
              height: height, width: smallWidth + tween.value * (bigWidth - smallWidth),
              alignment: Alignment.center, child: child);
        },
        child:TextField(
          controller: behaviour.controller,
          maxLines: 1,
          style: TextStyle(fontSize: 12),
          decoration: _HomeSearchInputDecoration(height / 2, hasFocus()),
          focusNode: behaviour.focusNode,
          onChanged: behaviour.onChange,
          onSubmitted: behaviour.onSubmit,
        ),
    );
  }

  void triggerHistory() async {
    if (searchBarKey != null && searchBarKey?.currentContext != null) {
      if (behaviour.focusNode.hasFocus) {
        if (historiesDropdown == null) {
          Offset? offset = null;
          RenderObject? object = searchBarKey?.currentContext
              ?.findRenderObject();
          RenderBox? box = object != null ? object as RenderBox : null;
          if (box != null) {
            offset = box.localToGlobal(Offset.zero);
            Size size = box.size;
            offset = Offset(offset.dx, offset.dy + size.height + 10);
          }
          if (offset != null) {
            List<String> histories = await app.histories;
            OverlayState overlayState = Overlay.of((searchBarKey?.currentContext)!)!;
            historiesDropdown =
                OverlayEntry(builder: (context) =>
                    HistoryDropDown(histories, width: bigWidth, offset: offset,));
            overlayState.insert(historiesDropdown!);
          }
        }
      } else {
        if (historiesDropdown != null) {
          historiesDropdown?.remove();
          historiesDropdown = null;
        }
      }
    }
  }

  void onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      triggerHistory();
    }
  }

  bool hasFocus() {
    return behaviour.focusNode.hasFocus;
  }
}

class _HomeSearchInputDecoration extends InputDecoration {
  _HomeSearchInputDecoration(double radius, bool focused): super(
    filled: true,
    fillColor: focused ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.4),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
        borderRadius: BorderRadius.circular(radius)
    ),
  );
}