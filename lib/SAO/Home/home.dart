import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:event_proposal_admin/Approvers/Signup/Signup.dart';
import 'package:event_proposal_admin/Organization/Signup/Signup.dart';
import 'package:event_proposal_admin/SAO/Home/ManageAccounts/Approvers.dart';
import 'package:event_proposal_admin/SAO/Home/ManageAccounts/Organization.dart';
import 'package:event_proposal_admin/SAO/Home/ManageAccounts/Venue.dart';
import 'package:event_proposal_admin/SAO/Home/ManageAccounts/VenueApprover.dart';
import 'package:event_proposal_admin/SAO/Home/acceptedproposal.dart';
import 'package:event_proposal_admin/SAO/Home/menul-button.dart';
import 'package:event_proposal_admin/SAO/Home/organizationList.dart';
import 'package:event_proposal_admin/SAO/Home/pendingrequest.dart';
import 'package:event_proposal_admin/SAO/Home/rejectedproposal.dart';
import 'package:event_proposal_admin/SAO/Login/login.dart';
import 'package:event_proposal_admin/SAO/Signup/signup.dart';
import 'package:event_proposal_admin/SAO/calendar.dart';
import 'package:event_proposal_admin/Venue/Signup/Signup.dart';
import 'package:event_proposal_admin/choose.dart';
import 'package:event_proposal_admin/globalEvents.dart';
import 'package:event_proposal_admin/globalEventsUpcoming.dart';
import 'package:event_proposal_admin/organizationList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:spring_button/spring_button.dart';



final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;

Organization organization = new Organization();

bool isload=false;
String fullname;
var cas;
class Home extends StatefulWidget {
  final String id;
  Home({Key key, this.id}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
  
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  
  TabController tabController;
  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    //getting the user ID and full name. 
    FirebaseDatabase.instance.reference().child("User").child("Sao").orderByChild("id").equalTo(widget.id).once().then((DataSnapshot dataSnapshot) async{
      Map<dynamic, dynamic> values =await dataSnapshot.value;
      if(values!=null){
        values.forEach((key, values){
          setState(() {
          isload =true;
          });
          fullname = values["firstname"]+" "+" "+values["lastname"];
          print(fullname);
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


    return WillPopScope(child: Scaffold(
       appBar: appbar(),
       drawer: drawer(),
       resizeToAvoidBottomPadding: false,
       backgroundColor:Colors.white,
       body: body(),
    ), 
    onWillPop: () async=> false,
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
               DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFFFF3345),
                        
                      ),
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 10),
                          child: AutoSizeText(    
                          "SAO ADMIN",textScaleFactor: 1.2, 
                          style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Mops",
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                          fontStyle: FontStyle.normal,
                        ),
                        ),  
                          ),
                    Padding(
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
                          ],
                        )                  
                      ),
            Padding(padding: EdgeInsets.only(top: 12)),   
            MenuButton(
              icon: Icon(Icons.check), 
              text: "Accepted Proposal", 
              onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SaoAccepted(), fullscreenDialog: true)); 
              }),
            MenuButton(
              icon: Icon(Icons.info_outline), 
              text: "Pending Proposal", 
              onPressed: (){
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SaoPending(), fullscreenDialog: true)); 
              }),  
            MenuButton(
              icon: Icon(Icons.delete_outline), 
              text: "Rejected Proposal", 
              onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SaoRejected(), fullscreenDialog: true)); 
              }),
              MenuButton(
              icon: Icon(Icons.list), 
              text: "Organization List", 
              onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OrganizationList(), fullscreenDialog: true)); 
              }),
              MenuButton(
              icon: Icon(Icons.supervisor_account), 
              text: "Manage Account", 
              onPressed: (){
                setManageAccount(context);
              }),
               MenuButton(
              icon: Icon(Icons.calendar_today), 
              text: "Calendar", 
              onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SaoCalendar(id: widget.id,), fullscreenDialog: true)); 
              }),
              MenuButton(
              icon: Icon(Icons.account_box), 
              text: "Register Accounts", 
              onPressed: (){
                  setBottomSheet(context);
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
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginSao(), fullscreenDialog: true));                                          
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
Widget card(String title, BuildContext context, Color color) {
  return Stack(
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20, bottom: 20),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: ScreenUtil.instance.setWidth(380),
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.bold),
        ),
      ),
      Positioned(
        top: -15,
        left: -20,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: ClipRRect(
            borderRadius: BorderRadius.only(),
            child: Align(
                alignment: Alignment.topLeft,
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  height: 20,
                  width: 30,
                )),
          ),
        ),
      ),
    ],
  );

}
void setBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          width: 450,
          color: Color(0xFF121621),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: ScreenUtil.instance.setWidth(20)),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                         SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Organization Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignupOrganization(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Approvers Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                   Navigator.push(context,MaterialPageRoute(builder: (context) => ApproverSignup(), fullscreenDialog: true)); 
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Venue Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignupVenue(), fullscreenDialog: true));
                                },
                                ),
                                
                        ],
                      ),
                      ),
                    ),
                  )
                ],
              )),
        );
      });
      

}
void setManageAccount(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          width: 450,
          color: Color(0xFF121621),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(top: ScreenUtil.instance.setWidth(20)),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                         SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Organization Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => OrganizationAccount(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Approvers Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                   Navigator.push(context,MaterialPageRoute(builder: (context) => ApproversAccount(), fullscreenDialog: true)); 
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('Venue Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => VenueAccount(), fullscreenDialog: true));
                                },
                                ),
                                SpringButton(
                                SpringButtonType.OnlyScale,
                                card('VenueApprovers Account', context, Color(0xFFFF3345)),
                                onTapDown: (_) {},
                                onLongPressEnd: (_) {},
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => VenueApproverAccount(), fullscreenDialog: true));
                                },
                                ),
                                
                        ],
                      ),
                      ),
                    ),
                  )
                ],
              )),
        );
      });
      

}


}