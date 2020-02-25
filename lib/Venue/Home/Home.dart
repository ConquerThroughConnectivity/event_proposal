import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:event_proposal_admin/Approvers/Home/Home.dart';
import 'package:event_proposal_admin/SAO/Home/menul-button.dart';
import 'package:event_proposal_admin/Venue/Home/AcceptedEvent.dart';
import 'package:event_proposal_admin/Venue/Home/DeniedEven.dart';
import 'package:event_proposal_admin/Venue/Home/PendingEvent.dart';
import 'package:event_proposal_admin/Venue/Login/Login.dart';
import 'package:event_proposal_admin/Venue/calendar.dart';
import 'package:event_proposal_admin/globalEvents.dart';
import 'package:event_proposal_admin/globalEventsUpcoming.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;


bool isload=false;
String fullname;
String orgtype;
String name;
var cas;
class HomeVenue extends StatefulWidget {
  final String id;
  HomeVenue({Key key, this.id}) : super(key: key);
  @override
  _HomeVenueState createState() => _HomeVenueState();
}

class _HomeVenueState extends State<HomeVenue> with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    //getting the user ID and full name. 
    FirebaseDatabase.instance.reference().child("User").child("Venue").orderByChild("id").equalTo(widget.id).once().then((DataSnapshot dataSnapshot) async{
      Map<dynamic, dynamic> values =await dataSnapshot.value;
      if(values!=null){
        values.forEach((key, values){
          setState(() {
          isload =true;
          });
          fullname = values["id"]+", "+values["org_type"] +" Admin";
          orgtype =values["org_type"];
          name =values["firstname"]+", "+values["middlename"]+" "+values["lastname"];
          print(fullname);
          print(orgtype);
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

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);


    return WillPopScope(
      child: Scaffold(
       appBar: appbar(),
       drawer: drawer(),
       resizeToAvoidBottomPadding: false,
       backgroundColor:Colors.white,
       body: body(),

      ), 
      onWillPop: () async => false
      );
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
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        tabs:<Widget>[
          Tab(
            text: "Today's Event",
          ),
          Tab(
            text: "Upcoming Events",
          )
        ] 
    ),
    elevation: 1.5,
    actions: <Widget>[
      IconButton(
      icon: Icon(Icons.notifications), 
      onPressed: (){

      }),
    ],
  );
}

Widget body(){
  return TabBarView(
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
               Center(
                child: Container(
                width: ScreenUtil.instance.setWidth(275),
                child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                borderOnForeground: true,
                color: Color(0xFFFF3345),
                margin: EdgeInsets.only(
                ),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10),
                    child: Text(    
                    "Venue",textScaleFactor: 1.2, 
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
                      isload ? fullname : "",style: TextStyle(
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
              ),
              ),
            Padding(padding: EdgeInsets.only(top: 12)),   
            // MenuButton(
            //   icon: Icon(Icons.check), 
            //   text: "Accepted Event", 
            //   onPressed: (){
            //   // Navigator.push(context,MaterialPageRoute(builder: (context) => AcceptedEvent(orgname: orgtype,), fullscreenDialog: true));
            //   }),
            MenuButton(
              icon: Icon(Icons.info_outline), 
              text: "Pending Event", 
              onPressed: (){
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => PendingVenue(orgname: orgtype, fullname: name, id: widget.id), fullscreenDialog: true));
              }),  
            // MenuButton(
            //   icon: Icon(Icons.delete_outline), 
            //   text: "Rejected Event", 
            //   onPressed: (){
            //   // Navigator.push(context,MaterialPageRoute(builder: (context) => DeniedEvent(orgname: orgtype,), fullscreenDialog: true));
            //   }),
            MenuButton(
              icon: Icon(Icons.calendar_view_day), 
              text: "Calendar", 
              onPressed: (){
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => VenueCalendar(id: widget.id),fullscreenDialog: true));
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
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginVenue(), fullscreenDialog: true));                                          
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