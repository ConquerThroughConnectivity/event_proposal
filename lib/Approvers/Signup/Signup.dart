import 'package:event_proposal_admin/DropDown.dart';
import 'package:event_proposal_admin/Organization/Signup/Signup.dart';
import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/Venue/Home/Home.dart';
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
String approvername;
String approver;

String organizationType;
String orgType;

String organizationname;
String orgname;


final key = GlobalKey<FormState>();

bool isEnable =true;
bool isEnable1 =true;
bool isApproverEnable =false;

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isload=false;
List<dynamic> result;
List<dynamic> orgtype;
bool isSee =true;

bool visible ;
class ApproverSignup extends StatefulWidget {
  @override
  _ApproverSignupState createState() => _ApproverSignupState();
}

class _ApproverSignupState extends State<ApproverSignup> {

  @override
  void initState() {
    approvername ="";
    approver ="";

    organizationType ="";
    orgType ="";

    organizationname="";
    orgType="";

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
        elevation: 0.0,
        centerTitle: true,
        title: Text('Approver Signup', style: TextStyle(
          color: Colors.white,
          fontFamily: "Mops",
          fontWeight: FontWeight.w200,
          fontSize: 30.0
        ),),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          setState(() {
            isEnable =true;
            isEnable1 =true;
            schoolID.clear();
            password.clear();
            firstname.clear();
            approver ="";
            middlename.clear();
            lastname.clear();
            isApproverEnable =false;
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
                            EdgeInsets.all(ScreenUtil.instance.setWidth(20.0)),
                        child: Column(
                          children: <Widget>[
                        TextFormField(
                        autofocus: false,
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
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        controller: password,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z-1234567890]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.text,
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
                        autofocus: false,
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
                        autofocus: false,
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
                          LengthLimitingTextInputFormatter(10),
                        ],
                        autofocus: false,
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
                         absorbing: isApproverEnable,
                         child: DropDownFormField(
                        titleText: "Approver Type",
                        hintText: "Select Approver Type",
                        value: approvername,
                        validator: (value){
                          if(value==null){
                            return "Required Field";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            approvername =value;
                            isEnable =false;
                            isApproverEnable =true;
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            approvername =value;
                          });
                        },
                        textField: "display",
                        valueField: "value",
                        dataSource: [
                          {
                            "display": "Dean's Office",
                            "value": "Dean's Office"
                          },
                          {
                            "display": "Organization President",
                            "value": "Organization President",
                          },
                          {
                            "display": "Adviser",
                            "value": "Adviser",
                          },
                          
                         
                        ],
                      ),
                       ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      AbsorbPointer(
                        absorbing: isEnable,
                        child: DropDownFormField(
                        titleText: "Organization Type",
                        hintText: "Select Organization Type",
                        value: organizationType,
                        validator: (value){
                          if(value==null){
                            return "Required Field";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            organizationType =value;
                            if(organizationType.contains('CAS')){
                              setState(() {
                                isEnable =true;
                                isEnable1 =false;
                                if(approvername.contains("Dean's Office")){
                              setState(() {
                              
                                result =
                                  {
                                    {
                                      "display": "No Particular Organization",
                                      "value": "No Particular Organization"
                                    }
                                  }.cast().toList();
                                
                                
                              });
                            }else{
                             setState(() {
                              
                                result ={
                            {
                              "display": "Association of Communication Students (ACTIONS)",
                              "value": "Association of Communication Students (ACTIONS)",
                            },
                            {
                              "display": "Hospitality Management Society (UEHMS)",
                              "value": "Hospitality Management Society (UEHMS)",
                            },
                            {
                              "display": "Tourism Society (UETS)",
                              "value": "Tourism Society (UETS)",
                            }
                            }.cast().toList();
                             });
                            }
                                
                              });
                            }else if(organizationType.contains("CBA")){
                              setState(() {
                                isEnable =true;
                                isEnable1 =false;
                                if(approvername.contains("Dean's Office")){
                              setState(() {
                               
                                result =
                                  {
                                    {
                                      "display": "No Particular Organization",
                                      "value": "No Particular Organization"
                                    }
                                  }.cast().toList();
                                
                                
                              });
                            }else{
                              setState(() {
                                
                                result ={
                            {
                              "display": "Association of Tax and Law Students (ATLAS)",
                              "value": "Association of Tax and Law Students (ATLAS)",
                            },
                            {
                              "display": "Junior Financial Executives (JFINEX)",
                              "value": "Junior Financial Executives (JFINEX)",
                            },
                            {
                              "display": "Junior Philippine Institute of Accountants (JPIA)",
                              "value": "Junior Philippine Institute of Accountants (JPIA)",
                            },
                            {
                              "display": "Junior Executive Marketing Society (JEMS)",
                              "value": "Junior Executive Marketing Society (JEMS)",
                            },
                            {
                              "display": "Management Association (MAUEK)",
                              "value": "Management Association (MAUEK)",
                            },
                            {
                              "display": "Hiyas nang Silangan",
                              "value": "Hiyas nang Silangan",
                            },
                            {
                              "display": "BES(Probationary)",
                              "value": "BES(Probationary)",
                            }
                            }.cast().toList();
                              });
                            }
                                
                              });
                            }else if(organizationType.contains('CFAD')){
                              setState(() {
                                isEnable =true;
                                isEnable1 =false;
                                if(approvername.contains("Dean's Office")){
                              setState(() {
                                
                                result =
                                  {
                                    {
                                      "display": "No Particular Organization",
                                      "value": "No Particular Organization"
                                    }
                                  }.cast().toList();
                                
                              });
                            }else{
                              setState(() {
                               
                                result ={
                              {
                              "display": "Buklod Sining",
                              "value": "Buklod Sining",
                            },
                            {
                              "display": "United Architects of the Philippines Student Auxilliary",
                              "value": "United Architects of the Philippines Student Auxilliary",
                            },
                            {
                              "display": "Society of Interior Design Students(SIDS)",
                              "value": "Society of Interior Design Students(SIDS)",
                            },
                            {
                              "display": "Pintura(probationary)",
                              "value": "Pintura(probationary)",
                            },
                            {
                              "display": "ARKI(probationary)",
                              "value": "ARKI(probationary)",
                            }
                              }.cast().toList();
                              });
                            }
                              
                              });
                            }else if(organizationType.contains('COE')){
                              setState(() {
                                isEnable =true;
                                isEnable1 =false;
                                if(approvername.contains("Dean's Office")){
                              setState(() {
                                
                                result =
                                  {
                                    {
                                      "display": "No Particular Organization",
                                      "value": "No Particular Organization"
                                    }
                                  }.cast().toList();
                                
                              });
                            }else{
                                setState(() {
                                 
                                  result ={
                              {
                              "display": "Association of Civil Engineering Students (ACES)",
                              "value": "Association of Civil Engineering Students (ACES)",
                            },
                            {
                              "display": "Association of Electrical Engineering Student(AEES)",
                              "value": "Association of Electrical Engineering Student(AEES)",
                            },
                            {
                              "display": "Association of Computer Studies and Systems Students",
                              "value": "Association of Computer Studies and Systems Students",
                            },
                            {
                              "display": "Computer Engineering Students Society (COESS)",
                              "value": "Computer Engineering Students Society (COESS)",
                            },
                            {
                              "display": "Electronics Engineering Socity -Institute of Electronics",
                              "value": "Electronics Engineering Socity -Institute of Electronics",
                            },
                            {
                              "display": "Institute of Electrical and Electronics Engineers- UE",
                              "value": "Institute of Electrical and Electronics Engineers- UE",
                            },
                            {
                              "display": "league of Information Technology Students (LITS)",
                              "value": "league of Information Technology Students (LITS)",
                            },
                            {
                              "display": "Philippine Society of Mechanical Engineers (PSME)",
                              "value": "Philippine Society of Mechanical Engineers (PSME)",
                            }
                            }.cast().toList();
                                });
                            }
                                
                              });
                            }else if(organizationType.contains("Campus-Wide")){
                              setState(() {
                                isEnable =true;
                                isEnable1 =false;
                                if(approvername.contains("Dean's Office")){
                              setState(() {
                               
                                result =
                                  {
                                    {
                                      "display": "No Particular Organization",
                                      "value": "No Particular Organization"
                                    }
                                  }.cast().toList();
                                
                              });
                            }else{
                             setState(() {
                               
                                result ={
                              {
                              "display": "Christian Communities (CCP)",
                              "value": "Christian Communities (CCP)",
                            },
                            {
                              "display": "College 'Y' Club",
                              "value": "College 'Y' Club",
                            },
                            {
                              "display": "Lakas Mag-aaral ng Pamantasan ng Silangan (LAMPS)",
                              "value": "Lakas Mag-aaral ng Pamantasan ng Silangan (LAMPS)",
                            },
                            {
                              "display": "Men in Board (MIB)",
                              "value": "Men in Board (MIB)",
                            },
                            {
                              "display": "Rotaract Club of UE Caloocan",
                              "value": "Rotaract Club of UE Caloocan",
                            },
                            {
                              "display": "Lualhati LeagUE of Scholars",
                              "value": "Lualhati LeagUE of Scholars",
                            },
                            {
                              "display": "Silangan Film Circle",
                              "value": "Silangan Film Circle",
                            },
                            {
                              "display": "UE Red Cross Youth Council(RCYC)",
                              "value": "UE Red Cross Youth Council(RCYC)",
                            },
                            {
                              "display": "UE Seeds of the Naton' (UE SON's)",
                              "value": "UE Seeds of the Naton' (UE SON's)",
                            },
                             {
                              "display": "Kristiyanong Kabataan para sa Bayan (KKB)",
                              "value": "Kristiyanong Kabataan para sa Bayan (KKB)",
                            },
                            {
                              "display": "Red Stage Events",
                              "value": "Red Stage Events",
                            },
                            {
                              "display": "Junior Researchers and Quizzers Organization (JRQO)",
                              "value": "Junior Researchers and Quizzers Organization (JRQO)",
                            },
                            {
                              "display": "Debate Society",
                              "value": "Debate Society",
                            },
                            {
                              "display": "Artstroke",
                              "value": "Artstroke",
                            },
                            {
                              "display": "ARMADA(probationary)",
                              "value": "ARMADA(probationary)",
                            },
                            {
                              "display": "Every Nation Campus (Probation)",
                              "value": "Every Nation Campus (Probation)",
                            },
                            
                            }.cast().toList();
                             });
                            }
                                
                              });
                            }else if(organizationType.contains("StudentCouncil")){
                              setState(() {
                                isEnable =true;
                               isEnable1 =false;
                                if(approvername.contains("Dean's Office")){
                              setState(() {
                               
                                result =
                                  {
                                    {
                                      "display": "No Particular Organization",
                                      "value": "No Particular Organization"
                                    }
                                  }.cast().toList();
                                
                              });
                            }else{
                              setState(() {
                              
                                result ={
                              {
                              "display": "Central Student Council (CSC)",
                              "value": "Central Student Council (CSC)",
                            },
                            {
                              "display": "Business Administration Student Council (BASC)",
                              "value": "Business Administration Student Council (BASC)",
                            },
                            {
                              "display": "Engineering Student Council (ENSC)",
                              "value": "Engineering Student Council (ENSC)",
                            },
                            {
                              "display": "College of Arts and Sciences Student Council (CASSC)",
                              "value": "College of Arts and Sciences Student Council (CASSC)",
                            },
                            {
                              "display": "CFAD- Architecture and Design Student Council(CFAD-SC)",
                              "value": "CFAD- Architecture and Design Student Council(CFAD-SC)",
                            }
                            }.cast().toList();
                              });
                              
                            }
                                
                              });
                            }
                            
                          
                              
                              
                            
                          
                            
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            organizationType =value;
                          });
                        },
                        textField: "display",
                        valueField: "value",
                        dataSource: [
                          {
                            "display": "College of Arts and Science",
                            "value": "CAS"
                          },
                          {
                            "display": "College of Business Administration",
                            "value": "CBA"
                          },
                          {
                            "display": "College of Fine Arts, Architecture and Design",
                            "value": "CFAD"
                          },
                          {
                            "display": "College of Engineering",
                            "value": "COE"
                          },
                          {
                            "display": "Campus-Wide",
                            "value": "Campus-Wide"
                          },
                          {
                            "display": "Student-Council",
                            "value": "StudentCouncil"
                          }
                         
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
                        Padding(
                        child:AbsorbPointer(
                          absorbing: isEnable1,
                          child: DropDownFormField(
                        titleText: "Organization Name",
                        hintText: "Select Organization Name",
                        value: organizationname,
                        validator: (value){
                          if(value==null){
                            return "Required Field";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            organizationname =value;
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            organizationname =value;
                          });
                        },
                        textField: "display",
                        valueField: "value",
                        dataSource: result==null?[
                          {
                            "display":"Please Select Organization Type",  
                          }
                        ] :result,
                      ),
                        ),
                        padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20),
                        
                       )  
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
                      backgroundColor: Color(0xFFFF3345), 
                      onPressed: () async {
                        //Signup Register
                        final form =key.currentState;
                        if(form.validate()){
                          form.save();
                          setState(() {
                            approver =approvername;
                            orgType =organizationType;
                            orgname =organizationname;
                            isload =true;
                          });
                         FirebaseDatabase.instance.reference().child("User").child("Approver").orderByChild("id").equalTo(schoolID.text)
                         .once().then((DataSnapshot snapshots) async { 
                           Map<dynamic, dynamic> values =snapshots.value;
                           if(values==null){
                              setState(() {
                              isload=false;
                                 isEnable =false;
                             });
                               FirebaseDatabase.instance.reference().child("User").child("Approver").child(schoolID.text).set({
                                  'org_type': approver,
                                  'id': schoolID.text,
                                  'firstname': firstname.text,
                                  'middlename': middlename.text,
                                  'lastname': lastname.text,
                                  'password': password.text,
                                  'organization_type': orgType,
                                  'org_name': orgname, 
                                  });
                                  setState(() {
                                    isEnable =true;
                                    isload =false;
                                    schoolID.clear();
                                    password.clear();
                                    firstname.clear();
                                    approver ="";
                                    middlename.clear();
                                    lastname.clear();
                                    isApproverEnable =false;
                                    Navigator.pop(context);
                                    SweetAlert.show(context,
                                    title: "Register Sucess",
                                    subtitle: "You can now Login",
                                    style: SweetAlertStyle.success);
                                  });
                                  
                           }else{
                             values.forEach((key,values){
                             setState(() {
                              
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