import 'package:belajar_flutter/app_screens/detail_list.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget{

  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State{
  int count = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail('Add Note');
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
              backgroundColor: Colors.yellow,
              child: Icon(Icons.arrow_right),
            ),

            title: Text('Dummy Title', style: tittleStyle,),

            subtitle: Text('Dummny Date'),

            trailing: Icon(Icons.delete, color: Colors.grey,),

            onTap: (){
              navigateToDetail('Edit Note');
//              debugPrint('Tap List');
            },

          ),
        );
      },
    );
    
  }

  void navigateToDetail(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return NoteDetail(title);
    }));
  }
}