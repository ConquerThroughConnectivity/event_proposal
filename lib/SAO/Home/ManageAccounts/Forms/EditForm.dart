import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/VenueApprovers/Assistant%20Director/Login.dart';
import 'package:event_proposal_admin/republicAct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_button/progress_button.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;

final TextEditingController password = new TextEditingController();
final TextEditingController firstname = new TextEditingController();
final TextEditingController middlename = new TextEditingController();
final TextEditingController lastname = new TextEditingController();
final TextEditingController schoolID = new TextEditingController();

bool isSee =true;
final key = GlobalKey<FormState>();
class EditForm extends StatefulWidget {
  final String schoolid;
  final String password;
  final String firstname;
  final String middlename;
  final String lastname;
  final String orgname;
  
  EditForm({Key key, this.schoolid, this.password, this.firstname, this.middlename, this.lastname, this.orgname}): super(key :key);
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {

  @override
  void initState() {
    password.text =widget.password;
    schoolID.text =widget.schoolid;
    firstname.text =widget.firstname;
    middlename.text =widget.middlename;
    lastname.text =widget.lastname;
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
        title: Text(
          "Approver Account Update Form", style: TextStyle(
           fontFamily: "Mops",
           fontSize: ScreenUtil.instance.setSp(20), 
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            setState(() {
            Navigator.pop(context);
          });
          }),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor:Colors.white ,
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
                            EdgeInsets.all(ScreenUtil.instance.setWidth(25.0)),
                        child: Column(
                          children: <Widget>[
                        TextFormField(
                          inputFormatters: [WhitelistingTextInputFormatter(RegExp("[1234567890]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                          enabled: false,
                        controller: schoolID,
                        keyboardType: TextInputType.number,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            schoolID.text =val;
                            schoolID.selection =TextSelection.fromPosition(TextPosition(offset: schoolID.text.length));
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
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z1234567890]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
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
                           password.text= val;
                           password.selection =TextSelection.fromPosition(TextPosition(offset: password.text.length));
                          });
                        },
                        obscureText: false,
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
                            firstname.text =val;
                            firstname.selection =TextSelection.fromPosition(TextPosition(offset: firstname.text.length));
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
                          LengthLimitingTextInputFormatter(1),
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
                            middlename.text =val;
                            middlename.selection =TextSelection.fromPosition(TextPosition(offset: middlename.text.length));
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
                          LengthLimitingTextInputFormatter(10),
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
                            lastname.text =val;
                            lastname.selection =TextSelection.fromPosition(TextPosition(offset: lastname.text.length));
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
                      child: isload ? Loading() : Text('Update', style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Mops",
                        fontSize: ScreenUtil.instance.setSp(20),
                        ),
                        ),
                      backgroundColor:Color(0xFFFF3345), 
                      onPressed: () async {
                        //Signup Register
                        final form =key.currentState;
                        if(form.validate()){
                          form.save();
                          setState(() {
                            isload =true;
                          });
                        
                          if(widget.orgname.toString().contains("Approver")){
                            FirebaseDatabase.instance.reference().child("User").child("Approver").child(schoolID.text).update({
                            'firstname': firstname.text,
                            'lastname': lastname.text,
                            'id': schoolID.text,
                            'password': password.text, 
                              });
                              setState(() {
                                isload =false;
                              });
                             popupInvalid("Update Succes", "You changed this user info");
                           }else if(widget.orgname.toString().contains("Organization")){
                             FirebaseDatabase.instance.reference().child("User").child("Organization").child(schoolID.text).update({
                            'firstname': firstname.text,
                            'lastname': lastname.text,
                            'id': schoolID.text,
                            'password': password.text, 
                              });
                              setState(() {
                                isload =false;
                              });
                             popupInvalid("Update Succes", "You changed this user info");

                            }else if(widget.orgname.toString().contains("Venue")){
                              FirebaseDatabase.instance.reference().child("User").child("Venue").child(schoolID.text).update({
                            'firstname': firstname.text,
                            'lastname': lastname.text,
                            'id': schoolID.text,
                            'password': password.text, 
                              });
                              setState(() {
                                isload =false;
                              });
                             popupInvalid("Update Succes", "You changed this user info");
                            }
                            else if(widget.orgname.toString().contains("VenueApprovers")){
                            FirebaseDatabase.instance.reference().child("User").child("VenueApprovers").child(schoolID.text).update({
                            'firstname': firstname.text,
                            'lastname': lastname.text,
                            'id': schoolID.text,
                            'password': password.text, 
                              });
                              setState(() {
                                isload =false;
                              });
                             popupInvalid("Update Succes", "You changed this user info");
                            }

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