
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:event_proposal_admin/Organization/Home/CreateEvent.dart';
import 'package:event_proposal_admin/Organization/Home/acceptedproposal.dart';
import 'package:event_proposal_admin/Organization/Home/calendar.dart';
import 'package:event_proposal_admin/Organization/Home/pendingEventProposal.dart';
import 'package:event_proposal_admin/Organization/Home/pendingproposal.dart';
import 'package:event_proposal_admin/Organization/Home/rejectedproposal.dart';
import 'package:event_proposal_admin/Organization/Login/Login.dart';
import 'package:event_proposal_admin/SAO/Home/menul-button.dart';
import 'package:event_proposal_admin/globalEvents.dart';
import 'package:event_proposal_admin/globalEventsUpcoming.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String inchargeType;
String incharge;
String fullname;
bool isload =false;
String orgtype;
String name;
String orgname;
class HomeOrganization extends StatefulWidget {
  final String id;
  HomeOrganization({Key key, this.id}) : super(key: key);

  @override
  _HomeOrganizationState createState() => _HomeOrganizationState();
}




class _HomeOrganizationState extends State<HomeOrganization>with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  TabController tabController;
  Widget callPages(int currentIndex, BuildContext context) {
    switch (currentIndex) {
      case 0:
        return body();
      default:
    }
  }

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    FirebaseDatabase.instance.reference().child("User").child("Organization").orderByChild("id").equalTo(widget.id).once().then((DataSnapshot dataSnapshot) async{
      Map<dynamic, dynamic> values =await dataSnapshot.value;
      if(values!=null){
        values.forEach((key, values){
          setState(() {
          isload =true;
          });
          fullname = values["org_type"]+", "+" "+values["org_name"];
          orgtype =values["org_type"];
          orgname =values["org_name"];
          name =values["firstname"]+", "+values["middlename"]+" "+values["lastname"];
          print(orgtype);
          print(orgname);
          print(widget.id);
          
      });
      }else{
        return;
      }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: appbar(),
      body: body(),
      drawer: drawer(),
    ), 
      onWillPop: () async => false,
    );
  }
  Widget botomBar() {
    return Container(
        child: BottomNavyBar(
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(Icons.event),
            title: Text('Events'),
            activeColor: Color(0xFFff726f)),
        BottomNavyBarItem(
            icon: Icon(Icons.calendar_view_day),
            title: Text('Calendar'),
            activeColor: Color(0xFF786fff)),
        
      ],
      onItemSelected: (index) => setState(() {
        selectedIndex = index;
      }),
      selectedIndex: selectedIndex,
      showElevation: true,
      backgroundColor: Colors.transparent,
    ));
  }


  Widget appbar(){
  return AppBar(
    bottom: TabBar(
      controller: tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 4.0,
      indicator: new BubbleTabIndicator(
        indicatorHeight: ScreenUtil.instance.setWidth(30.0),
        indicatorColor: Color(0xFFFF3345),
        indicatorRadius: 10.0,
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        tabs:<Widget>[
          Tab(
            text: "Today's Events",
          ),
          Tab(
            text: "Upcoming Events",
          )
        ] 
    ),
    elevation: 1.5,
    
    actions: <Widget>[
      // IconButton(
      // icon: Icon(Icons.notifications), 
      // onPressed: (){

      // }),
    ],
  );
}


  Widget body(){
  return Container(
    child: TabBarView(
    controller: tabController,
    children: [
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          today(),
        ],
      ),
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          upcoming(),
        ],
      ),
    ],
  ),   
  );
}

Widget today() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      new Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      ),
      borderOnForeground: true,
        clipBehavior: Clip.hardEdge,
        child: TodayEvents()
      ),
    ],
  );
}

Widget upcoming() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      new Card(
        elevation: 10.0,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      ),
      borderOnForeground: true,
      clipBehavior: Clip.hardEdge,
      child: UpcomingEvents()
      ),
    ],
  );
}
Widget drawer(){
  return Drawer(
    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        
        Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(padding: EdgeInsets.only(left: 13, right: 13, top: 40.0),
          child: Container(

          child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
               DrawerHeader(
                 decoration: BoxDecoration(
                   color: Color(0xFFFF3345)
                 ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           Center(
                        child: Text(    
                    "Organization",textScaleFactor: 1.2, textAlign: TextAlign.center, 
                    style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Mops",
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                  ),
                  ),  
                    ),
                    Center(
                      child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(child: 
                      Text(
                    
                      isload ? fullname : "",textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Mops",
                        fontWeight: FontWeight.w300,
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                      ),
                    ),
                    ),
                    Center(
                      child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(child: 
                      Text(
                      isload ? name : "",style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Mops",
                        fontWeight: FontWeight.w300,
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                      ),
                    ),
                    ),
                        ],
                      ),
                      ),
            Padding(padding: EdgeInsets.only(top: 12)),   
            MenuButton(
              icon: Icon(Icons.check), 
              text: "Accepted Proposal", 
              onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OrganizationAcceptedProposal(id: widget.id), fullscreenDialog: true));
              }),
            MenuButton(
              icon: Icon(Icons.info_outline), 
              text: "Pending Proposal", 
              onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OrganizationPending(id: widget.id,), fullscreenDialog: true));
              }),  
            MenuButton(
              icon: Icon(Icons.delete_outline), 
              text: "Rejected Proposal", 
              onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OrganizationRejected(id: widget.id,), fullscreenDialog: true));
              }),
             MenuButton(
              icon: Icon(Icons.calendar_today), 
              text: "Calendar", 
              onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OrganizationCalendar(id: widget.id,), fullscreenDialog: true));
              }),
              MenuButton(
              icon: Icon(Icons.event), 
              text: "Create Event", 
              onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => CreateEvent(id: widget.id, org: orgtype, orgname: orgname,), fullscreenDialog: true));
              }),
              MenuButton(
              icon: Icon(Icons.info), 
              text: "My Events", 
              onPressed: (){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => EventPendingProposal(id: widget.id, orgname: orgtype, org: orgname, name: name, ), fullscreenDialog: true));
              }),
              
    
              MenuButton(
              icon: Icon(Icons.exit_to_app), 
              text: "Logout", 
              onPressed: (){
               return Alert(
                 context: context,
                 type: AlertType.info,
                 title: "Are you sure you want to Logout?",
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
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginOrganization(), fullscreenDialog: true));                                          
                  });
                   },
                  color: Color(0xFFFF3345),
                 ),
                 ],
                 closeFunction: () =>null,
                ).show();
              }),
              ],
            ),
          ],
        )
      ),
          ),
    ),
        ),
      ],
    ),
  );

 
}
 
}