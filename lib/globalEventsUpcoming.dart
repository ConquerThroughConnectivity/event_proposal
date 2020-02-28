import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isWide =true;
String date =DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
DateTime dateTime =DateTime.parse(date);
DateTime upcoming;
class UpcomingEvents extends StatefulWidget {
  @override
  _UpcomingEventsState createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  @override
  Widget build(BuildContext context) {
  
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: StreamBuilder(
          stream: FirebaseDatabase.instance.reference().child("SAO").child("Proposal").onValue,
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
                              if(values.values.toList()[index]['status'].toString().contains("Accepted")){
                                if(dateTime.isBefore(DateTime.parse(values.values.toList()[index]["date_of_event"]))){
                                  return SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 20),
                                width: ScreenUtil.instance.setWidth(200),
                                child: Card(
                                elevation: 12.5,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.redAccent,
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
                                          title: Text("Description: "+" "+values.values.toList()[index]['description'], style: TextStyle(
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
                                          title: Text("Course: "+" "+values.values.toList()[index]['org_type'], style: TextStyle(
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
                                          title: Text("Start: "+" "+values.values.toList()[index]['time_from'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                          trailing: Text("End: "+" "+values.values.toList()[index]['time_to'], style: TextStyle(
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
                                       Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          title: Text("General Objectives: "+" "+values.values.toList()[index]['general_objective'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          

                                        ),
                                      ),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          title: Text("Specific Objectives: "+" "+values.values.toList()[index]['specific_objective'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          

                                        ),
                                      ),
                                       Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          title: Text("Planning Stage: "+" "+values.values.toList()[index]['planning_statge'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          

                                        ),
                                      ),
                                       
                                     
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          title: Text("Implementation: "+" "+values.values.toList()[index]['implementation'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          

                                        ),
                                      ),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          title: Text("Resource Requirement: "+" "+values.values.toList()[index]['resource_req'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          

                                        ),
                                      ),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          title: Text("Evaluation: "+" "+values.values.toList()[index]['evaluation'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          

                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                      
                                      
                                    ],
                                  ),
                                )
                                ),
                              ),
                                  );
                                }
                                
                              }        
                              return LoadingList();
                            }
                          
                         );
                         
                  }
                }else{
                 
                }

              }
              return LoadingList();
              
          }
          
          ),
      );
  }
}