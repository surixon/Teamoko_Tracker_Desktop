import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';


class RoundCornerShape extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final double radius;
  final Color strokeColor;

  const RoundCornerShape(
      { this.child,  this.bgColor,  this.radius,this.strokeColor=Colors.transparent});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler= new ScreenScaler()..init(context);
    return Container(
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius:scaler.getBorderRadiusCircular(radius),
              side: BorderSide(
                  color: strokeColor
              )
          ),
          color: bgColor,
          child: child,
        ));
  }
}
