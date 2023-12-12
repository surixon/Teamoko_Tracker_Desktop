import 'dart:async';
import 'package:flutter/material.dart';

import 'loader.dart';


class BounceButton extends StatefulWidget{
  var isLoading;
  Function onPressed;
  String text;
  Color textColor ;
  Color color;
  double width;
  BounceButton({
    @required
    this.isLoading,
    @required
    this.onPressed,
    @required
    this.text,
    @required
    this.color,
    @required
    this.textColor,
  });

  @override
  _BounceButtonState createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton> with SingleTickerProviderStateMixin {

  double _scale;
  AnimationController _controller;
  loadingButton(){
    if(widget.isLoading){
      return Loader();
    }else{
      return Text(widget.text.toUpperCase(),style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: widget.textColor),);
    }
  }


  void _onTapDown(TapDownDetails details) {
    debugPrint("tap down");
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    debugPrint("tap up");

    _controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
      lowerBound: 0,
      upperBound: 0.1,
    )
      ..addListener(() { setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(

      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: (){
        debugPrint("tap cancel");
        _controller.reverse();
      },
      onTap: (){
        Timer(Duration(milliseconds: 250), (){
          widget.onPressed();
        });


      },

      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
              boxShadow:  [
                BoxShadow(
                  color: widget.color,
                  blurRadius: 1.0, // has the effect of softening the shadow
                  spreadRadius: 0.25, // has the effect of extending the shadow
                  offset: Offset(
                    0.5, // horizontal, move right 10
                    0.5, // vertical, move down 10
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(30)
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: widget.color,
            ),
            child: Center(child: loadingButton()),
          ),
        ),
      ),
    ) ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}