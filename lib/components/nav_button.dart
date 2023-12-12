
// @dart=2.9
import 'package:desk/utils/commom_colors.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
NavigationRailDestination NavButton({String iconPath, String label,String counter}) {
  return NavigationRailDestination(
    icon: ImageIcon(AssetImage(iconPath), size: 24),
    selectedIcon: ImageIcon(
      AssetImage(iconPath),
      size: 24,
      color: MaterialColor(0xFFf3396a, CommonColors.color),
    ),
    label: Container(
      width: 220,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          ( counter!=null && counter.isNotEmpty)?Container(
            width: 20,
            height: 20,
            child: CircleAvatar(
                backgroundColor: CommonColors.primaryColor,
                child: Wrap(
                  children: [
                    Center(
                      child:Wrap(
                        children: [
                          Text(
                            counter,
                            style: TextStyle(color:Colors.white,fontWeight: FontWeight.normal,fontSize: 9),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ):Container(),])
    ),
  );
}
