import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  final String title;
  ArticleView({this.blogUrl, this.title});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();

  int position = 0;
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A){
    setState(() {
      position = 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:     AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(child: Container(child: Text(widget.title))),
        ],
      ),
      elevation: 0.0,
    ),
      body:  IndexedStack(
        index: position,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:  WebView(

              initialUrl: widget.blogUrl ,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: startLoading,
              onPageFinished: doneLoading,
              onWebViewCreated: (WebViewController webViewController){
                _completer.complete(webViewController);
              },
            ),
          ),
           Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        ]
      ),
      
    );
  }
}
