import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:belajar_flutter/models/Note.dart';


class DatabaseHelper {

  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; //Singleton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDesciption = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper(){

    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database ==null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //GET path directory android and IOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notesku.db';

    //open or create database at path
    var noteDatabase = await openDatabase(path, version: 1, onCreate: _createDb);

    return noteDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(' CREATE TABLE $noteTable ('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT,'
        '$colDesciption TEXT,'
        '$colPriority INTEGER,'
        '$colDate TEXT)' );
  }

  //fetch : get all data note list
  Future<List<Map<String, dynamic>>> getNoteMapList() async{
    Database db = await this.database;

//    var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');

    return result;
  }

  //insert
  Future<int> insertNote(Note note) async{
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //update
  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  //delete
  Future<int> deleteNote(int id) async{
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  //get Jumlah data
  Future<int> getCount () async {
    Database db= await this.database;
    List<Map<String, dynamic>> x= await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();

    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for(int i=0; i<count; i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}