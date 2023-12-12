
import 'package:flutter/material.dart';


class AppBottomBar extends StatefulWidget {
  const AppBottomBar({ Key key}) : super(key: key);

  _AppBottomBarState createState()=> _AppBottomBarState();

}

class _AppBottomBarState extends State<AppBottomBar>{
  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        ],
      ),
    );
  }
}
