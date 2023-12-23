// class Order {
//   final String title;
//   final String description;
//   final String date;
//   final bool isCompleted;
//   final String address;
//   final String status;
//   final String photoUrl;
//   bool isrecevied=false;
//   bool indelivary=false;
//   bool isdelivred=false;
//   String orderId;
//   Order({
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.isCompleted,
//     required this.photoUrl,
//     required this.isdelivred,
//     required this.indelivary,
//     required this.isrecevied,
//     required this.orderId,
//     required this.address,
//     required this.status,
//   });
// }

class OrderData {
  final int orderId;
  final double longitudeAddress;
  final double latitudeAddress;
  final String dateOfOrder;
  final int deliveryStatus;
  final int? deliveryManId;
  final int customerId;
  final double totalPrice;
  final String firstName;
  final String lastName;

  const OrderData({
    required this.orderId,
    required this.longitudeAddress,
    required this.latitudeAddress,
    required this.dateOfOrder,
    required this.deliveryStatus,
    required this.deliveryManId,
    required this.customerId,
    required this.totalPrice,
    required this.firstName,
    required this.lastName,
  });

  static List<OrderData> toList(List<dynamic> data) {
    List<OrderData> card = [];
    for (int i = 0; i < data.length; i++) {
      try {
        card.add(OrderData(
          orderId: data[i]['orderId'],
          longitudeAddress: double.parse(data[i]['longitudeAddress']),
          latitudeAddress: double.parse(data[i]['latitudeAddress']),
          dateOfOrder: data[i]['dateOfOrder'],
          deliveryStatus: data[i]['deliveryStatus'],
          deliveryManId: data[i]['deliveryManId'],
          customerId: data[i]['customerId'],
          firstName: data[i]['firstName'],
          lastName: data[i]['lastName'],
          totalPrice: data[i]['totalPrice'] + 0.0,
        ));
      } catch (err) {
        print(err);
      }
    }

    return card;
  }
}
