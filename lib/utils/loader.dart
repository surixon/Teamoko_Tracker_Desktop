import 'package:flutter/material.dart';

class Loader extends StatelessWidget{
  String text="";
  Loader(){
    this.text = "";
  }
  Loader.withText(this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            backgroundColor: Colors.grey.shade200,
          ),
        ),
        text.length>0 ? SizedBox(height: 16,) : Container(),
        text.length>0 ? Text(this.text,style: TextStyle(color: Colors.grey.shade700),) : Container()
      ],
    );
  }

}