import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
      color: Color.fromRGBO(50, 62, 72, 1.0),
    ),
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

MaterialButton longButtons(String title, Function action,
    {Color color: Colors.blue, Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: action(action),
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),height: 45,minWidth: 600,shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

Function action(Function action) => action;
