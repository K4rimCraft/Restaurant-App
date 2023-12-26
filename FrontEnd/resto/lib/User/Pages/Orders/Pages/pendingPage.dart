import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../OrderTile.dart';
import '../../../models/Order_list.dart';
import '../../../API/MenuAPI.dart';

class OrdersPage extends StatefulWidget {
  final int status;

  OrdersPage({required this.status});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<OrderData>> futureOrders;

  final ScrollController yourScrollController = ScrollController();
  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    futureOrders = getOrdersFilter(widget.status);
    return FutureBuilder(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
                alignment: Alignment.center,
                child: const Text(
                  'Error: Request to server failed',
                  style: TextStyle(fontSize: 20),
                ));
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Empty',
                    style: TextStyle(fontSize: 20),
                  ));
            } else {
              return Scrollbar(
                  controller: yourScrollController,
                  interactive: true,
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrderItem(
                          update: update,
                          order: snapshot.data![index],
                        ),
                      );
                    },
                  ));
            }
          } else {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        });
  }
}
