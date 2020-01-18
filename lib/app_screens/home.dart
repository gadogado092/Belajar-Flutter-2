import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.only(top: 40.0, left: 10.0),
      child: Column(
        children: <Widget>[
          Row( children: <Widget>[
            Expanded(
                child: Text("Lion Air",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 30.0,
                        decoration: TextDecoration.none))),
            Expanded(
                child: Text("Makassar ke Jakarta",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 20.0,
                      decoration: TextDecoration.none,
                    )))
          ],),
          Row( children: <Widget>[
            Expanded(
                child: Text("Garuda Air",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 30.0,
                        decoration: TextDecoration.none))),
            Expanded(
                child: Text("Jakarta ke Kuala Lumpur",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 20.0,
                      decoration: TextDecoration.none,
                    )))
          ],),
          PenerbanganImageAsset(),
          PenerbanganButton()
        ],
      ),
    ));
  }
}

class PenerbanganImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/transportation.png');
    Image image = Image(image: assetImage);
    return Container (child: image,  width: 100.0, height: 100.0,);
  }

}

class PenerbanganButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      padding: EdgeInsets.all(10.0),
      child: RaisedButton(
          color: Colors.deepOrange,
          elevation: 6.0,
          child: Text('Pesan Sekarang', style: TextStyle(color: Colors.white),),
          onPressed: () =>
            //action
            pesan(context)
          ),
    );
  }

  void pesan(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Sukses"),
      content: Text("Selamat Berlibur"),
    );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }

}


//        margin: EdgeInsets.all(20.0),
//        margin: EdgeInsets.only(left : 20.0, top: 40.0),

//#TEXT
//        child: Text(
//          "Penerbangan",
//          textDirection: TextDirection.ltr,
//          style: TextStyle(
//            decoration: TextDecoration.none,
//            fontSize: 75.0,
//            fontFamily: 'Raleway',
//            fontWeight: FontWeight.w900,
//            fontStyle: FontStyle.italic,
//            color: Colors.white
//          ),
//        ),
//        width: 200.0,
//        height: 100.0,

//      ),
//    );
//#Container
//      Container(
//      alignment: Alignment.center,
//      color: Colors.deepPurple,
//      child: Text("Penerbangan", textDirection: TextDirection.ltr ),
//      );

//  }

//}
