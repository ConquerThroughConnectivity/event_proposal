import 'package:event_proposal_admin/Approvers/Home/Home.dart';
import 'package:event_proposal_admin/SAO/utilities/loading.dart';

import 'package:event_proposal_admin/choose.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_particles/particles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_button/progress_button.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isload =false;
bool isSee =true;
final TextEditingController schoolID = new TextEditingController();
final TextEditingController password = new TextEditingController();
TextEditingController inchargeName = new TextEditingController();



class LoginApprover extends StatefulWidget {
  LoginApprover({Key key}): super(key: key);
  @override
  _LoginApproverState createState() => _LoginApproverState();
}

class _LoginApproverState extends State<LoginApprover> {
  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return WillPopScope(
      child:Scaffold(
      appBar: AppBar(
        title: Text('Event Proposal Approvers', style: TextStyle(
            fontFamily: "Mops",
            fontSize: ScreenUtil.instance.setSp(25),
            color: Colors.white
          )),
        centerTitle: true,
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
            Particles(30, Color(0xFFFF3345)),
         
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
                elevation: 15.5,
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
                            setState(() {
                              isload =true;
                            });
                            FirebaseDatabase.instance.reference().child("User").child("Approver").orderByChild("id").equalTo(schoolID.text)
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
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>HomeApprovers(id: values["id"],), fullscreenDialog: true));
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
                    // child:  Text('Login Organization Dean',
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
              //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeanLogin(), fullscreenDialog: true));
              //     });
              //   }, 
              //   child: Text('Click Here',
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
    onWillPop: ()async => false,
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
}