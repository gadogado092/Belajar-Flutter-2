class Note{

  int _id;
  String _title;
  String _desc;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._desc]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._desc]);

  int get id => _id;

  String get title => _title;

  String get desc => _desc;

  int get priority => _priority;

  String get date=> _date;

  set title(String newTitle){
    if(newTitle.length<=255){
      this._title = newTitle;
    }
  }

  set desc(String newDesc){
    if(newDesc.length<=255){
      this._desc = newDesc;
    }
  }

  set priority(int newPriority){
    if(newPriority>=1 && newPriority<=2){
      this._priority = newPriority;
    }
  }

  set date(String newDate){
    this._date = newDate;
  }

  //convert object to map
  Map<String, dynamic> toMap(){
    //harus sama dengan nama coloumn tabel pada database
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _desc;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  //map to object

  Note.fromMapObject(Map<String, dynamic> map){
    //HARUS SAMA DGN NAMA KOLOM
    this._id = map['id'];
    this._title = map['title'];
    this._desc = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }

}