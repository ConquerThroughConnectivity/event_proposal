

import 'package:firebase_database/firebase_database.dart';

class Organization{

String cas(){
String val;
FirebaseDatabase.instance.reference().child("OrganizationList").child("CAS").once().then((DataSnapshot snapshot) async{
        Map<dynamic, dynamic> values =await snapshot.value;
      if(values!=null){
        values.forEach((key,value){
            val =values["A"] +"\n" +values["B"] +"\n" +values["C"];
            
        });
      }
    });
    return val;
}

String cba(){
String val ="";
FirebaseDatabase.instance.reference().child("OrganizationList").child("CBA").once().then((DataSnapshot snapshot) async{
      Map<dynamic, dynamic> values =await snapshot.value;
      if(values!=null){
        values.forEach((key,value){
            val =values["A"] +"\n" +values["B"] +"\n" +values["C"] +"\n" +values["D"] +"\n" +values["E"] +"\n" +values["F"]+"\n" +values["G"];
           
        });
      }
    });
    return val;
}















}
