import 'package:event_proposal_admin/Approvers/Home/Home.dart';
import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isWide =true;
String adviser;
class ApproverPending extends StatefulWidget {
  final String orgtype;
  final String orgname;
  final String organization;
  final String fullname;
  ApproverPending({Key key, this.orgtype, this.orgname,this.organization, this.fullname}): super(key :key);
  @override
  _ApproverPendingState createState() => _ApproverPendingState();
}

class _ApproverPendingState extends State<ApproverPending> {
  @override
  void initState() {
    FirebaseDatabase database =FirebaseDatabase(databaseURL: "https://event-proposal.firebaseio.com/");
    database.setPersistenceEnabled(true);

    if(widget.organization.contains("Campus-Wide")){
      isWide =false;
    }else{
      isWide =true;
    }

    if(widget.orgtype.contains("Adviser")){
      adviser ="org_adviser_status";
    }else if(widget.orgtype.contains("Organization President")){
      adviser ="org_president_status";
    }
    print(widget.orgname);
    print(widget.organization);
    print(widget.fullname);
    print(widget.orgtype);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), 
          onPressed: (){
            setState(() {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeApprovers(), fullscreenDialog: true));
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
                            physics: BouncingScrollPhysics(),
                            itemCount: values.values.toList().length,
                            itemBuilder: (BuildContext context, int index){
                              if(values.values.toList()[index]["approver"].toString().contains("Accepted") ){
                                if(values.values.toList()[index][adviser].toString().contains("Pending")){
                                if(values.values.toList()[index]['org_name'].toString().contains(widget.orgname)){
                                  return Container(
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
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Approver Status: "+" "+values.values.toList()[index]['approver'], style: TextStyle(
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
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Comittee Incharge Status: "+" "+values.values.toList()[index]['incharge'], style: TextStyle(
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
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Adviser Status: "+" "+values.values.toList()[index]['org_adviser_status'], style: TextStyle(
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
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Organization Dean Status: "+" "+((isWide ? values.values.toList()[index]['org_dean_status']:"Not Applicable")), style: TextStyle(
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
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Organization President Status: "+" "+values.values.toList()[index]['org_president_status'], style: TextStyle(
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
                                                                
                                                                  if(widget.orgtype.contains("Adviser") && isWide ==false){
                                                                    FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                    "org_adviser": ""+widget.fullname,
                                                                    "org_adviser_status": ""+"Accepted",
                                                                    "status": "Accepted",
                                                                    }).then((onValue){

                                                                    });
                                                                    
                                                                  }else if(widget.orgtype.contains("Adviser")){
                                                                    FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                    "org_adviser": ""+widget.fullname,
                                                                    "org_adviser_status": ""+"Accepted"
                                                                    }).then((onValue){

                                                                    });
                                                                 
                                                                  }
                                                                
                                                                else if(widget.orgtype.contains("Organization President")){
                                                                FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                "org_president": ""+widget.fullname,
                                                                "org_president_status": ""+"Accepted",
                                                                }).then((onValue){

                                                                });

                                                                }else if(widget.organization.contains("Campus-Wide") && widget.orgtype.contains("Adviser") ){
                                                                FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                "org_president": ""+widget.fullname,
                                                                "org_president_status": ""+"Accepted",
                                                                "status": "Accepted",
                                                                }).then((onValue){

                                                                });

                                                                }
                                                                
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
                                                                if(widget.orgtype.contains("Adviser")){
                                                                FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                "org_adviser": ""+widget.fullname,
                                                                "org_adviser_status": ""+"Rejected"
                                                                }).then((onValue){

                                                                });
                                                                }else if(widget.orgtype.contains("Organization President")){
                                                                FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").child(values.keys.toList()[index]).update({
                                                                "org_president": ""+widget.fullname,
                                                                "org_president_status": ""+"Rejected",
                                                                }).then((onValue){

                                                                });

                                                                }
                                                                
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
                              
                              }
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
    );
  }
}