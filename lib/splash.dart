import 'dart:async';

import 'package:event_proposal_admin/choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {




  @override
  void initState() {
   
    super.initState();
    Timer(Duration(seconds: 5), () =>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Main(), fullscreenDialog: true)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 26, 50, 1),
      body: Container(
      child: Column(
       children: <Widget>[
         Padding(
           padding: EdgeInsets.only(top: 150),
           child: Center(
          child: Container(
            child: Image.asset('lib/assets/UElogo.png', fit: BoxFit.fill,),
          ),
         ),
      ),
      Padding(
           padding: EdgeInsets.only(top: 100),
           child: Center(
          child: Text("University of The East", style: TextStyle(
            fontFamily: "Montserrat",
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w100
          ),),
         ),
      ),
       Padding(
           padding: EdgeInsets.only(top: 200),
           child: Center(
          child: SpinKitCubeGrid(
             color: Colors.white,
             size: 110.0,
          ),
         ),
      ),
          
       ],

      ),
    ),
    );
  }
}
