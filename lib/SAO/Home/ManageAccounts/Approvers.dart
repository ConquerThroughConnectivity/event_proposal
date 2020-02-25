
import 'package:event_proposal_admin/SAO/Home/ManageAccounts/Forms/EditForm.dart';
import 'package:event_proposal_admin/SAO/Home/home.dart';
import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;

class ApproversAccount extends StatefulWidget {
  @override
  _ApproversAccountState createState() => _ApproversAccountState();
}

class _ApproversAccountState extends State<ApproversAccount> {
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
        centerTitle: true,
        title: Text(
          "Approver Account List", style: TextStyle(
           fontFamily: "Mops",
           fontSize: ScreenUtil.instance.setSp(20), 
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
           Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home(), fullscreenDialog: true)); 
        }),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.reference().child("User").child("Approver").onValue,
              builder: (BuildContext context,AsyncSnapshot<Event> snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
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
                        return Card(
                          color: Color(0xFFECDFBD),
                          child: ExpansionTile(
                          trailing: Icon(Icons.arrow_drop_down, color: Colors.black,),
                          title: Text(values.keys.toList()[index],style: TextStyle(
                          fontFamily: 'Mops',
                          fontSize: 25,
                          fontWeight: FontWeight.w300
                          ),),  
                          children: <Widget>[
                            Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.10,
                            child: Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("Firstname: "+values.values.toList()[index]["firstname"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            ),
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("ID: "+values.values.toList()[index]["id"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("Lastname: "+values.values.toList()[index]["lastname"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("Middle Name: "+values.values.toList()[index]["middlename"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("Org name: "+values.values.toList()[index]["org_name"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("Organization Type: "+values.values.toList()[index]["org_type"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("Organization: "+values.values.toList()[index]["organization_type"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text("Password: "+values.values.toList()[index]["password"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                           
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            leading: Text("Update Account", style: TextStyle(
                              fontFamily: "Mops",
                              color: Colors.white,
                              fontSize: 20.0
                            ),),
                            trailing: IconButton(icon:Icon(Icons.arrow_forward_ios, color: Colors.white,), onPressed: (){
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => EditForm(schoolid: values.values.toList()[index]['id'], 
                              password: values.values.toList()[index]['password'],
                              firstname: values.values.toList()[index]['firstname'],
                              middlename: values.values.toList()[index]['middlename'],
                              lastname: values.values.toList()[index]['lastname'],
                              orgname: "Approver",
                              ),
                               fullscreenDialog: true));
                            }),
                            ), 
                            ),
                            
                            
                          ],
                          ),
                          );
                        
                      }
                      );
                    }
                  }
                }
                return LoadingList();
              }
              
              ),
              
            
          ),
          
        ],
      ),
    );
  }
}