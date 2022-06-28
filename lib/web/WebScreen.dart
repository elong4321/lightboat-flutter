import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lightboat/navigation/UriDecorator.dart';
import 'package:lightboat/widget/search/SearchBar.dart';
import 'package:lightboat/widget/search/WebSearchBar.dart';

import '../System.dart';
import '../main.dart';
import 'HttpProtocol.dart';

class WebPage extends Page {
  static const NAME = "Web";
  String url;

  WebPage(this.url): super(key: ValueKey(NAME), name: NAME);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) => WebScreen(url),
    );
  }

}

class WebScreen extends StatefulWidget {
  String initialUrl;

  WebScreen(this.initialUrl);

  @override
  State<StatefulWidget> createState() => _WebScreenState();

}

class _WebScreenState extends State<WebScreen> {
  ValueNotifier<String>? _urlNotifier;
  InAppWebViewController? webViewController;
  _WebSearchBarBehaviour? behaviour;

  @override
  void initState() {
    super.initState();
    _urlNotifier = ValueNotifier(widget.initialUrl);
    behaviour = _WebSearchBarBehaviour();
    behaviour?.controller = TextEditingController(text: _urlNotifier?.value);
  }

  @override
  Widget build(BuildContext context) {
    double width = System.width;
    double searchBarHeight = 40;
    return BackButtonListener(
        onBackButtonPressed: onWillPop,
        child: SafeArea(child: Column(
          children: [
            SizedBox(
              width: width,
              height: searchBarHeight,
              child: WebSearchBar(behaviour!),
            ),
            Expanded(child: InAppWebView(
              initialUrlRequest: URLRequest(url: UriDecorator.parseUriStr(_urlNotifier!.value), method: HttpProtocol.GET),
              onWebViewCreated: onWebViewCreated, onLoadStop: onLoadStop,),
            ),
          ],
        )),
    );
  }

  void onWebViewCreated(InAppWebViewController controller) {
    this.webViewController = controller;
    behaviour?.webViewController = webViewController;
  }

  void onLoadStop(InAppWebViewController controller, Uri? url) {
    String urlStr = UriDecorator.unwrapTitle(url!);
    print("onLodStop: $urlStr ${url!.authority}");
    behaviour?.controller.text = urlStr;
    app.storage.saveHistory(urlStr);
  }

  Future<bool> onWillPop() async {
    print("onWillPop ${webViewController?.canGoBack()}");
    if (await webViewController?.canGoBack() ?? false) {
      await webViewController?.goBack();
      return true;
    } else {
      return false;
    }
  }
}

class _WebSearchBarBehaviour extends SearchBarBehaviour {
  InAppWebViewController? webViewController;

  @override
  void onSubmit(String value) {
    webViewController?.loadUrl(urlRequest: URLRequest(url: UriDecorator.parseUriStr(value)));
  }
}