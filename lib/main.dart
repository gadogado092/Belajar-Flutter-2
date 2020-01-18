import 'package:flutter/material.dart';
import 'app_screens/first_screen.dart';
import 'app_screens/home.dart';
import 'app_screens/note_list.dart';
import 'app_screens/detail_list.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Note',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: NoteList(),

    );

  }

}














//calculator

void main3() {
  runApp(MaterialApp(
    title: "Stateful Example",
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),
  ));
}






class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
//  var _currenCities = ['Rp','Dollar','Pounds', 'Others'];
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rp', 'Dollar', 'Pounds', 'Others'];
  var _currentItemSelected = '';
  final _minimumPadding = 5.0;
  var displayResult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Calculator"),
      ),

      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: principalController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Principal",
                          hintText: 'Masukkan Prinsipal',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: roiController,
                      decoration: InputDecoration(
                          labelText: "Rate of Interest",
                          hintText: 'Dalam Persen',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: 'Dalam Persen',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        _onDropdownSelected(newValueSelected);
                      },
                      value: _currentItemSelected,
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text('Hitung'),
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState.validate()){
                              displayResult = _calculateTotal();
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Clear'),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/cash.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
    );
  }

  void _onDropdownSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotal() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double total = principal + (principal * roi * term) / 100;

    String result =
        "After $term  years, your investment will be worth $total $_currentItemSelected";

    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String nameCity = "";
  var _currencies = ['Rp', 'Dollar', 'Pounds', 'Others'];
  var _currentItemSelected = 'Rp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String userInput) {
                setState(() {
                  nameCity = userInput;
                });
              },
            ),
            DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                _onDropdownSelected(newValueSelected);
              },
              value: _currentItemSelected,
            ),
            Text(
              "Name = $nameCity",
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  void _onDropdownSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}

void main2() {
  runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
    title: "Explore",
    home: Scaffold(
      appBar: AppBar(
        title: Text("Long List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
        tooltip: "Tambah Item", //long click view
      ),
      body: getListW(),
    ),
  ));
}

void showSnackBar(BuildContext context, String listItem) {
  var snackBar = SnackBar(
    content: Text("You Just Tap $listItem"),
    action: SnackBarAction(
        label: "Back",
        onPressed: () {
          debugPrint("Back To Laptop");
        }),
  );

  Scaffold.of(context).showSnackBar(snackBar);
}

List<String> getList() {
  var items = List<String>.generate(1000, (counter) => "Item $counter");
  return items;
}

Widget getListW() {
  var listItems = getList();

  var listView = ListView.builder(itemBuilder: (context, index) {
    return ListTile(
        title: Text(listItems[index]),
        onTap: () {
          showSnackBar(context, listItems[index]);
        });
  });
  return listView;
}

//basic/simple list
Widget getListView() {
  var listView = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text("Perbaikan AC"),
        subtitle: Icon(Icons.image),
        onTap: () {
          debugPrint("ACb");
        },
      ),
      ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text("Perbaikan AC2"),
      ),
      ListTile(
        title: Text("Perbaikan AC3"),
        subtitle: Icon(Icons.image),
      ),
      Text("Yet"),
      Container(
        color: Colors.red,
        height: 25.0,
      )
    ],
  );

  return listView;
}
//void main() =>
//  runApp(
//    MyApp2()
//  );

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "APP ASSISTENT",
        home: Scaffold(
            appBar: AppBar(
              title: Text("HOME SIRI"),
            ),
            body: FirstScreen()));
  }
}

class MyApp3 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
