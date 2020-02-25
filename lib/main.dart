import 'package:event_proposal_admin/choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Map<int, Color> color =
{
50:Color.fromRGBO(38,72,85, .1),
100:Color.fromRGBO(38,72,85, .2),
200:Color.fromRGBO(38,72,85, .3),
300:Color.fromRGBO(38,72,85, .4),
400:Color.fromRGBO(38,72,85, .5),
500:Color.fromRGBO(38,72,85, .6),
600:Color.fromRGBO(38,72,85, .7),
700:Color.fromRGBO(38,72,85, .8),
800:Color.fromRGBO(38,72,85, .9),
900:Color.fromRGBO(38,72,85, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFFF3345 , color);


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
      return MaterialApp(
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      debugShowCheckedModeBanner: false,
      home: Main(),//Executing main screen.
    );
  }
}



