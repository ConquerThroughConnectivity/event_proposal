import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingList extends StatelessWidget {
  const LoadingList({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SpinKitPouringHourglass(
      color: Colors.white,
      size: 50.0,
    );
  }
}