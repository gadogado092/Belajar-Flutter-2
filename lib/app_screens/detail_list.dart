import 'package:belajar_flutter/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/models/Note.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priorities = ['Height', 'Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String appBarTitle;
  Note note;
  DatabaseHelper databaseHelper = DatabaseHelper();

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descController.text = note.desc;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(this.appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 15.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                      items: _priorities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem));
                      }).toList(),
                      style: textStyle,
                      
                      value: getPriorityAsString(note.priority),
                      
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          updatePriorityAsInt(valueSelectedByUser);
//                          debugPrint('select $valueSelectedByUser');
                        });
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
//                      debugPrint('change $value');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Judul',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDesc();
//                      debugPrint('change $value');
                    },
                    decoration: InputDecoration(
                        labelText: 'Descripsi',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
//                            debugPrint('Save');
                            _save();
                          });
                        },
                      )),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _delete();
                            debugPrint('Delete');
                          });
                        },
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);// nilai kembalian ke screen sebelumnya true
  }

  void updatePriorityAsInt(String value){
    switch (value){
      case 'Height':
        note.priority =1;
        break;
      case 'Low':
        note.priority =2;
        break;
    }
  }

  String getPriorityAsString(int value){
    String priority;
    switch (value){
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle(){
    note.title = titleController.text;
  }

  void updateDesc(){
    note.desc = descController.text;
  }

  void _save() async{

    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if(note.id != null){
      result = await databaseHelper.updateNote(note);
    }else{
      result = await databaseHelper.insertNote(note);
    }

    if(result!=0) {
      _showAlertDialog('Status', 'Note Saved');
    }else{
      _showAlertDialog('Status', 'Problem Save Note');
    }

  }

  void _delete() async{
    moveToLastScreen();

    if(note.id==null){
      _showAlertDialog('status', 'No Note to Delete');
      return;
    }

    int result = await databaseHelper.deleteNote(note.id);
    if(result !=0){
      _showAlertDialog('status', 'Note Deleted Sukses');
    }else{
      _showAlertDialog('status', 'Error Delete Note');
    }

  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context,
    builder: (_) => alertDialog
    );
  }



}
