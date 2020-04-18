import 'dart:async';
import 'dart:io';

import 'package:clubezen/util/progress_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewContainer extends StatefulWidget {
    @override
    createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> with WidgetsBindingObserver {

    var _url = "https://parceiros.clubezen.com.br/controle/";

    //final _key = UniqueKey();
    bool _isLoadingPage;
    bool _connection = true;


    Completer<WebViewController> _controller = Completer<WebViewController>();


    @override
    void initState() {
        super.initState();

        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        WidgetsBinding.instance.addObserver(this);
        _checkConnection();


        _isLoadingPage = true;
    }


    _checkConnection() {

        Timer.run(() {
            try {
                InternetAddress.lookup('google.com').then((result) {
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                        print('connected');
                        setState(() {
                            _connection = true;
                        });
                    } else {
                        setState(() {
                            _connection = false;

                        });
                    }
                }).catchError((error) {
                    setState(() {
                        _connection = false;
                    });                });
            } on SocketException catch (_) {
                setState(() {
                    _connection = false;
                    _isLoadingPage = true;

                });                print('not connected'); // show dialog
            }
        });


    }

    Widget _showDialog() {

        // dialog implementation
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text("Sem conexão"),
                content: Text("Necessário conexão com a Internet!"),
                actions: <Widget>[FlatButton(child: Text("Atualizar"),
                    onPressed: () {
                    setState(() {
                        _isLoadingPage = true;
                    });
                    })],
            ),
        );
    }

    @override
    void dispose() {
        WidgetsBinding.instance.removeObserver(this);

        super.dispose();
    }


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Color.fromRGBO(0, 178, 180, 1),
            ),
            //corpo da aplicação, aqui são setadas as telas
            body: ProgressHUD(
                child: Center(
                    child: WebView(
                        //key: _key,
                        initialUrl: _url,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (
                            WebViewController webViewController) {
                            _controller.complete(webViewController);
                        },
                        onPageFinished: (finish) {
                            setState(() {
                                _isLoadingPage = false;
                            });
                        },
                    ),
                ),
                connection: _connection,
                inAsyncCall: _isLoadingPage,
                opacity: 0.0,
            ),
            backgroundColor: Colors.white,
        );


    }


    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {

        if (state == AppLifecycleState.inactive) {
            setState(() {
                _isLoadingPage = true;
            });
        } if (state == AppLifecycleState.paused) {
            setState(() {
                _isLoadingPage = true;
            });
        }
    }
}