import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final double defaultScreenWidth = 420.0;
final double defaultScreenHeight = 820.0;

class MenuButton extends StatelessWidget {
  MenuButton({@required this.icon, @required this.text, @required this.onPressed});
  final void Function() onPressed;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Material(
      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil.instance.setWidth(5)),
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: Color(0xFFFF3345),
          elevation: 3,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      ),
                      Icon(
                        icon.icon,
                        size: 32,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      AutoSizeText(text,
                      style: TextStyle(
                        fontFamily: "Mops",
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),
                      minFontSize: 8,
                      maxLines: 1,
                      ),
                      Spacer(),
                      Padding(padding: EdgeInsets.only(right: ScreenUtil.instance.setWidth(16)),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.white,
                        ),
                      ),
                  ],
                ),
                ),
            ),
          ),
        ),

        ),
    );
  }
}