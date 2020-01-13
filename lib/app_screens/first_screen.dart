import 'dart:math';

import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.lightBlue,
      child: Center(
        child: Text(
//          "Hi SIRI ${ generateRandomNumber() }",
          generateRandomNumber(),
          textDirection: TextDirection.ltr,
          style: TextStyle(backgroundColor: Colors.black, color: Colors.white),
        ),
      ),
    );
  }

  String generateRandomNumber(){
    var random = Random();
    int randomNumber = random.nextInt(10);
    return "Hi SIRI $randomNumber";
  }

}