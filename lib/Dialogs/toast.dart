import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Shows basic toast, black screen, length short
///@param String message
Future<void> basicToast(message) async {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}