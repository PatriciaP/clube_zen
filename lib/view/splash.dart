import 'package:clubezen/view/web_view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebViewContainer()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Color.fromRGBO(0,178,180,1),
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            child: Image.asset("assets/clubezenbranco.png"),
          ),
        )
    );
  }
}