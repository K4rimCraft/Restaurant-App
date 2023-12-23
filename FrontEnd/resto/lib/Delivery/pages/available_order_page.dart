import 'package:flutter/material.dart';
import 'package:resto/Delivery/API.dart';
import 'package:resto/Delivery/pages/order_item.dart';

class AvailableOrderPage extends StatefulWidget {
  const AvailableOrderPage({super.key});

  @override
  State<AvailableOrderPage> createState() => _AvailableOrderPageState();
}

class _AvailableOrderPageState extends State<AvailableOrderPage> {
  @override
  void initState() {
    checkIfHaveOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        child: Column(
          children: [
            const Text(
              "Available Orders",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Divider(
                height: 1,
              ),
            ),
            Expanded(
                child: tookOrderData.isNotEmpty
                    ? youHaveAlreadyHaveOrder()
                    : OrderList(func: checkIfHaveOrder))
          ],
        ),
      ),
    );
  }

  Widget youHaveAlreadyHaveOrder() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "You already have an order to deliver, please deliver it first!",
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

  checkIfHaveOrder() async {
    tookOrderData = await fetchTookOrder();
    if (tookOrderData.isNotEmpty) {
      tookOrderItemsData = await fetchOrderItems();
    }

    setState(() {});
  }
}

class OrderList extends StatefulWidget {
  final Function func;
  OrderList({required this.func, super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late Future<List<OrderData>> futureOrders;
  @override
  void initState() {
    futureOrders = fetchUndeliverdOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureOrders,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<OrderData> orders = snapshot.data!;
          if (orders.isNotEmpty) {
            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderItem(
                    data: orders[index],
                    func: widget.func,
                  );
                });
          } else {
            return const Text('Empty');
          }
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          return const Center(
              child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()));
        }
      },
    );
  }
}
