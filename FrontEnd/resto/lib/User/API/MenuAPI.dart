import 'package:http/http.dart' as http;
import 'package:resto/User/models/User.dart';
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

Future<List<FoodData>> searchItem(String searchTerm) async {
  final response = await http.post(
    Uri.parse('$serverUrl/admin/searchItem'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'searchterm': searchTerm,
    }),
  );

  if (response.statusCode == 200) {
    return FoodData.toList(jsonDecode(response.body));
  } else {
    throw Exception('faild to fetch food card data');
  }
}

Future<List<FoodData>> fetchAllItems() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('$serverUrl/api/getAllItems'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );

  if (response.statusCode == 200) {
    return FoodData.toList(jsonDecode(response.body));
  } else {
    throw Exception('faild to fetch food card data');
  }
}

Future<List<FoodData>> fetchMostPopularItems() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('$serverUrl/api/getMostPopularItems'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );
  if (response.statusCode == 200) {
    return FoodData.toList(jsonDecode(response.body));
  } else {
    throw Exception('faild to fetch food card data');
  }
}

Future<List<FoodData>> fetchRandomItems() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('$serverUrl/api/getRandomItems'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );

  if (response.statusCode == 200) {
    return FoodData.toList(jsonDecode(response.body));
  } else {
    throw Exception('faild to fetch food card data');
  }
}

Future<List<FoodData>> fetchItemsByCategory(int categoryId) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('$serverUrl/api/getItemByCategory/$categoryId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );
  if (response.statusCode == 200) {
    return FoodData.toList(jsonDecode(response.body));
  } else {
    throw Exception('faild to fetch food card data');
  }
}

Future<List<CategoryData>> fetchCatagories() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('$serverUrl/api/getAllCategories'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );

  if (response.statusCode == 200) {
    return CategoryData.toList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Categoris');
  }
}

Future<APIStatus> sendFavorite(int itemId) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('$serverUrl/api/addFavorite/$itemId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );

  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}

Future<APIStatus> deleteFavorite(int itemId) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.delete(
    Uri.parse('$serverUrl/api/deleteFavorite/$itemId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );

  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}

Future<List<FoodData>> fetchFavorites() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('$serverUrl/api/getAllFavorites'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );
  if (response.statusCode == 200) {
    return FoodData.toList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Categoris');
  }
}

Future<APIStatus> placeOrder(double long, double lat, String data) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse('$serverUrl/api/placeOrder'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body: jsonEncode(<String, String>{
      'longitudeAddress': long.toString(),
      'latitudeAddress': lat.toString(),
      'itemsListString': data,
    }),
  );
  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}

Future<List<OrderData>> getOrdersFilter(int status) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.get(
    Uri.parse('$serverUrl/api/getOrdersFilter/$status'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );
  if (response.statusCode == 200) {
    return OrderData.toList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load order history');
  }
}

Future<List<FoodData>> fetchOrderItems(int orderId) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('$serverUrl/api/getOrderItems/$orderId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );

  if (response.statusCode == 200) {
    return FoodData.toList2(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load order history');
  }
}

Future<List<UserData>> fetchUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';
  final response = await http.get(
    Uri.parse('$serverUrl/api/getUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
  );

  if (response.statusCode == 200) {
    return UserData.toList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load User data');
  }
}

Future<APIStatus> updateUser(UserData data) async {
  final prefs = await SharedPreferences.getInstance();
  final String token = prefs.getString('token') ?? '';

  final response = await http.put(
    Uri.parse('$serverUrl/api/updateUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body: jsonEncode(<String, String>{
      'firstName': data.firstName,
      'lastName': data.lastName,
      'longitudeAddress': data.longitudeAddress.toString(),
      'latitudeAddress': data.latitudeAddress.toString(),
      'email': data.email,
      'phoneNumber': data.phoneNumber,
    }),
  );
  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message']);
}
