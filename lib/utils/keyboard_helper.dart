import 'package:flutter/material.dart';

abstract class KeyboardHelper {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
