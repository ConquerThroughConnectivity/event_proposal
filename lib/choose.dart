import 'package:event_proposal_admin/Approvers/Login/Login.dart';
import 'package:event_proposal_admin/Dean/Login.dart';
import 'package:event_proposal_admin/Organization/Login/Login.dart';
import 'package:event_proposal_admin/SAO/Login/login.dart';
import 'package:event_proposal_admin/SAO/Signup/signup.dart';
import 'package:event_proposal_admin/Venue/Login/Login.dart';
import 'package:event_proposal_admin/VenueApprovers/Assistant%20Director/Login.dart';
import 'package:event_proposal_admin/republicAct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_particles/particles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:panorama/panorama.dart';
import 'package:spring_button/spring_button.dart';


final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  
  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
    width: defaultScreenWidth,
    height: defaultScreenHeight,
    allowFontScaling: true,

    )..init(context);
    
    return WillPopScope(
    child: Scaffold(
      backgroundColor: Color(0xFFFF3345),
    body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
       
        Container(
            child:Panorama(
            interactive: true,
            animReverse: true,
            animSpeed: 2.0,
            minLongitude: 4.0,
            maxLongitude: 100.0,
            child: Image.asset("lib/assets/background.jpeg"),
            ),
            ),
        Padding(
          padding: EdgeInsets.only(bottom: ScreenUtil.instance.setWidth(250), left:ScreenUtil.instance.setWidth(20), right: ScreenUtil.instance.setWidth(20) ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('lib/assets/logo.png'), 
                fit: BoxFit.fitWidth,
                ),
            ),
          ),
        ),
        Center(
          child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(280)),
          child: SpringButton(
        SpringButtonType.OnlyScale,
        cardLogin('Login-As', context, Colors.white),
        onTapDown: (_) {},
        onLongPressEnd: (_) {},
        onTap: () {
          setBottomSheet(context);
        },
        ),
          ),
        ),
        Center(
          child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(480)),
          child: Text("Automated Event Proposal Management System for Recognized Student Organization",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Mops",
            fontSize: 25.0,
            fontWeight: FontWeight.w100,
            color: Colors.white
          ),
          ),
          ),
        ),
      ],
    ),
  
    ),
    onWillPop: ()  async=> false
    
    );

    
    
  }
  void setBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          width: 450,
          color: Color(0xFF121621),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: ScreenUtil.instance.setWidth(20)),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                         SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Organization Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginOrganization(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Student Affairs Office Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginSao(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Organization Approvers Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginApprover(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Venue Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginVenue(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Organization Dean', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DeanLogin(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Venue Approver Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginVenueApprovers(), fullscreenDialog: true));
                                },
                                ),
                        ],
                      ),
                      ),
                    ),
                  )
                ],
              )),
        );
      });
}

Widget card(String title, BuildContext context, Color color) {
  return Stack(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20, bottom: 20),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: ScreenUtil.instance.setWidth(380),
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              
              fontFamily: 'Mops',
              fontWeight: FontWeight.w200),
        ),
      ),
      Positioned(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child:  Align(
                alignment: Alignment.topLeft,
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  height: 20,
                  width: 30,
                )),
          
        ),
      ),
    ],
  );

}
Widget cardLogin(String title, BuildContext context, Color color) {
  return Stack(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20, bottom: 20),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: ScreenUtil.instance.setWidth(280),
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              
              fontFamily: 'Mops',
              fontWeight: FontWeight.w200),
        ),
      ),
      Positioned(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child:  Align(
                alignment: Alignment.topLeft,
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  height: 20,
                  width: 30,
                )),
          
        ),
      ),
    ],
  );

}
  
}