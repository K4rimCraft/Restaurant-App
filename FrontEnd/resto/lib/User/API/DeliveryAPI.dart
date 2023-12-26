import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/main.dart';

class APIStatus {
  int statusCode;
  String message;

  APIStatus({required this.statusCode, required this.message});
}

Future<APIStatus> updateDeliveryManStatus(int status, int id) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.put(
    Uri.parse('$serverUrl/api/updateDeliveryManStatus/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body: jsonEncode(<String, String>{
      'status': status.toString(),
      'deliveryManId': id.toString(),
    }),
  );
  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}

Future<APIStatus> updateOrderData(
    int orderId, int deliveryStatus, int id) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.put(
    Uri.parse('$serverUrl/api/updateOrderData/${orderId.toString()}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body: jsonEncode(<String, String>{
      'deliveryStatus': deliveryStatus.toString(),
      'deliveryManId': id.toString(),
    }),
  );
  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}
