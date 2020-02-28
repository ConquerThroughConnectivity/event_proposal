import 'package:event_proposal_admin/SAO/Home/home.dart';
import 'package:event_proposal_admin/SAO/utilities/loading.dart';
import 'package:event_proposal_admin/SAO/utilities/loadingList.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<AnimatedListState> animatedList = new GlobalKey();
final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;

class OrganizationList extends StatefulWidget {
  final String id;
  OrganizationList({Key key, this.id}): super(key: key);
  @override
  _OrganizationListState createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {
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
          "Organization List", style: TextStyle(
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
            padding: EdgeInsets.only(bottom: 16, right: 16, left: 16, top: 16),
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.reference().child("OrganizationList").onValue,
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
                        if(values.keys.toList()[index].toString().contains("CAS")){
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
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text(values.values.toList()[index]["A"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["B"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["C"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),
                            
                            
                          ],
                          ),
                          );
                        }else if(values.keys.toList()[index].toString().contains("CBA")){
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
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text(values.values.toList()[index]["A"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["B"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["C"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["D"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["E"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["F"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["G"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),      
                            
                          ],
                          ),
                          );
                        }else if(values.keys.toList()[index].toString().contains("CFAD")){
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
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text(values.values.toList()[index]["A"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["B"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["C"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["D"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["E"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),     
                              
                            
                          ],
                          ),
                          );
                        }else if(values.keys.toList()[index].toString().contains("COE")){
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
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text(values.values.toList()[index]["A"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["B"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["C"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["D"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["E"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["F"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["G"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["H"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),          
                            
                          ],
                          ),
                          );
                        }else if(values.keys.toList()[index].toString().contains("Campus-Wide")){
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
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text(values.values.toList()[index]["A"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["B"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["C"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["D"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["E"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["F"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["G"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["H"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["I"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["J"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["K"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["L"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["M"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["N"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["O"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["P"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),                                 
                          ],
                          ),
                          );
                        }else if(values.keys.toList()[index].toString().contains("StudentCouncil")){
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
                            Card(
                              color: Color(0xFFFF3345),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                            title: Text(values.values.toList()[index]["A"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["B"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["C"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["D"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
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
                            title: Text(values.values.toList()[index]["E"],style: TextStyle(
                            fontFamily: 'Mops',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                              ),),
                            ), 
                            ),     
                              
                            
                          ],
                          ),
                          );
                        }
                          
                        
                          return Loading();
                      }
                      
                      );
                    }
                   
                  }
                  
                }
               return Loading();
              }
          
              ),
              
            
          ),
        ],
      ),
    );
  }
}