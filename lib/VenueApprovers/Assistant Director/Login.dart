import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/VenueApprovers/Assistant%20Director/Home.dart';
import 'package:event_proposal_admin/choose.dart';
import 'package:event_proposal_admin/republicAct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_button/progress_button.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isload =false;
bool isSee =true;
final TextEditingController schoolID = new TextEditingController();
final TextEditingController password = new TextEditingController();

class LoginVenueApprovers extends StatefulWidget {
  @override
  _LoginVenueApproversState createState() => _LoginVenueApproversState();
}

class _LoginVenueApproversState extends State<LoginVenueApprovers> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);


     return WillPopScope(
       child:Scaffold(
         appBar:AppBar(
           centerTitle: true,
        elevation: 4.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Main(), fullscreenDialog: true));
          }
          ),
        ),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
      body: Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
            child: Text('Venue Approvers', style: TextStyle(
            fontFamily: "Mops",
            fontSize: ScreenUtil.instance.setSp(25),
            color: Colors.black
          )),
          ),
            ),
          SingleChildScrollView(
            child: Form(
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
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(30.0), right: ScreenUtil.instance.setWidth(30.0), left: ScreenUtil.instance.setWidth(30.0)),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[1234567890]")),
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
                          LengthLimitingTextInputFormatter(25),
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
                            setState(() {
                              isload =true;
                            });
                            FirebaseDatabase.instance.reference().child("User").child("VenueApprovers").orderByChild("id").equalTo(schoolID.text)
                            .once().then((DataSnapshot snapshot) async{
                              Map<dynamic, dynamic> values =await snapshot.value;
                              if(values==null){
                                setState(() {
                                  isload =false;
                                  popupInvalid("School-ID Not registered");
                                });
                              }else{
                                values.forEach((key,values){
                                  if(values["id"]==schoolID.text && values["password"]==password.text){
                                    setState(() {
                                    isload =false;
                                    print(values["id"]);
                                    schoolID.clear();
                                    password.clear();
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeVenueApprover(id: values["id"].toString(),), fullscreenDialog: true));
                                  });
                                  }else{
                                  setState(() {
                                    isload =false;
                                    popupInvalid("Invalid Credentials");
                                  });
                                  }
                                });
                              }

                            });
                            
                          
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
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                    // Padding(
                    // padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(100),),
                    // child:  Text('Do you have an Account in Organization? if not ',
                    //   style: TextStyle(
                    //   fontFamily: "Mops",
                    //   fontSize: ScreenUtil.instance.setSp(20.0),
                    //   color: Colors.white,
                    //   fontWeight: FontWeight.w300,
                    //   )),  
                    // ),
                ],
              ),
              // FlatButton(
              //   onPressed: (){
              //     setState(() {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => SignupOrganization(), fullscreenDialog: true));
              //     });
              //   }, 
              //   child: Text('Register Here',
              //         style: TextStyle(
              //         fontFamily: "Mops",
              //         fontSize: ScreenUtil.instance.setSp(18.0),
              //         color: Colors.lightBlueAccent,
              //         fontWeight: FontWeight.w200,
              //         )),  
              //   ),
          ],
        ),
    ),
    ), 
     onWillPop: () async => false);
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
}