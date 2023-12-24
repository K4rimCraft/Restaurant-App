import 'package:flutter/material.dart';

class BookingTable {
  static List<int> _busyTables = [];
  static bool? isbook;
  static int? tableNumber;
  static int? numOfSeats;
  static DateTime? dateTime;
  static TimeOfDay? pickedHour;
  static TextEditingController? _tableName =
      TextEditingController(text: "Mohamed Gehad");
  static String? _date;
  static String? _startTime;
  static String? _endTime;
  static String? _name;

  static set setTables(List<int> tables) {
    _busyTables = tables;
  }

  static set setDate(String date) {
    _date = date;
  }

  static set setStartTime(String startTime) {
    _startTime = startTime;
  }

  static set setEndTime(String endTime) {
    _endTime = endTime;
  }

  static set setName(String name) {
    _name = name;
  }

  static String? get date {
    if (dateTime != null) {
      _date =
          "${dateTime!.year}-${dateTime!.month.toString().padLeft(2, '0')}-${dateTime!.day.toString().padLeft(2, '0')}";
    }
    return _date;
  }

  static String? get startTime {
    if (pickedHour != null) {
      _startTime =
          "${pickedHour!.hour.toString().padLeft(2, '0')}:${pickedHour!.minute.toString().padLeft(2, '0')}";
    }
    return _startTime;
  }

  static String? get endTime {
    if (pickedHour != null) {
      _endTime =
          "${((pickedHour!.hour + 1) == 24 ? 00 : pickedHour!.hour + 1).toString().padLeft(2, '0')}:${pickedHour!.minute.toString().padLeft(2, '0')}";
    }
    return _endTime;
  }

  static String? get name {
    if (_tableName != null) {
      _name = _tableName!.text;
    }
    return _name;
  }

  static void clear() {
    isbook = null;
    tableNumber = null;
    numOfSeats = null;
    dateTime = null;
    pickedHour = null;
    _tableName = null;
  }

  static bool isAvailable(int table) {
    for (int x in _busyTables) {
      if (table == x) return false;
    }
    return true;
  }
}
