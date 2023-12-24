import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../OrderTile.dart';
import '../../../models/Order_list.dart';
import '../../../API/MenuAPI.dart';

class OrdersPage extends StatelessWidget {
  final int status;
  late Future<List<OrderData>> futureOrders;
  final ScrollController yourScrollController = ScrollController();
  OrdersPage({required this.status});

  @override
  Widget build(BuildContext context) {
    futureOrders = getOrdersFilter(status);
    return FutureBuilder(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
                alignment: Alignment.center,
                child: const Text(
                  'Error: Request to server failed',
                  textScaler: TextScaler.linear(1.5),
                ));
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Empty',
                    textScaler: TextScaler.linear(1.5),
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
