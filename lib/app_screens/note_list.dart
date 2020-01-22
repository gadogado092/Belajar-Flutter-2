import 'dart:convert';

import 'package:belajar_flutter/app_screens/detail_list.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:belajar_flutter/models/Note.dart';
import 'package:belajar_flutter/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class NoteList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State{

  @override
  void initState(){
    super.initState();
//    showData();
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  Widget build(BuildContext context) {

    if(noteList==null){
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note('', '', 2),'Add Note');
//          debugPrint('FAB clicked');
        },

        tooltip: 'Add Note',

        child: Icon(Icons.add),
      ),
    );
  }



  ListView getNoteListView() {
    
    TextStyle tittleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList[position].priority),
              child: getPriorityIcon(noteList[position].priority),
            ),

            title: Text(noteList[position].title, style: tittleStyle,),

            subtitle: Text(noteList[position].date),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: (){
                _delete(context, noteList[position]);
              },
            ),


            onTap: (){
              navigateToDetail(this.noteList[position],'Edit Note');
//              debugPrint('Tap List');
            },

          ),
        );
      },
    );
    
  }

  Color getPriorityColor(int priority){
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority){
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async{
    int result = await databaseHelper.deleteNote(note.id);
    if(result !=0){
      _showSnackBar(context, 'Note Deleted Sukses');
      updateListView();
    }
  }

  void navigateToDetail(Note note, String title) async {
//    Navigator.push(context, MaterialPageRoute(builder: (context)
//    {
//      return NoteDetail(note, title);
//    }));
//biasa tanpa nilai kembali

    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return NoteDetail(note, title);
    }));

    if(result == true){
      updateListView();
    }

  }

  void _showSnackBar(BuildContext context, String s) {
    final snackBar = SnackBar(content: Text(s));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList){
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });

    });

  }

  void showData() async{
    debugPrint("===s");

    var r = await fetchPost();
    debugPrint("===s"+json.decode(r.body));
  }

  Future<http.Response> fetchPost() async{
    return http.get('https://jsonplaceholder.typicode.com/posts/1');
  }



}