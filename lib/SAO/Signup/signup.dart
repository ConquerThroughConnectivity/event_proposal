
import 'package:event_proposal_admin/SAO/provider/firebaseProvider.dart';
import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_button/progress_button.dart';


final TextEditingController password = new TextEditingController();
final TextEditingController firstname = new TextEditingController();
final TextEditingController middlename = new TextEditingController();
final TextEditingController lastname = new TextEditingController();
final TextEditingController schoolID = new TextEditingController();
final key = GlobalKey<FormState>();



final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;

bool isload=false;
Auth auth = new Auth();
class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {




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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            setState(() {
            Navigator.pop(context);
          });
          }),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor:Color(0xFF264855) ,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: key,
                    child: Card(
                      margin: EdgeInsets.only(
                          left: ScreenUtil.instance.setWidth(20.0),
                          right: ScreenUtil.instance.setWidth(20.0),
                          top: ScreenUtil.instance.setWidth(10.0),
                          bottom: ScreenUtil.instance.setWidth(5.0)),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: Padding(
                        padding:
                            EdgeInsets.all(ScreenUtil.instance.setWidth(25.0)),
                        child: Column(
                          children: <Widget>[
                        TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: schoolID,
                        keyboardType: TextInputType.number,
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
                        textInputAction: TextInputAction.done,
                        controller: password,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          else if(val.length <6){
                            return 'Must be 6 characters long';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val =password.text;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                        Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: firstname,
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val =firstname.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Firstname",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.face),
                          
                        ),
                      ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: middlename,
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val =middlename.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Middlename",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.face),
                          
                        ),
                      ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: lastname,
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val =lastname.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Lastname",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.face),
                          
                        ),
                      ), 
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      ProgressButton(
                      buttonState: ButtonState.inProgress,
                      child: isload ? Loading() : Text('Register', style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Mops",
                        fontSize: ScreenUtil.instance.setSp(20),
                        ),
                        ),
                      backgroundColor: Color(0xFF264855), 
                      onPressed: () async {
                        //Signup Register
                        final form =key.currentState;
                        if(form.validate()){
                          form.save();
                          setState(() {
                            isload =true;
                          });
                        //  FirebaseDatabase.instance.reference().child("User").child("Sao").orderByChild("id").equalTo(schoolID.text)
                        //  .once().then((DataSnapshot snapshots) async { 
                        //    Map<dynamic, dynamic> values =snapshots.value;
                        //    if(values==null){
                        //       setState(() {
                        //       isload=false;
                        //      });
                        //        final DatabaseReference account =FirebaseDatabase.instance.reference().child("User").child("Sao");
                        //           setState((){
                        //           popupInvalid("Great you can now Login", "Sucess");
                        //           account.child(schoolID.text).set({
                        //           'firstname': firstname.text,
                        //           'middlename': middlename.text,
                        //           'lastname': lastname.text,
                        //           'id': schoolID.text,
                        //           'password': password.text, 
                        //           });
                        //           isload =false;
                        //           });
                                  
                        //    }else{
                        //      values.forEach((key,values){
                        //      setState(() {
                        //       isload =false;
                        //       popupInvalid("School-ID already taken", "Warning");
                        //      });
                             
                        //    });
                        //    }
                           
                        //  });
                          
                        FirebaseDatabase.instance.reference().child("User").child("Sao").child(schoolID.text).set({
                                  'firstname': firstname.text,
                                  'lastname': lastname.text,
                                  'id': schoolID.text,
                                  'password': password.text, 
                        });
                         
                        }
                        
                      }
                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ],
      ),
      
    ), 
   onWillPop: () async =>false
   );
  }


Widget appbar(){
  return AppBar(
    backgroundColor: Color(0xFF264855),
    elevation: 0.0,
    leading: IconButton(
    padding: EdgeInsets.only(bottom: ScreenUtil.instance.setWidth(530)),
    icon: Icon(Icons.arrow_back, color: Colors.white,), 
    onPressed:()=> Navigator.pop(context)
      ),
  );
}



void popupInvalid(String message, String warning) {
    Flushbar(
      title: warning,
      messageText: Text(
        message,
        style: TextStyle(fontSize: 17.0, color: Colors.white),
      ),
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.easeInOutExpo,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.white,
      shouldIconPulse: true,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      isDismissible: true,
      icon: Icon(
        Icons.error,
        size: 30.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: 4),
    )..show(context);
  }

 
}