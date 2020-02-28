import 'package:flutter/material.dart';



class RepublicAct extends StatefulWidget {
  @override
  _RepublicActState createState() => _RepublicActState();
}

class _RepublicActState extends State<RepublicAct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 10.5,
        color: Colors.white,
        shape: RoundedRectangleBorder
        (borderRadius: BorderRadius.circular(10)

        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Note: Republic Act 10173 -Data Privacy Act 2012 ", style: TextStyle(
                    fontFamily: "Mops",
                    fontSize: 20,
                    color: Colors.redAccent
                  ),),
                  ),
                  Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text("The collection of data is for the purpose of creating event. By signing this form, you are certifying that all information provided is true and correct and likewise authorizing this office to process of your information. Your accomplished from will be kept in a secured database management nad will be disposed after one year.", style: TextStyle(
                    fontFamily: "Mops",
                    fontSize: 16,
                    color: Colors.black
                  ),),
                  ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}