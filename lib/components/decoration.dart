import 'package:desk/utils/commom_colors.dart';
import 'package:flutter/material.dart';

class ViewDecoration{

  static TextStyle textStyleRegular(Color color,double textsize) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: textsize);
  }

  static TextStyle textStyleItalic(Color color,double textsize) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        fontSize: textsize);
  }
  static TextStyle textStyleSemiBold(Color color,double textsize) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: textsize);
  }

  static TextStyle textFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16);
  }

  static Widget buildCustomPrefixIcon(IconData iconData) {
    return Container(
      width: 0,
      alignment: Alignment(-0.99, 0.0),
      child: Icon(
        iconData,
      ),
    );
  }


  static InputDecoration inputDecoration (){
    return InputDecoration(
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: CommonColors.primaryColor,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4))
        )
    );

  }



  static InputDecoration inputDecorationAllRoundCorner(Color fillcolor,BorderRadius radius,String fieldname) {
    return InputDecoration(
        hintText: fieldname,
        filled: true,
        contentPadding: EdgeInsets.all(10.0),
        suffixIcon: Icon(Icons.search,color: CommonColors.primaryColor,),
        fillColor: fillcolor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: CommonColors.primaryColor, width: 1),
            borderRadius: radius),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey, width: 1),
          borderRadius: radius,),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: CommonColors.primaryColor, width: 1),
            borderRadius: radius));
  }

}