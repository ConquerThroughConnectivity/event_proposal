import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:event_proposal_admin/Approvers/Signup/Signup.dart';
import 'package:event_proposal_admin/DropDown.dart';
import 'package:event_proposal_admin/Organization/Home/Home.dart';

import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/republicAct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:progress_button/progress_button.dart';



final TextEditingController nameofTheProject = new TextEditingController();
final TextEditingController natureofTheProject = new TextEditingController();
final TextEditingController beneficiaries = new TextEditingController();
final TextEditingController timeFrom = new TextEditingController();
final TextEditingController timeTo = new TextEditingController();
final TextEditingController eventDate = new TextEditingController();
final TextEditingController description = new TextEditingController();

final TextEditingController generaldescription = new TextEditingController();
final TextEditingController specificdescription = new TextEditingController();
final TextEditingController planningstage= new TextEditingController();
final TextEditingController implementation = new TextEditingController();
final TextEditingController resourcerequirement = new TextEditingController();
final TextEditingController evaluation = new TextEditingController();
final dateformat =DateFormat("hh:mm a");
final evenFormat =DateFormat("yyyy-MM-dd");

String venueType;
String venType;

String inchargeName;
String incharge;

String approverName;
String approver;

final key = GlobalKey<FormState>();



final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isload=false;
List<dynamic> result;
List<dynamic> approve;
var cas;

bool venue =false;


bool isCharge;
bool isApprover;
String date =DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

class CreateEvent extends StatefulWidget {
  final String id;
  final String org;
  final String orgname;
  CreateEvent({Key key, this.id, this.org, this.orgname}): super(key: key);
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

 
  @override
  void initState() {
  
    venType ="";
    venueType ="";

    inchargeName= "";
    incharge ="";

    approverName ="";
    approver ="";

    isCharge =true;
    isApprover =true;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            setState(() {
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>HomeOrganization(id: widget.id.toString(),), fullscreenDialog: true));
              venue =false;
              isApprover =true;
              isCharge =true;
              nameofTheProject.clear();
              natureofTheProject.clear();
              timeFrom.clear();
              timeTo.clear();
              beneficiaries.clear();
            });
          }),
        title: Text(
          "Create Event", style: TextStyle(
           fontFamily: "Mops",
           fontSize: ScreenUtil.instance.setSp(20), 
          ),
        ),
        centerTitle: true,
      ),
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
                          top: ScreenUtil.instance.setWidth(20.0),
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
                        maxLines: 2,
                        textInputAction: TextInputAction.done,
                        controller: nameofTheProject,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                          LengthLimitingTextInputFormatter(20),
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val= nameofTheProject.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Name Of Project",
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
                        maxLines: 2,
                        textInputAction: TextInputAction.done,
                        controller: natureofTheProject,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                         
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          
                        },
                        onChanged: (val){
                          setState(() {
                          val =natureofTheProject.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Nature of Project",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                          prefixIcon: Icon(Icons.nature),
                        ),
                      ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        maxLines: 10,
                        textInputAction: TextInputAction.done,
                        controller: generaldescription,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                         
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          
                        },
                        onChanged: (val){
                          setState(() {
                          val =generaldescription.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "General Objectives",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        maxLines: 10,
                        textInputAction: TextInputAction.done,
                        controller: specificdescription,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                         
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          
                        },
                        onChanged: (val){
                          setState(() {
                          val =specificdescription.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Specific Objectives",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        maxLines: 10,
                        textInputAction: TextInputAction.done,
                        controller: planningstage,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                         
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          
                        },
                        onChanged: (val){
                          setState(() {
                          val =planningstage.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Planning Stage",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        maxLines: 10,
                        textInputAction: TextInputAction.done,
                        controller: implementation,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                         
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          
                        },
                        onChanged: (val){
                          setState(() {
                          val =implementation.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Implementation",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        controller: resourcerequirement,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                         
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          
                        },
                        onChanged: (val){
                          setState(() {
                          val =resourcerequirement.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Resource Requirement",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        controller: evaluation,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                         
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                          
                        },
                        onChanged: (val){
                          setState(() {
                          val =evaluation.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Evaluation",
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                      
                      

                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                       AbsorbPointer(
                        absorbing: venue,
                        child:  DropDownFormField(
                        titleText: "Venue",
                        hintText: "Select Venue",
                        value: venueType,
                        validator: (value){
                          if(value==null){
                            return "Required Field";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            venueType =value;
                            if(venueType.contains('TYK Study Area') || venueType.contains('UE Open Field') || venueType.contains('TYK Lobby') || venueType.contains('Gazebo')){
                              setState(() {
                                venue =true;
                                isCharge =false;
                                result ={
                                  {
                                  "display": "ESO",
                                   "value": "ESO",
                                  },
                                }.cast().toList();
                              });
                              setState(() {
                                isEnable =true;
                                approve ={
                                  {
                                   "display": "Chancellor",
                                   "value": "Chancellor",
                                  }
                                }.cast().toList();
                              });
                            }else if(venueType.contains('MMR 3A') || venueType.contains('MMR 3B') || venueType.contains('Computer Laboratories')){
                              setState(() {
                                venue =true;
                                isCharge =false;
                                result ={
                                  {
                                  "display": "Information Technology",
                                   "value": "Information Technology",
                                  },
                                }.cast().toList();
                               setState(() {
                                 isEnable =true;
                                  
                                  approve ={
                                  {
                                    "display": "Chancellor",
                                   "value": "Chancellor",
                                  }
                                }.cast().toList();
                               });
                              });
                            }else if(venueType.contains('MPH1') || venueType.contains('MPH2')){
                              setState(() {
                                venue =true;
                                isCharge =false;
                                result = {
                                  {
                                    "display": "Library Head",
                                    "value": "Library Head",
                                  },
                                }.cast().toList();
                                setState(() {
                                  isEnable =true;

                                  approve ={
                                  {
                                    "display": "Assistant Director",
                                   "value": "Assistant Director",
                                  }
                                }.cast().toList();
                                });
                              });
                            }else if(venueType.contains('MPH3')){
                              setState(() {
                                venue =true;
                                isCharge =false;
                                result ={
                                  {
                                    "display": "Library Head",
                                    "value": "Library Head",
                                  }
                                }.cast().toList();
                                setState(() {
                                  isEnable =true;
                                  isEnable1 =false;
                                  approve ={
                                  {
                                   "display": "Chancellor",
                                   "value": "Chancellor",
                                  }
                                }.cast().toList();
                                });
                              });
                            }else if(venueType.contains('Briefing Room')){
                              setState(() {
                                venue =true;
                                isCharge =false;
                                result ={
                                  {
                                    "display": "Engineering",
                                    "value": "Engineering",
                                  }
                                }.cast().toList();
                                setState(() {
                                  approve ={
                                  {
                                   "display": "Dean's Office",
                                   "value": "Dean's Office",
                                  }
                                }.cast().toList();
                                });
                              });
                            }
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
                            "display": "TYK Study Area",
                            "value": "TYK Study Area"
                          },
                          {
                            "display": "UE Open Field",
                            "value": "UE Open Field",
                          },
                          {
                            "display": "TYK Lobby",
                            "value": "TYK Lobby"
                          },
                          {
                            "display": "Gazebo",
                            "value": "Gazebo"
                          },
                          {
                            "display": "MMR 3A",
                            "value": "MMR 3A"
                          },
                          {
                            "display": "MMR 3B",
                            "value": "MMR 3B"
                          },
                          {
                            "display": "Computer Laboratories",
                            "value": "Computer Laboratories"
                          },
                          {
                            "display": "MPH1",
                            "value": "MPH1"
                          },
                          {
                            "display": "MPH2",
                            "value": "MPH2"
                          },
                          {
                            "display": "MPH3",
                            "value": "MPH3"
                          },
                          {
                            "display": "Briefing Room",
                            "value":  "Briefing Room"
                          },
                        ],
                      ),
                       ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      AbsorbPointer(
                        absorbing: isCharge,
                        child:  DropDownFormField(
                        titleText: "In-Charge Type",
                        hintText: "Select In-Charge Type",
                        value: inchargeName,
                        validator: (value){
                          if(value==null){
                            return "Required Field";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            inchargeName =value;
                            isApprover =false;
                          });
                        },
                        onSaved: (value){
                          setState((){
                            inchargeName =value;
                          });
                        },
                        textField: "display",
                        valueField: "value",
                        dataSource: result==null?[
                          {
                            "display": "Please Select Venue",  
                          }
                        ]:result =result,

                      ),
                      ),
                      Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                       AbsorbPointer(
                         absorbing: isApprover,
                         child: DropDownFormField(
                        titleText: "Approver",
                        hintText: "Select Approver",
                        value: approverName,
                        validator: (value){
                          if(value==null){
                            return "Required Field";
                          }
                        },
                        onChanged: (value){
                          setState(() {
                            approverName =value;
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            approverName =value;
                          });
                        },
                        textField: "display",
                        valueField: "value",
                        dataSource: approve==null?[
                          {
                            "display": "Please Select Venue",  
                          }
                        ] :approve,

                      ),
                       ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),

                      DateTimeField(
                        controller: timeFrom,
                        validator: (val){
                          if(val==null){
                            return "This field cannot be empty";
                          }
                        },
                        
                        decoration: InputDecoration(
                          labelText: "Time From",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.timelapse),
                          
                        ),
                        format: dateformat, 
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context, initialTime: 
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.convert(time);
                        }
                        ),
                        Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),

                      DateTimeField(
                        controller: timeTo,
                        validator: (val){
                          if(val==null){
                            return "This field cannot be empty";
                          }
                        },
                        
                        decoration: InputDecoration(
                          labelText: "Time Until",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.timelapse),
                          
                        ),
                        format: dateformat, 
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context, initialTime: 
                            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.convert(time);
                        }
                        ),
                        Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                        DateTimeField(
                        controller: eventDate,
                        validator: (val){
                          if(val==null){
                            return "This field cannot be empty";
                          }
                        },
                        
                        decoration: InputDecoration(
                          labelText: "Date of Event",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.date_range),
                          
                        ),
                        format: evenFormat, 
                        onShowPicker: (context, currentValue) async {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2100));
      
                        }
                        ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        maxLines: 2,
                        textInputAction: TextInputAction.done,
                        controller: description,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                       
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val= description.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Project Description",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.description),
                          
                        ),
                      ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
                      TextFormField(
                        
                        maxLines: 2,
                        textInputAction: TextInputAction.done,
                        controller: beneficiaries,
                        inputFormatters: [WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                       
                        ],
                        keyboardType: TextInputType.text,
                        validator: (val){
                          if(val.isEmpty){
                            return 'This field cannot be Empty';
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            val= beneficiaries.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Beneficiaries",
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Color(0xFF2d3447))
                          ),
                          hasFloatingPlaceholder: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.people),
                          
                        ),
                      ),
                       Padding
                      (padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20))),
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
                       
                     
                      ProgressButton(
                      buttonState: ButtonState.inProgress,
                      child: isload ? Loading() : Text('Submit', style: TextStyle(
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
                            incharge =inchargeName;
                            approver =approverName;
                            isload =true;
                          });

                          FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").orderByChild("id").equalTo(widget.id).once().then((DataSnapshot snapshot) async{
                            Map<dynamic, dynamic> values =await snapshot.value;
                            if(values==null){
                              save();
                            }else{
                              values.forEach((key, values){
                              if(values!=null){
                                if(eventDate.text.contains(values['date_of_event'])){
                                  print(values["date"].toString());
                                  setState(() {
                                    venue =false;
                                    isApprover =true;
                                    isCharge =true;
                                    nameofTheProject.clear();
                                    natureofTheProject.clear();
                                    timeFrom.clear();
                                    timeTo.clear();
                                    beneficiaries.clear();
                                    isload= false;
                                  });
                                  popupInvalid("Cannot Propose Same proposal date", "Warning");
                                }else{
                                    save();
                                }
                              }else{
                               
                              }
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
    ),
    onWillPop: () async=> false);
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

  void save(){
    if(widget.org.contains('Campus-Wide')){
                                   FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").push().set({
                                  'name_of_project': nameofTheProject.text,
                                  'nature_of_project': natureofTheProject.text,
                                  'venue': venType,
                                  'committee_in_charge': incharge,
                                  'time_to': timeTo.text,
                                  'time_from': timeFrom.text,
                                  'approver_name': approver,
                                  'beneficiaries' :   beneficiaries.text,
                                  'name_incharge': 'Nothing yet',
                                  'name_approver': 'Nothing yet',
                                  'date': date,
                                  'incharge':"Pending",
                                  'org_president': "Nothing Yet",
                                  'org_president_status': "Pending",
                                  'org_adviser': "Nothing Yet",
                                  'org_adviser_status': "Pending",
                                  'approver': "Pending",
                                  'status': "Pending",
                                  'id': widget.id,
                                  'org_type': widget.org,
                                  'org_name': widget.orgname,
                                  'date_of_event': eventDate.text,
                                  'description': description.text,
                                  'general_objective': generaldescription.text,
                                  'specific_objective': specificdescription.text,
                                  'planning_statge': planningstage.text,
                                  'implementation': implementation.text,
                                  'resource_req': resourcerequirement.text,
                                  'evaluation': evaluation.text,
                                  });

                                  setState(() {
                                    venue =false;
                                    isApprover =true;
                                    isCharge =true;
                                    nameofTheProject.clear();
                                    natureofTheProject.clear();
                                    timeFrom.clear();
                                    timeTo.clear();
                                    beneficiaries.clear();
                                    isload= false;
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>HomeOrganization(id: widget.id,), fullscreenDialog: true));
                                    popupInvalid("Great Wait for the Approval of the Approvers", "Venue Reservation Success");
                                  });     
                                  }else{
                                  FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").push().set({
                                  'name_of_project': nameofTheProject.text,
                                  'nature_of_project': natureofTheProject.text,
                                  'venue': venType,
                                  'committee_in_charge': incharge,
                                  'time_to': timeTo.text,
                                  'time_from': timeFrom.text,
                                  'approver_name': approver,
                                  'beneficiaries' :   beneficiaries.text,
                                  'name_incharge': 'Nothing yet',
                                  'name_approver': 'Nothing yet',
                                  'date': date,
                                  'incharge':"Pending",
                                  'org_president': "Nothing Yet",
                                  'org_president_status': "Pending",
                                  'org_adviser': "Nothing Yet",
                                  'org_adviser_status': "Pending",
                                  'org_dean': "Nothing Yet",
                                  'org_dean_status': "Pending",
                                  'approver': "Pending",
                                  'status': "Pending",
                                  'id': widget.id,
                                  'org_type': widget.org,
                                  'org_name': widget.orgname,
                                  'date_of_event': eventDate.text,
                                  'description': description.text,
                                  'general_objective': generaldescription.text,
                                  'specific_objective': specificdescription.text,
                                  'planning_statge': planningstage.text,
                                  'implementation': implementation.text,
                                  'resource_req': resourcerequirement.text,
                                  'evaluation': evaluation.text,
                                  });

                                  setState(() {
                                    venue =false;
                                    isApprover =true;
                                    isCharge =true;
                                    nameofTheProject.clear();
                                    natureofTheProject.clear();
                                    timeFrom.clear();
                                    timeTo.clear();
                                    beneficiaries.clear();
                                    isload= false;
                                   
                                    popupInvalid("Great Wait for the Approval of the Approvers", "Venue Reservation Success");
                                  });     
                                  }
  }
}


