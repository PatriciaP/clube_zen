library modal_progress_hud;
import 'package:clubezen/view/splash.dart';
import 'package:clubezen/view/web_view_container.dart';
import 'package:flutter/material.dart';

class ProgressHUD extends StatelessWidget {

  final Widget child;
  final bool inAsyncCall;
  final bool connection;
  final double opacity;
  final Color color;
  final Color colorBack = Color.fromRGBO(0, 178, 180, 1);
  final Animation<Color> valueColor;


  ProgressHUD({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    @required this.connection,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall && connection ) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(
            child: Splash(),
          ),
        ],
      );
      widgetList.add(modal);
    }
    if(connection){
      return Stack(
        children: widgetList,
      );
    } else {
      final modal = new Stack(
        children: [
          new Center(
              child: _showDialog(context)
          ),
        ],
      );
      widgetList.add(modal);
      return Stack(
        children: widgetList,
      );
    }

  }

  Widget _showDialog(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              child: new Column(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.topCenter,
                    child: new Image.asset(
                      'assets/clubezen.png',
                      height: 100.0,
                      fit: BoxFit.fill,
                    ) ,
                  ),
                new Container(
                  padding: new EdgeInsets.only(left: 20,top: 10, right: 0, bottom: 20),
                  alignment: Alignment.center,
                  child: new Text(
                    "Sem conexão com a Internet, verifique a conexão e atualize!",
                    style: TextStyle(color:  Color.fromRGBO(0, 178, 180, 1),
                        fontSize: 20),
                  ),
                ),
                  new Container(
                      alignment: Alignment.center,
                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WebViewContainer()),
                          );
                        },
                        color: Color.fromRGBO(0, 178, 180, 1) ,
                        child: const Text(
                            'Atualizar',
                            style: TextStyle(color: Colors.white, fontSize: 20)
                        ),
                      ),),
                ],
              ))),
    );


  }





}