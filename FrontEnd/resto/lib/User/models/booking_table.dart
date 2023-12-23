import 'package:flutter/material.dart';

class BookingTable{
  static List<int> _busyTables=[1,4,7,11,18];
  static bool? isbook;
  static int? tableNumber;
  static int? numOfSeats;
  static DateTime? dateTime;
  static TimeOfDay? pickedHour;
  static TextEditingController? _tableName = TextEditingController(text:"Mohamed Gehad");
  static String? _date;
  static String? _startTime;
  static String? _endTime;
  static String? _name;

  static String? get date{
    if(dateTime!=null){
      _date= "${dateTime!.day}-${dateTime!.month}-${dateTime!.year}";
    }
    return _date;
  }
  static String? get startTime{
    if(pickedHour!=null){
      _startTime= "${pickedHour!.hour}:${pickedHour!.minute}";
    }
    return _startTime;
  }
  static String? get endTime{
    if(pickedHour!=null){
      _endTime= "${pickedHour!.hour+1}:${pickedHour!.minute}";
    }
    return _endTime;
  }
  static String? get name{
    if(_tableName!=null){
      _name= _tableName!.text;
    }
    return _name;
  }

  static void clear(){
    isbook = null;
    tableNumber = null;
    numOfSeats = null;
    dateTime = null;
    pickedHour = null;
    _tableName = null;
  }

  static bool isAvailable(int table){
    for(int x in _busyTables){
      if(table == x)
        return false;
    }
    return true;
  }

}

