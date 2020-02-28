import 'package:event_proposal_admin/SAO/Home/home.dart';
import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_button/progress_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isWide =true;
class SaoPending extends StatefulWidget {
  @override
  _SaoPendingState createState() => _SaoPendingState();
}

class _SaoPendingState extends State<SaoPending> {
  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            setState(() {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home(), fullscreenDialog: true)); 
            });
          }),
        title: Text(
          "Sao Pending Proposal's", style: TextStyle(
           fontFamily: "Mops",
           fontSize: ScreenUtil.instance.setSp(20), 
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FirebaseDatabase.instance.reference().child("SAO").child("Proposal").orderByChild("status").equalTo("Pending").onValue,
          builder: (BuildContext context, AsyncSnapshot<Event> snapshot){
              if(snapshot.connectionState ==ConnectionState.waiting){
                return LoadingList();
              }else{
                if(snapshot.hasData){
                  Map<dynamic, dynamic> values =snapshot.data.snapshot.value;
                  if(values!=null){
                    if(values['org_type'].toString().contains("Campus-Wide")){
                    setState(() {
                      isWide =false;
                    });
                  }else{
                      isWide =true;
                  }
                  }
                  if(values!=null){
                    values.forEach((key, values){});
                     return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: values.values.toList().length,
                            itemBuilder: (BuildContext context, int index){         
                                return SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 20),
                                width: ScreenUtil.instance.setWidth(200),
                                child: Card(
                                elevation: 12.5,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xFFFF3345),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        color: Colors.white,
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.school, color: Colors.black,),
                                          title: Text("Name Of The Project: "+" "+values.values.toList()[index]['name_of_project'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                       Card(
                                        color: Colors.white,
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.nature_people, color: Colors.black,),
                                          title: Text("Nature Of The Project: "+" "+values.values.toList()[index]['nature_of_project'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Committee In Charge: "+" "+values.values.toList()[index]['committee_in_charge'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                        Padding(padding: EdgeInsets.only(top: 5)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.place, color: Colors.black,),
                                          title: Text("Venue: "+" "+values.values.toList()[index]['venue'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                          trailing: Text("Date: "+" "+values.values.toList()[index]['date_of_event'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                          Padding(padding: EdgeInsets.only(top: 5)),
                                          Card(
                                        color: Colors.white,
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.place, color: Colors.black,),
                                          title: Text("Date of Request: "+" "+values.values.toList()[index]['date'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      
                                      Card(
                                        color: Colors.white,
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.av_timer, color: Colors.black,),
                                          title: Text("Time Start: "+" "+values.values.toList()[index]['time_from'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                          trailing: Text("Time End: "+" "+values.values.toList()[index]['time_to'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),

                                        ),
                                      ),
                                        Padding(padding: EdgeInsets.only(top: 5)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 15.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Beneficiaries: "+" "+values.values.toList()[index]['beneficiaries'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          title: Text("Type: "+" "+values.values.toList()[index]['org_type'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                            trailing: Text("Name: "+" "+values.values.toList()[index]['org_name'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Prepared By: "+" "+values.values.toList()[index]['prepared_by'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Noted By Pres.: "+" "+values.values.toList()[index]['noted_by_org_president'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                     
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                       Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Noted By Adviser: "+" "+values.values.toList()[index]['noted_by_adviser'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Recommending Approval: "+" "+((isWide ? values.values.toList()[index]['recommending_approval']:"Wide Campus Not Applicable")), style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                        ),
                                      ),
                                      

                                      Padding(padding: EdgeInsets.only(top: 10,)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                               Padding(padding:EdgeInsets.only(left: 10),
                                               child: FlatButton(
                                                 color: Colors.redAccent,
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(10),
                                                 ),
                                                    onPressed: (){
                                                     FirebaseDatabase.instance.reference().child("SAO").child("Proposal").child(values.keys.toList()[index]).update({
                                                      "status": "Accepted"
                                                    }).then((onValue){

                                                    });   
                                                    popupInvalid("This Proposal Has been accepted", "Great");
                                                    },
                                                    child: Text("Accept Proposal", style:  TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Mops",
                                                      fontSize: ScreenUtil.instance.setSp(18),
                                                    ),)
                                                 ), 
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 83),
                                                    child: FlatButton(
                                                      color: Colors.redAccent,
                                                    shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    onPressed: ()async{
                                                       FirebaseDatabase.instance.reference().child("SAO").child("Proposal").child(values.keys.toList()[index]).update({
                                                      "status": "Rejected"
                                                    }).then((onValue){

                                                    });   
                                                    popupInvalid("You Reject this proposal", "Rejected");
                                                    },
                                                    child: Text("Reject Proposal", style:  TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Mops",
                                                      fontSize: ScreenUtil.instance.setSp(18),
                                                    ),),
                                               ),
                                                 ),
                                            ],
                                          ),
                                        
                                      ), 
                                    ],
                                  ),
                                )
                                ),
                              ),
                                  );
                              
                     
                            }
                          
                         );
                         
                  }
                }else{
                 
                }

              }
              return LoadingList();
              
          }
          
          ),
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