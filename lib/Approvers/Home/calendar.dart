import 'package:event_proposal_admin/Approvers/Home/Home.dart';
import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';



final format =DateFormat("yyyy-MM-dd");
String date;
String eventDate;
final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isWide =true;
class ApproverCalendar extends StatefulWidget {
  final String id;
  ApproverCalendar({this.id});
  @override
  _ApproverCalendarState createState() => _ApproverCalendarState();
}

class _ApproverCalendarState extends State<ApproverCalendar> {
  CalendarController controller;
  @override
  void initState() {
    controller =CalendarController();
    eventDate ="";
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
        elevation: 0.4,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=> Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeApprovers(id: widget.id,), fullscreenDialog: true))),
        title: Text("Calendar Events", style: TextStyle(
          fontFamily: "Mops",
          fontSize: 20,
          fontWeight: FontWeight.normal
        ),),
      ),
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              TableCalendar(
              calendarController: controller,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                todayColor: Color(0xFFFF3345),
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Color(0xFFFF3345),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                formatButtonTextStyle: TextStyle(color: Colors.black),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                setState(() {
                date =format.parse(date.toString());
                eventDate =date.toString().substring(0,10);
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                  margin: EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(date.day.toString(),style: TextStyle(color: Colors.white), ),
                ),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
                
              ),
              Container(
                width: 500,
                height: 25,
                color: Color(0xFFFF3345),
                child: Center(
                  child: Text("Events List on this date", style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Mops",
                  fontSize: 20,
                  fontWeight: FontWeight.w400
                ),),
                )
              ),
             Expanded(
               child: SizedBox(
                 child: Container(
                padding: EdgeInsets.only(top: 34, left: 16, right: 16,bottom: 16) ,
                child: StreamBuilder(
                    stream: FirebaseDatabase.instance.reference().child("SAO").child("Proposal").orderByChild("date_of_event").equalTo(eventDate).onValue,
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
                                      Padding(padding: EdgeInsets.only(top: 5)),
                      
                                      
                                    ],
                                  ),
                                )
                                ),
                              ),
                                  );
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
              ),
               )
               ),
              
          ],
        ),
    );
  }
}