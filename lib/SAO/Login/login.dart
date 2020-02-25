
import 'package:event_proposal_admin/Approvers/Signup/Signup.dart';
import 'package:event_proposal_admin/Organization/Signup/Signup.dart';
import 'package:event_proposal_admin/SAO/Home/home.dart';
import 'package:event_proposal_admin/SAO/Signup/signup.dart';
import 'package:event_proposal_admin/SAO/provider/firebaseProvider.dart';
import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/Venue/Signup/Signup.dart';
import 'package:event_proposal_admin/choose.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_button/progress_button.dart';
import 'package:spring_button/spring_button.dart';



final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isload =false;

final TextEditingController schoolID = new TextEditingController();
final TextEditingController password = new TextEditingController();
final formkey = GlobalKey<FormState>();
Auth auth = new Auth();

bool isSee =true;

class LoginSao extends StatefulWidget {
  LoginSao({Key key}) : super(key: key);

  @override
  _LoginSaoState createState() => _LoginSaoState();
}



class _LoginSaoState extends State<LoginSao> {



  @override
  void initState() {
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    
      return WillPopScope(child:Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Main(), fullscreenDialog: true));
          }
          ),
        ),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
      body: Container(
      padding: EdgeInsets.only(top: 70),
        color: Colors.white,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
            Center(
            child: Text('Event Proposal Sao Director', style: TextStyle(
            fontFamily: "Mops",
            fontSize: ScreenUtil.instance.setSp(25),
            color: Colors.black
          )),
          ),
          SingleChildScrollView(
            child: Form(
            key: formkey,
            child: Card(
              margin: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(20.0),
                right: ScreenUtil.instance.setWidth(20.0),
                top: ScreenUtil.instance.setWidth(40.0),
                bottom: ScreenUtil.instance.setWidth(5.0),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 15.5,
                child: Padding(
                  padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(30.0), right: ScreenUtil.instance.setWidth(30.0), left: ScreenUtil.instance.setWidth(30.0)),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z-1234567890]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        textInputAction: TextInputAction.done,
                        controller: schoolID,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val =schoolID.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "School ID",
                          focusColor: Colors.white,
                          hintText: "114570",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.school),
                          
                        ),
                      ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z-1234567890]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        textInputAction: TextInputAction.done,
                        controller: password,
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val =password.text;
                          });
                        },
                        obscureText: isSee,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          suffixIcon: new GestureDetector(
                            onTap: (){
                              setState(() {
                                isSee = !isSee;
                              });
                            },
                            child: Icon(isSee ?Icons.visibility: Icons.visibility_off),
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      ProgressButton(
                      buttonState: ButtonState.inProgress,
                      child: isload ? Loading() : Text('Login', style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Mops",
                        fontSize: ScreenUtil.instance.setSp(20),
                        ),
                        ),
                      backgroundColor: Color(0xFFFF3345), 
                      onPressed: () async {
                          final form =formkey.currentState;
                          if(form.validate()){
                            form.save();
                            setState(() {
                              isload =true;
                            });
                            FirebaseDatabase.instance.reference().child("User").child("Sao").orderByChild("id").equalTo(schoolID.text)
                            .once().then((DataSnapshot snapshot) async{
                              Map<dynamic, dynamic> values =await snapshot.value;
                              if(values==null){
                                setState(() {
                                  isload =false;
                                  popupInvalid("School-ID Not registered");
                                  //Check if School ID exit
                                });
                              }else{
                                values.forEach((key,values){
                                  if(values["id"]==schoolID.text && values["password"]==password.text){
                                    setState(() {
                                    isload =false;
                                    print(values["id"]);
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home(id: values["id"].toString(),), fullscreenDialog: true));
                                    //navigate to home screen
                                  });
                                  }else{
                                  setState(() {
                                    isload =false;
                                    popupInvalid("Invalid Credentials");
                                    //Check if school id and password match.
                                  });
                                  }
                                });
                              }

                            });
                            
                          }
                      }
                      ),
                    Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                    ],
                  ),
                  ),
            ),
            ),
          ),
            Padding(padding: EdgeInsets.only(top:ScreenUtil.instance.setWidth(20))),
              
              
            
          ],
        ),
    ),
    ), 
      onWillPop: () async => false,
      );
  }
  void popupInvalid(String message) {
    Flushbar(
      title: 'Warning',
      messageText: Text(
        message,
        style: TextStyle(fontSize: 17.0, color: Colors.white),
      ),
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.easeInOutExpo,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Color(0xFFFF3345),
      shouldIconPulse: true,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      isDismissible: true,
      icon: Icon(
        Icons.error,
        size: 30.0,
        color: Color(0xFFFF3345),
      ),
      duration: Duration(seconds: 4),
    )..show(context);
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
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.bold),
        ),
      ),
      Positioned(
        top: -15,
        left: -20,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: ClipRRect(
            borderRadius: BorderRadius.only(),
            child: Align(
                alignment: Alignment.topLeft,
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  height: 20,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(0.0),
                      )),
                )),
          ),
        ),
      ),
    ],
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
                                card('Organization Account', context, Color(0xFF264855)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignupOrganization(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Approvers Account', context, Color(0xFF264855)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  ApproverSignup(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Venue Account', context, Color(0xFF264855)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignupVenue(), fullscreenDialog: true));
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
}








