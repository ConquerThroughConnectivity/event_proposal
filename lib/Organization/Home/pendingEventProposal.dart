import 'package:empty_widget/empty_widget.dart';
import 'package:event_proposal_admin/Organization/Home/Home.dart';
import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:progress_button/progress_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;
bool isEnable =false;
bool isWide =true;
bool isload=false;
String date =DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
class EventPendingProposal extends StatefulWidget {
  final String id;
  final String orgname;
  final String org;
  final String name;
  EventPendingProposal({Key key, this.id, this.orgname, this.org, this.name}) : super(key: key);
  @override
  _EventPendingProposalState createState() => _EventPendingProposalState();
}

class _EventPendingProposalState extends State<EventPendingProposal> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    FirebaseDatabase database =FirebaseDatabase(databaseURL: "https://event-proposal.firebaseio.com/");
    database.setPersistenceEnabled(true);

    if(widget.orgname.contains("Campus-Wide")){
      isWide =false;
    }else{
      isWide =true;
    }

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
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>HomeOrganization(id: widget.id.toString(),), fullscreenDialog: true));
            });
          }),
        title: Text(
          "My Events", style: TextStyle(
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
          stream: FirebaseDatabase.instance.reference().child("Venue").child("VenueReservation").orderByChild('id').equalTo(widget.id).onValue,
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
                                return SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 20),
                               
                                width: ScreenUtil.instance.setWidth(200),
                                child: Card(
                                elevation: 15.5,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xFFFF3345),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
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
                                       Card(
                                        color: Colors.white,
                                        elevation: 10.0,
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
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.description, color: Colors.black,),
                                          title: Text("Description: "+" "+values.values.toList()[index]['description'], style: TextStyle(
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
                                      Padding(padding: EdgeInsets.only(top: 30)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_pin, color: Colors.black,),
                                          title: Text("Approver: "+" "+values.values.toList()[index]['approver_name'], style: TextStyle(
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
                                          title: Text("In-Charge Validation: "+" "+values.values.toList()[index]['incharge'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          trailing: Text("Approver Validation: "+" "+values.values.toList()[index]['approver'], style: TextStyle(
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
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
                                          title: Text("In Charge Name: "+" "+values.values.toList()[index]['name_incharge'], style: TextStyle(
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
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
                                          title: Text("Approver Name: "+" "+values.values.toList()[index]['name_approver'], style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                          

                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 30)),
                                      Card(
                                        color: Colors.white,
                                        elevation: 10.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0)),
                                          child: ListTile(
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
                                          title: Text("Organization President: "+" "+values.values.toList()[index]['org_president'], style: TextStyle(
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
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
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
                                          child: ListTile(
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
                                          title: Text("Organization Adviser: "+" "+values.values.toList()[index]['org_adviser'], style: TextStyle(
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
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
                                          title: Text("Organization Adviser Status: "+" "+values.values.toList()[index]['org_adviser_status'], style: TextStyle(
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
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
                                          title: Text("Organization Dean: "+" "+((isWide ? values.values.toList()[index]['org_dean']:"Not Applicable")) , style: TextStyle(
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
                                          leading: Icon(Icons.person_outline, color: Colors.black,),
                                          title: Text("Organization Dean Status: "+" "+((isWide ? values.values.toList()[index]['org_dean_status']:"Not Applicable")), style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mops",
                                            fontSize: ScreenUtil.instance.setSp(15))),
                                            
                                        ),
                                      ),   
                                       
                                                                          
                                      
                                      
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.1, right: 4.1, bottom: 8, top: 5),
                                      child: ProgressButton(
                                      buttonState: ButtonState.inProgress,
                                      child: Text('Propose this Proposal', style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Mops",
                                      fontSize: ScreenUtil.instance.setSp(20),
                                      ),
                                      ),
                                      backgroundColor: Colors.white, 
                                      onPressed: () async {
                                        if(values.values.toList()[index]['status'].toString().contains('Pending')){
                                          setState(() {
                                            isload =true;
                                          });
                                                  popupInvalid("Cannot Propose to SAO", "Pending Approval");

                                                }else if(values.values.toList()[index]['status'].toString().contains('Denied')){
                                                  setState(() {
                                                  isload =true;
                                                  });
                                                  popupInvalid("Cannot Propose to SAO", "Rejected Approval");
                                                }else if(values.values.toList()[index]['status'].toString().contains('Accepted')){ 
                                                    FirebaseDatabase.instance.reference().child("SAO").child("Proposal").orderByChild("id").equalTo(widget.id).once().
                                                    then((DataSnapshot snapshot) async{
                                                    Map<dynamic, dynamic> val =await snapshot.value;
                                                    if(val==null){
                                                      if(widget.orgname.contains("Campus-Wide")){
                                                            FirebaseDatabase.instance.reference().child("SAO").child("Proposal").push().set({
                                                          "name_of_project": values.values.toList()[index]['name_of_project'],
                                                          "nature_of_project": ""+values.values.toList()[index]['nature_of_project'],
                                                          "committee_in_charge": values.values.toList()[index]['committee_in_charge'],
                                                          "venue": values.values.toList()[index]['venue'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "time_to": values.values.toList()[index]['time_to'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "beneficiaries": values.values.toList()[index]['beneficiaries'],
                                                          "prepared_by": widget.name,
                                                          "noted_by_adviser":values.values.toList()[index]['org_adviser'],
                                                          "noted_by_org_president": values.values.toList()[index]['org_president'],
                                                          "org_type": widget.orgname,
                                                          "org_name": widget.org,
                                                          "date": values.values.toList()[index]['date'],
                                                          "status": "Pending",
                                                          'id': widget.id,
                                                          'date_of_event': values.values.toList()[index]['date_of_event'],
                                                          'description': values.values.toList()[index]['description']
                                                          });
                                                          popupInvalid("Success Wait for Approval", "Pending Approval");
                                                          }else{
                                                            FirebaseDatabase.instance.reference().child("SAO").child("Proposal").push().set({
                                                          "name_of_project": values.values.toList()[index]['name_of_project'],
                                                          "nature_of_project": ""+values.values.toList()[index]['nature_of_project'],
                                                          "committee_in_charge": values.values.toList()[index]['committee_in_charge'],
                                                          "venue": values.values.toList()[index]['venue'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "time_to": values.values.toList()[index]['time_to'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "beneficiaries": values.values.toList()[index]['beneficiaries'],
                                                          "prepared_by": widget.name,
                                                          "noted_by_adviser":values.values.toList()[index]['org_adviser'],
                                                          "noted_by_org_president": values.values.toList()[index]['org_president'],
                                                          "recommending_approval": values.values.toList()[index]['org_dean'],
                                                          "org_type": widget.orgname,
                                                          "org_name": widget.org,
                                                          "date": values.values.toList()[index]['date'],
                                                          "status": "Pending",
                                                          'id': widget.id,
                                                          'date_of_event': values.values.toList()[index]['date_of_event'],
                                                          'description': values.values.toList()[index]['description']
                                                          });
                                                          popupInvalid("Success Wait for Approval", "Pending Approval");
                                                          }
                                                    }else{
                                                      val.forEach((key, value){
                                                        if(value['date'].toString().contains(values.values.toList()[index]['date']) &&
                                                        value['name_of_project'].toString().contains(values.values.toList()[index]['name_of_project']) &&
                                                        value['nature_of_project'].toString().contains(values.values.toList()[index]['nature_of_project']) &&
                                                        value['venue'].toString().contains(values.values.toList()[index]['venue'])){
                                                            popupInvalid("This proposal already propose", "Pending Approval");
                                                        }else{
                                                          if(widget.orgname.contains("Campus-Wide")){
                                                            FirebaseDatabase.instance.reference().child("SAO").child("Proposal").push().set({
                                                          "name_of_project": values.values.toList()[index]['name_of_project'],
                                                          "nature_of_project": ""+values.values.toList()[index]['nature_of_project'],
                                                          "committee_in_charge": values.values.toList()[index]['committee_in_charge'],
                                                          "venue": values.values.toList()[index]['venue'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "time_to": values.values.toList()[index]['time_to'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "beneficiaries": values.values.toList()[index]['beneficiaries'],
                                                          "prepared_by": widget.name,
                                                          "noted_by_adviser":values.values.toList()[index]['org_adviser'],
                                                          "noted_by_org_president": values.values.toList()[index]['org_president'],
                                                          "org_type": widget.orgname,
                                                          "org_name": widget.org,
                                                          "date": values.values.toList()[index]['date'],
                                                          "status": "Pending",
                                                          'id': widget.id,
                                                          'date_of_event': values.values.toList()[index]['date_of_event'],
                                                          'description': values.values.toList()[index]['description']
                                                          });
                                                          popupInvalid("Success Wait for Approval", "Pending Approval");
                                                          }else{
                                                            FirebaseDatabase.instance.reference().child("SAO").child("Proposal").push().set({
                                                          "name_of_project": values.values.toList()[index]['name_of_project'],
                                                          "nature_of_project": ""+values.values.toList()[index]['nature_of_project'],
                                                          "committee_in_charge": values.values.toList()[index]['committee_in_charge'],
                                                          "venue": values.values.toList()[index]['venue'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "time_to": values.values.toList()[index]['time_to'],
                                                          "time_from": values.values.toList()[index]['time_from'],
                                                          "beneficiaries": values.values.toList()[index]['beneficiaries'],
                                                          "prepared_by": widget.name,
                                                          "noted_by_adviser":values.values.toList()[index]['org_adviser'],
                                                          "noted_by_org_president": values.values.toList()[index]['org_president'],
                                                          "recommending_approval": values.values.toList()[index]['org_dean'],
                                                          "org_type": widget.orgname,
                                                          "org_name": widget.org,
                                                          "date": values.values.toList()[index]['date'],
                                                          "status": "Pending",
                                                          'id': widget.id,
                                                          'date_of_event': values.values.toList()[index]['date_of_event'],
                                                          'description': values.values.toList()[index]['description']
                                                          });
                                                          popupInvalid("Success Wait for Approval", "Pending Approval");
                                                          }
                                                        }
                                                      
                                                    });
                                                    }
                                                    
                                                    


                                                  });
                                                  

                                                 
                                                  
                                                }
                                                
                                      }
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
                  return new EmptyListWidget(
                  title: 'No Data',
                  subTitle: 'No Pending Proposal yet',
                  packageImage: PackageImage.Image_2,
                  titleTextStyle: Theme.of(context).typography.dense.display1.copyWith(color: Color(0xff9da9c7)),
                  subtitleTextStyle: Theme.of(context).typography.dense.body2.copyWith(color: Color(0xffabb8d6))
                );
                }

              }
              return LoadingList();
              
          }
          
          ),
      ),
    );
    
  }

  void save(){
    
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