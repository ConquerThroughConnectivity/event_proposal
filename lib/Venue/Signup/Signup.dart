import 'package:event_proposal_admin/DropDown.dart';
import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/republicAct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_button/progress_button.dart';
import 'package:sweetalert/sweetalert.dart';

final TextEditingController password = new TextEditingController();
final TextEditingController schoolID = new TextEditingController();
final TextEditingController firstname = new TextEditingController();
final TextEditingController middlename = new TextEditingController();
final TextEditingController lastname = new TextEditingController();
String venueType;
String venType;

String venuename;
String venname;
final key = GlobalKey<FormState>();

bool isEnable =false;
bool isSee =true;
final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isload=false;
List<dynamic> result;
var cas;
class SignupVenue extends StatefulWidget {
  @override
  _SignupVenueState createState() => _SignupVenueState();
}

class _SignupVenueState extends State<SignupVenue> {

  @override
  void initState() {
    venuename ="";
    venname ="";

    venueType ="";
    venType ="";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Venue Signup', style: TextStyle(
          color: Colors.white,
          fontFamily: "Mops",
          fontWeight: FontWeight.w200,
          fontSize: 30.0
        ),),
        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white,), 
        onPressed:(){
          setState(() {
            isEnable =false;
          });
          Navigator.pop(context);
        },
      ),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor:Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RepublicAct(),
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
                      elevation: 15.5,
                      child: Padding(
                        padding:
                            EdgeInsets.all(ScreenUtil.instance.setWidth(20.0)),
                        child: Column(
                          children: <Widget>[
                        TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: schoolID,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[1234567890]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          if(val.length <4){
                             return 'Lenght Must Be 4 or higher';
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
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z-1234567890]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
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
                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
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
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
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
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z]")),
                          LengthLimitingTextInputFormatter(20),
                        ],
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
                      AbsorbPointer(
                        absorbing: isEnable,
                        child: DropDownFormField(
                        titleText: "In-Charge Type",
                        hintText: "Select In-Charge Type",
                        value: venueType,
                        validator: (value){
                          if(value==null){
                            return "Required Field";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            venueType =value;
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            venueType =value;
                          });
                        },
                        textField: "display",
                        valueField: "value",
                        dataSource: [
                          {
                            "display": "ESO",
                            "value": "ESO"
                          },
                          {
                            "display": "Information Technology",
                            "value": "Information Technology"
                          },
                          {
                            "display": "Library Head",
                            "value": "Library Head"
                          },
                          {
                            "display": "Engineering",
                            "value": "Engineering"
                          },
                          
                         
                        ],
                      ),
                      ),
                      
                      // DropDownFormField(
                      //   titleText: "Venue Name",
                      //   hintText: "Select Venue Name",
                      //   value: venuename,
                      //   validator: (value){
                      //     if(value==null){
                      //       return "Required Field";
                      //     }
                      //   },
                      //   onChanged: (value){
                      //     setState(() {
                      //       venuename =value;
                      //     });
                      //   },
                      //   onSaved: (value){
                      //     setState(() {
                      //       venuename =value;
                      //     });
                      //   },
                      //   textField: "display",
                      //   valueField: "value",
                      //   dataSource: result==null?[
                      //     {
                      //       "display":"Please Select Organization Type",  
                      //     }
                      //   ] :result,
                      // ),
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
                      backgroundColor: Color(0xFFFF3345), 
                      onPressed: () async {
                        //Signup Register
                        final form =key.currentState;
                        if(form.validate()){
                          form.save();
                          setState(() {
                            venType =venueType;
                            venname =venuename;
                            isload =true;
                          });

                         FirebaseDatabase.instance.reference().child("User").child("Venue").orderByChild("id").equalTo(schoolID.text)
                         .once().then((DataSnapshot snapshots) async { 
                           Map<dynamic, dynamic> values =snapshots.value;
                           if(values==null){
                              setState(() {
                              isload=false;
                                 isEnable =false;
                             });
                               FirebaseDatabase.instance.reference().child("User").child("VenueApprovers").child(schoolID.text).set({
                                  'org_type': venType,
                                  'id': schoolID.text,
                                  'password': password.text,
                                  'firstname': firstname.text,
                                  'middlename': middlename.text,
                                  'lastname': lastname.text 
                                  });
                                  setState(() {
                                    isload= false;
                                    schoolID.clear();
                                    password.clear();
                                    firstname.clear();
                                    middlename.clear();
                                    lastname.clear();
                                    isEnable =false;
                                    Navigator.pop(context);
                                    SweetAlert.show(context,
                                    title: "Register Sucess",
                                    subtitle: "You can now Login",
                                    style: SweetAlertStyle.success);
                                  });
                            }else{
                             values.forEach((key,values){
                             setState(() {
                              isload =false;
                                 isEnable =false;
                              popupInvalid("School-ID already taken", "Warning");
                             });
                             
                           });
                           }
                           
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
