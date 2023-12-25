import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/User/theme/app_color.dart';
import '/main.dart';
import '../../models/Order_list.dart';
import '../../models/food.dart';
import 'StriperPage.dart';
import '../../API/MenuAPI.dart';
import '../../API/MenuAPI.dart';

class OrderItem extends StatelessWidget {
  final OrderData order;
  late Future<List<FoodData>> futureOrderItems;
  OrderItem({required this.order});
  final ScrollController yourScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    futureOrderItems = fetchOrderItems(order.orderId);
    return Card(
      clipBehavior: Clip.antiAlias,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(12),
      //     border: Border.all(color: Colors.black, width: 1)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Order #" + order.orderId.toString(),
                          style: GoogleFonts.aladin(
                            color: AppColorsLight.primaryColor,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: switch (order.deliveryStatus) {
                                0 => AppColorsLight.primaryColor.shade200,
                                1 => AppColorsLight.primaryColor.shade300,
                                2 => AppColorsLight.primaryColor.shade400,
                                3 => AppColorsLight.primaryColor.shade500,
                                4 => Colors.green,
                                int() => AppColorsLight.primaryColor.shade200,
                              },
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: Text(
                                switch (order.deliveryStatus) {
                                  0 => 'Just Placed',
                                  1 => 'Order Processed',
                                  2 => 'Picked Up',
                                  3 => 'At Location',
                                  4 => 'Delivered',
                                  int() => 'Unknown'
                                },
                                style: GoogleFonts.aladin(
                                  color: AppColorsLight.lightColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${order.dateOfOrder.substring(0, 10)}',
                      style: GoogleFonts.aladin(
                        color: AppColorsLight.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Price: ${order.totalPrice}',
                    style: GoogleFonts.aladin(
                      color: AppColorsLight.primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  const Divider(thickness: 2),
                  const SizedBox(height: 8.0),
                  Text(
                    'Address: ${order.longitudeAddress} ${order.latitudeAddress}',
                    style: GoogleFonts.aladin(
                      color: AppColorsLight.primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  const Divider(thickness: 2),
                  const SizedBox(height: 8.0),
                  Text(
                    'Items Ordered:',
                    style: GoogleFonts.aladin(
                      color: AppColorsLight.primaryColor,
                      fontSize: 20,
                    ),
                  ),

                  Container(
                      height: 85,
                      child: FutureBuilder(
                          future: futureOrderItems,
                          builder: (context, foodDataList) {
                            if (foodDataList.hasError) {
                              return Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Error: Request to server failed',
                                    style: TextStyle(fontSize: 20),
                                  ));
                            } else if (foodDataList.hasData) {
                              if (foodDataList.data!.isEmpty) {
                                return Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'No Data within the specified filters',
                                      style: TextStyle(fontSize: 20),
                                    ));
                              } else {
                                return Scrollbar(
                                  controller: yourScrollController,
                                  interactive: true,
                                  scrollbarOrientation:
                                      ScrollbarOrientation.right,
                                  child: Container(
                                    //constraints: const BoxConstraints(maxWidth: 600),
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      controller: yourScrollController,
                                      scrollDirection: Axis.vertical,
                                      itemCount: foodDataList.data!.length,
                                      itemBuilder: (context, index) {
                                        return Item(
                                          itemData: foodDataList.data![index],
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Container(
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              );
                            }
                          })),
                  Divider(thickness: 2),
                  SizedBox(height: 8.0),
                  Text(
                    'Date Placed: ${order.dateOfOrder.toString().substring(11, 16)}, ${order.dateOfOrder.toString().substring(0, 10)}',
                    style: GoogleFonts.aladin(
                      color: AppColorsLight.primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  //SizedBox(height: 8.0),
                  //Divider(thickness: 2),
                  // MaterialButton(
                  //   onPressed: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => Stiper(
                  //     //               isrecevied: order.isrecevied,
                  //     //               indelivary: order.indelivary,
                  //     //               isdelivred: order.indelivary,
                  //     //               orderId: order.title,
                  //     //             )));
                  //   },
                  //   child: Container(
                  //     width: 100,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: AppColorsLight.primaryColor),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Center(
                  //         child: Text(
                  //           "Status",
                  //           style: GoogleFonts.aladin(
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final FoodData itemData;

  const Item({super.key, required this.itemData});

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
                Text(
                  itemData.name,
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 22,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity: ${itemData.quantity}',
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Price: \$${itemData.price}',
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 16,
                      ),
                    ),
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
