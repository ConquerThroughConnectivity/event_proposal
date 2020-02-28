import 'package:event_proposal_admin/Dean/Home.dart';
import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;



class DeanPending extends StatefulWidget {
  final String orgtype;
  final String orgname;
  final String organization;
  final String fullname;
  final String id;
  DeanPending({this.orgtype, this.orgname, this.organization, this.fullname, this.id});
  @override
  _DeanPendingState createState() => _DeanPendingState();
}

class _DeanPendingState extends State<DeanPending> {
  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return WillPopScope(
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            setState(() {
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>DeanHome(), fullscreenDialog: true));
            });
          }),
        title: Text(
          "Pending Event", style: TextStyle(
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
          stream: FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").orderByChild('org_type').equalTo(widget.organization).onValue,
          builder: (BuildContext context, AsyncSnapshot<Event> snapshot){
              if(snapshot.connectionState ==ConnectionState.waiting){
                return LoadingList();
              }else{
                if(snapshot.hasData){
                  Map<dynamic, dynamic> values =snapshot.data.snapshot.value;
                  if(values!=null){
                    values.forEach((key, values){});
                     return ListView.builder(
                            key: Key(widget.orgname),
                            physics: BouncingScrollPhysics(),
                            itemCount: values.values.toList().length,
                            itemBuilder: (BuildContext context, int index){
                                if(values.values.toList()[index]['org_president_status'].toString().contains("Accepted") &&
                                values.values.toList()[index]['org_adviser_status'].toString().contains("Accepted") && 
                                values.values.toList()[index]['org_dean_status'].toString().contains("Pending")
                                ){
                                return Container(
                                padding: EdgeInsets.only(bottom: 20),
                                width: ScreenUtil.instance.setWidth(200),
                                child: Card(
                                elevation: 12.5,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                ),
                                color:Color(0xFFFF3345),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text("Name Of The Project: "+" "+values.values.toList()[index]['name_of_project'], style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Mops",
                                            fontWeight: FontWeight.w800,
                                            fontSize: ScreenUtil.instance.setSp(18))),
                                       Padding(padding: EdgeInsets.only(top: 10)),
                                          Text("Nature Of The Project: "+" "+values.values.toList()[index]['nature_of_project'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Mops',
                                          fontSize: ScreenUtil.instance.setSp(18),
                                          fontWeight: FontWeight.w800)), 
                                          Padding(padding: EdgeInsets.only(top: 10)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
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
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
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
                                      
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
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
                                    
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
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
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                               Padding(padding:EdgeInsets.only(left: 10),
                                               child: FlatButton(
                                                 color: Color(0xFFFF3345),
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(10),
                                                 ),
                                                    onPressed: (){
                                                        return Alert(
                                                        context: context,
                                                        type: AlertType.info,
                                                        title: "Approve this venue request? ",
                                                        buttons: [
                                                          DialogButton(
                                                            child: Text(
                                                              'Confirm', style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15,
                                                                fontFamily: 'Mops'
                                                              ),), 
                                                            onPressed: () async {
                                                              setState(() {
                                                                Navigator.pop(context);
                                                                FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                "org_dean_status": ""+"Accepted",
                                                                "org_dean": widget.fullname,
                                                                "status": "Accepted",
                                                                }).then((onValue){

                                                                });
                                                                
                                                              });
                                                            },
                                                            color: Color(0xFFFF3345),
                                                          ),
                                                        ],
                                                        closeFunction: () =>null,
                                                      ).show();
                                                    },
                                                    child: Text("Accept Reservation", style:  TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Mops",
                                                      fontSize: ScreenUtil.instance.setSp(18),
                                                    ),)
                                                 ), 
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 55),
                                                    child: FlatButton(
                                                      color: Color(0xFFFF3345),
                                                    shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    onPressed: ()async{
                                                        return Alert(
                                                        context: context,
                                                        type: AlertType.info,
                                                        title: "Reject this venue request? ",
                                                        buttons: [
                                                          DialogButton(
                                                            child: Text(
                                                              'Confirm', style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15,
                                                                fontFamily: 'Mops'
                                                              ),), 
                                                            onPressed: () async {
                                                              setState(() {
                                                                Navigator.pop(context);
                                                                FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                "org_dean_status": ""+"Rejected",
                                                                "org_dean": widget.fullname,
                                                                "status": "Rejected"
                                                                }).then((onValue){

                                                                });
                                                                
                                                              });
                                                            },
                                                            color: Color(0xFFFF3345),
                                                          ),
                                                        ],
                                                        closeFunction: () =>null,
                                                      ).show();
                                                    },
                                                    child: Text("Reject Reservation", style:  TextStyle(
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
                              );
                                }
                                
                              
                              
                              return Container();
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
    ), 
    onWillPop: ()async =>false,

      
    );
  }
}