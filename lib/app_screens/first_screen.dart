import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

//    var response= fetchPost();
//    response.then((data){
//      debugPrint("==="+data.)
//    });
    getData();
    return "Hi SIRI $randomNumber";
  }

  Future getData() async {
    http.Response response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
    debugPrint("==="+response.body);
  }

}