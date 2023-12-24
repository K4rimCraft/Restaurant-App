import 'package:flutter/material.dart';
import 'package:resto/Delivery/API.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:resto/main.dart';

class AssignedOrderPage extends StatefulWidget {
  const AssignedOrderPage({super.key});

  @override
  State<AssignedOrderPage> createState() => _AssignedOrderPageState();
}

class _AssignedOrderPageState extends State<AssignedOrderPage> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        child: Column(
          children: [
            const Text(
              "Assigned Order",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Divider(
                height: 1,
              ),
            ),
            Expanded(
                child: tookOrderData.isEmpty
                    ? youHaveNotAnyOrder()
                    : OrderDetailsPage(
                        order: tookOrderData.first,
                        update: update,
                      ))
          ],
        ),
      ),
    );
  }

  Widget youHaveNotAnyOrder() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "You haven't Taken Any Orders Yet!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  final OrderData order;
  final Function update;

  const OrderDetailsPage(
      {super.key, required this.order, required this.update});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Order #${order.orderId}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recipient Name: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${order.firstName} ${order.lastName}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Phone Number: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${order.phoneNumber}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Grandtotal: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "\$${order.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Location: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    FilledButton(
                      onPressed: () async {
                        String googleMapsUrl =
                            "https://www.google.com/maps/search/?api=1&query=${order.latitudeAddress},${order.longitudeAddress}";

                        if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
                          // If Google Maps is available, launch it
                          await launchUrl(Uri.parse(googleMapsUrl));
                        }
                      },
                      child: const Text("Google Maps"),
                    ),
                  ],
                ),

                const Divider(thickness: 1),

                const Center(
                    child: Text('Items:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                //Here, add your list of items, for simplicity we add a few manually
                Expanded(
                  child: ListView.builder(
                    itemCount: tookOrderItemsData.length,
                    itemBuilder: (context, index) =>
                        OrderItem(itemData: tookOrderItemsData[index]),
                  ),
                ),
                const SizedBox(height: 4),

                // Add more text fields for other details like location
                const Divider(),
                const SizedBox(height: 20),
                OrderStatusTracker(
                  update: update,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final ItemData itemData;

  const OrderItem({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          decoration:
              BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Image.network(
                        '$serverUrl/images/${itemData.firstImage}',
                        width: 50,
                        fit: BoxFit.cover,
                        height: 50)), // Replace with actual image URL
                Text(itemData.name, style: const TextStyle(fontSize: 22)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Quantity: ${itemData.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    const SizedBox(width: 2),
                    Text('Price: \$${itemData.price}',
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderStatusTracker extends StatelessWidget {
  final Function update;
  const OrderStatusTracker({Key? key, required this.update}) : super(key: key);

  void whenClick(BuildContext context, int statusType) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content:
                const Text("Are you sure you want to go to the next step?"),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  APIStatus status = await updateOrderData(
                      tookOrderData.first.orderId, statusType);
                  tookOrderData = await fetchTookOrder();
                  if (context.mounted) {
                    update();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        duration: const Duration(seconds: 1),
                        content: Text(status.message)));
                  }
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
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
            height: 90,
            width: 90,
            child: FilledButton.tonal(
              onPressed: tookOrderData.first.deliveryStatus == 1
                  ? () {
                      whenClick(context, 2);
                    }
                  : null,
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))))),
              child: const Text("Picked Up",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
            )),
        const Icon(Icons.arrow_right_alt, color: Colors.black87),
        SizedBox(
            height: 90,
            width: 90,
            child: FilledButton.tonal(
              onPressed: tookOrderData.first.deliveryStatus == 2
                  ? () {
                      whenClick(context, 3);
                    }
                  : null,
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))))),
              child: const Text('At Location',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
            )),
        const Icon(Icons.arrow_right_alt, color: Colors.black87),
        SizedBox(
            height: 90,
            width: 90,
            child: FilledButton.tonal(
              onPressed: tookOrderData.first.deliveryStatus == 3
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DeliveryConfirmation(update: update)));
                    }
                  : null,
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))))),
              child: const Text('Delivered',
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15)),
            ))
      ],
    );
  }
}

class DeliveryConfirmation extends StatefulWidget {
  final Function update;
  const DeliveryConfirmation({super.key, required this.update});

  @override
  State<DeliveryConfirmation> createState() => _DeliveryConfirmationState();
}

class _DeliveryConfirmationState extends State<DeliveryConfirmation> {
  int selectedButtonIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 50),
          SegmentedButton(
              showSelectedIcon: false,
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity(horizontal: -1, vertical: -1),
              ),
              segments: const [
                ButtonSegment(
                    icon: Icon(Icons.nfc), value: 1, label: Text('NFC')),
                ButtonSegment(
                    icon: Icon(Icons.numbers), value: 2, label: Text('Code')),
              ],
              selected: {selectedButtonIndex},
              onSelectionChanged: (index) {
                setState(() {
                  selectedButtonIndex = index.first;
                });
              }),
          const SizedBox(height: 20),
          if (selectedButtonIndex == 1)
            Container(
              width: 380,
              height: 310,
              child: Card(
                child: Column(children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Confirmation With NFC Device",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Divider(height: 25),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'You can use the device that have been handed to you to confirm delivering the order:\n1- Click the button on the device to initialize it,\n2- Prompt the customer to get his phone close to the device so the order get confirmed ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(height: 25),
                  FilledButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text(
                      'Check And Confirm',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      await updateOrderData(tookOrderData.first.orderId, 4);
                      await updateDeliveryManStatus(0);
                      tookOrderData = await fetchTookOrder();
                      widget.update();
                      Navigator.of(context).pop();
                    },
                  )
                ]),
              ),
            ),
          if (selectedButtonIndex == 2)
            Container(
              width: 380,
              height: 370,
              child: Card(
                child: Column(children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Confirmation Code:",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Divider(height: 25),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                        tookOrderData.first.confirmationNumber.toString(),
                        style: const TextStyle(fontSize: 80),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'The customer needs to insert the above code to confirm receiving the order.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(height: 25),
                  FilledButton.icon(
                    icon: Icon(Icons.check),
                    label: const Text(
                      'Check And Confirm',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  )
                ]),
              ),
            ),
        ],
      )),
    );
  }
}
