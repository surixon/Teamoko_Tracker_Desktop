import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DialogHelper {
  static final border = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );


  static Future showDialogWithTwoButtons(
    BuildContext context,
    String title,
    String content, {
    String positiveButtonLabel = "Yes",
    VoidCallback positiveButtonPress,
    String negativeButtonLabel = "No",
    VoidCallback negativeButtonPress,
    barrierDismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: Text(content,textAlign: TextAlign.center),
          shape: border,
          actions: <Widget>[
            TextButton(
              child: Text(negativeButtonLabel),
              //textColor: Colors.black87,
              onPressed: () {
                if (negativeButtonPress != null) {
                  negativeButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            ),
            TextButton(
              child: Text(positiveButtonLabel),
              onPressed: () {
                if (positiveButtonPress != null) {
                  positiveButtonPress();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            )
          ],
        );
      },
    );
  }
  static showMessage(BuildContext context,String message){
    Toast.show(message, context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  }
}
