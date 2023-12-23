import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:resto/main.dart';

int myDeliveryManId = 2001;
List<OrderData> tookOrderData = [];
List<ItemData> tookOrderItemsData = [];

class APIStatus {
  int statusCode;
  String message;

  APIStatus({required this.statusCode, required this.message});
}

Future<List<OrderData>> fetchUndeliverdOrders() async {
  final response = await http.get(
    Uri.parse('$serverUrl/getUndeliverdOrders'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return OrderData.toList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load order history');
  }
}

// 0 new Orderd
// 1 taken Order
// 2 the order on its way
// 3 at location
// 4 deiliverd

Future<APIStatus> updateOrderData(int orderId, int deliveryStatus) async {
  final response = await http.put(
    Uri.parse('$serverUrl/updateOrderData/${orderId.toString()}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'deliveryManId': myDeliveryManId.toString(),
      'deliveryStatus': deliveryStatus.toString(),
    }),
  );
  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body).values.toList().first);
}

Future<List<OrderData>> fetchTookOrder() async {
  final response = await http.get(
    Uri.parse('$serverUrl/getTookOrder/${myDeliveryManId.toString()}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return OrderData.toList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load order history');
  }
}

class OrderData {
  final int orderId;
  final String dateOfOrder;
  final int deliveryStatus;
  final int? deliveryManId;
  final int customerId;
  final double totalPrice;
  final String firstName;
  final String lastName;
  final double longitudeAddress;
  final double latitudeAddress;
  final int? confirmationNumber;

  const OrderData({
    required this.orderId,
    required this.dateOfOrder,
    required this.deliveryStatus,
    required this.deliveryManId,
    required this.customerId,
    required this.totalPrice,
    required this.firstName,
    required this.lastName,
    required this.longitudeAddress,
    required this.latitudeAddress,
    required this.confirmationNumber,
  });

  static List<OrderData> toList(List<dynamic> data) {
    List<OrderData> card = [];
    for (int i = 0; i < data.length; i++) {
      try {
        card.add(OrderData(
          orderId: data[i]['orderId'],
          dateOfOrder: data[i]['dateOfOrder'],
          deliveryStatus: data[i]['deliveryStatus'],
          deliveryManId: data[i]['deliveryManId'],
          customerId: data[i]['customerId'],
          firstName: data[i]['firstName'],
          lastName: data[i]['lastName'],
          totalPrice: data[i]['totalPrice'] + 0.0,
          longitudeAddress: double.parse(data[i]['longitudeAddress']),
          latitudeAddress: double.parse(data[i]['latitudeAddress']),
          confirmationNumber: data[i]['confirmationNumber'],
        ));
      } catch (err) {
        print(err);
      }
    }

    return card;
  }
}

Future<List<ItemData>> fetchOrderItems() async {
  final response = await http.get(
    Uri.parse('$serverUrl/getOrderItems/${tookOrderData.first.orderId}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return ItemData.toList(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load order history');
  }
}

class ItemData {
  final int itemId;
  final String name;
  final int stock;
  final String description;
  final double rating;
  final double price;
  final String image;
  final int quantity;

  ItemData({
    required this.itemId,
    required this.name,
    required this.stock,
    required this.description,
    required this.rating,
    required this.price,
    required this.image,
    required this.quantity,
  });

  static List<ItemData> toList(List<dynamic> data) {
    List<ItemData> card = [];
    for (int i = 0; i < data.length; i++) {
      try {
        card.add(ItemData(
          itemId: data[i]['itemId'],
          name: data[i]['name'],
          stock: data[i]['stock'],
          description: data[i]['description'],
          rating: data[i]['rating'] + 0.0,
          price: data[i]['price'] + 0.0,
          image: data[i]['image'],
          quantity: data[i]['quantity'],
        ));
      } catch (err) {
        print(err);
      }
    }

    return card;
  }
}

Future<APIStatus> updateDeliveryManStatus(int status) async {
  final response = await http.put(
    Uri.parse('$serverUrl/updateDeliveryManStatus/${myDeliveryManId.toString()}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'status': status.toString(),
    }),
  );
  return APIStatus(
      statusCode: response.statusCode,
      message: jsonDecode(response.body).values.toList().first);
}

enum OrderStatus { pickedUp, atLocation, delivered }

// List<Order> generateOrders() {
//   Random random = Random();
//   List<Order> orders = [];

//   for (int i = 0; i < 30; i++) {
//     String id = 'ID${random.nextInt(9999 - 1000) + 1000}';
//     int orderNumber = random.nextInt(5000 - 4000) + 4000;
//     int orderTime = DateTime(2005).millisecondsSinceEpoch ;
//     String recipientName = '${getRandomArabicName()} ${getRandomArabicSurname()}';
//     int grandTotal = random.nextInt(500 - 50) + 50;
//     OrderStatus status = OrderStatus.values[random.nextInt(OrderStatus.values.length)];
//     List<Item> items = [
//         Item(
//             id: "id",
//             image: 'https://i.pinimg.com/564x/f2/85/2a/f2852a92d02abab013f3a3990083a341.jpg',
//             productName: 'BURGER',
//             quantity: 3,
//             price: 11.2
//         ),
//       Item(
//             id: "id",
//             image: 'https://i.pinimg.com/564x/e6/1c/ef/e61cef37dffe3af9ce48d9e119176203.jpg',
//             productName: 'Pizza',
//             quantity: 1,
//             price: 30.9
//         ),
//       Item(
//             id: "id",
//             image: 'https://i.pinimg.com/564x/4a/88/f9/4a88f98c133c9572dc0e4f1825f6f41c.jpg',
//             productName: 'BURGER',
//             quantity: 3,
//             price: 11.2
//         ),
//       Item(
//             id: "id",
//             image: 'https://i.pinimg.com/564x/e7/a4/0a/e7a40aee4b0491ba15e17e7da44fd9d8.jpg',
//             productName: 'Moka',
//             quantity: 9,
//             price: 238.9
//         ),
//     ];

//     orders.add(
//         Order(
//         id: id,
//         orderNumber: orderNumber,
//         orderTime: orderTime,
//         recipientName: recipientName,
//         items:items,
//         grandTotal: grandTotal,
//         status: status, latitude: 31.524510,longitude:  31.842806
//     ));
//   }

//   return orders;
// }

// String getRandomArabicName() {
//   List<String> names = ["Kareem", "Yousef", "Amir", "Sami", "Laila", "Fatima", "Nadia", "Yasmin"];
//   Random random = Random();
//   return names[random.nextInt(names.length)];
// }

// String getRandomArabicSurname() {
//   List<String> surnames = ["Aboelatta", "Al-Masri", "El-Sayed", "Hassan", "Farid", "Ibrahim", "Mahmoud", "Zahran"];
//   Random random = Random();
//   return surnames[random.nextInt(surnames.length)];
// }
