import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';

class WebviewLogin extends StatefulWidget {
  final String server;
  WebviewLogin(this.server);

  @override
  createState() => new WebviewLoginState(server);
}

class WebviewLoginState extends State<WebviewLogin> {
  final String server;
  WebviewLoginState(this.server);

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  final _history = [];

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: server,
      appBar: new AppBar(
        title: new Text("Login to tranSMART"),
      ),
      withZoom: true,
      withJavascript: true,
      withLocalStorage: true,
    );
  }

  @override
  initState() {
    super.initState();
    debugPrint("InitState");

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      if (mounted) {
        debugPrint("Webview Destroyed");
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add("onUrlChanged: $url");
          debugPrint("onUrlChanged: $url");
          var uri = Uri.dataFromString(url);
          if (uri.hasQuery) {
            var parameters = uri.queryParameters;
            debugPrint(parameters.toString());
            if (parameters.containsKey('code')) {
              debugPrint("Code: " + parameters['code']);
              Navigator.pop(context, parameters["code"]);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    debugPrint("dispose");

    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();

    flutterWebviewPlugin.dispose();

    super.dispose();
  }
}
