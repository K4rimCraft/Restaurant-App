import 'package:http/http.dart' as http;
import 'package:resto/Admin/Overview/API.dart';
import 'package:resto/User/models/booking_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food.dart';
import '../models/Order_list.dart';
import 'dart:convert';
import '/main.dart';

class APIStatus {
  int statusCode;
  String message;

  APIStatus({required this.statusCode, required this.message});
}

Future<List<int>> getBusyTables() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('$serverUrl/api/getBusyTables'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body: jsonEncode(<String, String>{
      'date': BookingTable.date ?? '',
      'startTime': BookingTable.startTime ?? '',
      'endTime': BookingTable.endTime ?? '',
    }),
  );

  if (response.statusCode == 200) {
    List<int> numbers = [];
    List<dynamic> wew = jsonDecode(response.body);
    for (int i = 0; i < wew.length; i++) {
      numbers.add(wew[i]['tableNumber']);
    }

    return numbers;
  } else {
    throw Exception('faild to fetch food card data');
  }
}

Future<APIStatus> addBooking() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('$serverUrl/api/addBooking'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body: jsonEncode(<String, String>{
      'numOfPeople': BookingTable.numOfSeats.toString(),
      'tableNumber': BookingTable.tableNumber.toString(),
      'date': BookingTable.date ?? '',
      'startTime': BookingTable.startTime ?? '',
      'endTime': BookingTable.endTime ?? '',
    }),
  );

  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}

Future<List<dynamic>> getCurrentBooking() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('$serverUrl/api/getCurrentBooking'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('faild to fetch food card data');
  }
}

Future<APIStatus> deleteBooking() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.delete(
    Uri.parse('$serverUrl/api/deleteBooking'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body: jsonEncode(<String, String>{
      'date': BookingTable.date ?? '',
      'startTime': BookingTable.startTime ?? '',
      'tableNumber': BookingTable.tableNumber.toString(),
    }),
  );

  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}
