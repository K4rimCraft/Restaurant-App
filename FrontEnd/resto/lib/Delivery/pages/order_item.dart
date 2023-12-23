import 'package:flutter/material.dart';

import '../API.dart';

// String formatTimestamp(int timestamp) {
//   var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
//   var formattedDate = DateFormat('h:mm a MM/dd/yyyy').format(date); // Example: '5:07 PM 11/24/2023'
//   return formattedDate;
// }

class OrderItem extends StatelessWidget {
  final OrderData data;
  final Function func;

  const OrderItem({Key? key, required this.data, required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${data.orderId}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.dateOfOrder,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(150, 156, 142, 153)),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recipient Name: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${data.firstName} ${data.lastName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Grandtotal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "\$${data.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.arrow_back_sharp),
                    onPressed: () {
                      func();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm"),
                              content: const Text(
                                  "Are you sure you want to take this order?"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () async {
                                    APIStatus status =
                                        await updateOrderData(data.orderId, 1);
                                    await updateDeliveryManStatus(1);
                                    Navigator.of(context).pop();
                                    func();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                            duration:
                                                const Duration(seconds: 1),
                                            content: Text(status.message)));
                                  },
                                ),
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    label: const Text('Take Order'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
