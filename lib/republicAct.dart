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
                  child: Text("Indicating the purpose of the data gathered, who will process it, and when will the data be disposed.", style: TextStyle(
                    fontFamily: "Mops",
                    fontSize: 20,
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