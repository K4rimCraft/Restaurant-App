import 'package:resto/Admin/Overview/API.dart';
import 'package:flutter/material.dart';

class OrdersContent extends StatefulWidget {
  const OrdersContent({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrdersContentState createState() => _OrdersContentState();
}

class _OrdersContentState extends State<OrdersContent> {
  ScrollController scroll = ScrollController();
  late Future<List<OrderData>> futureOrders;
  RangeValues priceRange = RangeValues(0, OrderData.maxPrice);
  int selected = 0;
  TextEditingController nameControler = TextEditingController();

  int selectedButtonIndex = -55;
  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders(priceRange.start, priceRange.end)
        .whenComplete(() => priceRange = RangeValues(0, OrderData.maxPrice));
  }

  void update(RangeValues values) {
    setState(() {
      priceRange = values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      // padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Order History',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //Text('Filter:'),
              ActionChip(
                avatar: Icon(selected == 1
                    ? Icons.table_restaurant
                    : Icons.table_restaurant_outlined),
                label: Text(
                  'Price',
                  style: TextStyle(
                      color: selected == 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () {
                  setState(() {
                    if (selected == 1) {
                      selected = 0;
                    } else {
                      selected = 1;
                    }

                    futureOrders = fetchOrders(0, OrderData.maxPrice);
                  });
                },
              ),

              ActionChip(
                avatar:
                    Icon(selected == 2 ? Icons.person : Icons.person_outline),
                label: Text(
                  'Name',
                  style: TextStyle(
                      color: selected == 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () {
                  setState(() {
                    if (selected == 2) {
                      selected = 0;
                    } else {
                      selected = 2;
                    }

                    futureOrders = fetchOrders(0, OrderData.maxPrice);
                  });
                },
              ),

              ActionChip(
                avatar:
                    Icon(selected == 3 ? Icons.person : Icons.person_outline),
                label: Text(
                  'Status',
                  style: TextStyle(
                      color: selected == 3
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface),
                ),
                onPressed: () {
                  setState(() {
                    if (selected == 3) {
                      selected = 0;
                    } else {
                      selected = 3;
                    }
                    selectedButtonIndex = 0;
                    futureOrders = fetchOrders(0, OrderData.maxPrice);
                  });
                },
              ),
            ]),
            if (selected == 1)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 8,
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 5,
                        child: RangeSlider(
                          values: priceRange,
                          min: 0,
                          max: OrderData.maxPrice,
                          labels: RangeLabels(
                            priceRange.start.round().toString(),
                            priceRange.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            update(values);
                          },
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                          child: FilledButton.tonal(
                              onPressed: () {
                                setState(() {
                                  futureOrders = fetchOrders(
                                      priceRange.start, priceRange.end);
                                });
                              },
                              child: const Text('Filter')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            if (selected == 2)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 8,
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: TextField(
                            controller: nameControler,
                            decoration: const InputDecoration(
                                constraints: BoxConstraints(maxHeight: 45),
                                border: OutlineInputBorder(),
                                labelText: 'Catagory Name'),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                          child: FilledButton.tonal(
                              onPressed: () {
                                setState(() {
                                  if (nameControler.text.isNotEmpty) {
                                    futureOrders = fetchOrdersNameFilter(
                                        nameControler.text);
                                  }
                                });
                              },
                              child: const Text('Filter')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            if (selected == 3)
              Container(
                height: 86,
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 8,
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          constraints: const BoxConstraints(
                              maxWidth: 600, minWidth: 400),
                          child: SegmentedButton(
                              showSelectedIcon: false,
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity:
                                    VisualDensity(horizontal: -1, vertical: -1),
                              ),
                              segments: const [
                                ButtonSegment(value: 0, label: Text('New')),
                                ButtonSegment(value: 1, label: Text('Taken')),
                                ButtonSegment(
                                    value: 2, label: Text('PickedUp')),
                                ButtonSegment(
                                    value: 3,
                                    label: Text(
                                      'AtLocation',
                                    )),
                                ButtonSegment(
                                    value: 4, label: Text('Delivered '))
                              ],
                              selected: {selectedButtonIndex},
                              onSelectionChanged: (index) {
                                setState(() {
                                  selectedButtonIndex = index.first;
                                  futureOrders =
                                      fetchOrdersFilterStatus(index.first);
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Divider(),
            Flexible(
              child: FutureBuilder<List<OrderData>>(
                future: futureOrders,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<OrderData> orders = snapshot.data!;
                    if (orders.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            // ignore: non_constant_identifier_names
                            final OrderList = orders[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              child: Container(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order #${OrderList.orderId}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                            'Status: ${switch (OrderList.deliveryStatus) {
                                              0 => 'Just Placed',
                                              1 => 'In Transit',
                                              2 => 'Delivered',
                                              int() => ''
                                            }}',
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        Text(
                                          'Name: ${OrderList.firstName} ${OrderList.lastName}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            OrderList.dateOfOrder.split('T')[0],
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        Text(
                                            OrderList.dateOfOrder
                                                .split('T')[1]
                                                .split('.')[0],
                                            style:
                                                const TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Text('Empty');
                    }
                  } else if (snapshot.hasError) {
                    return Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(10),
                        child: Card(
                          color: Theme.of(context).colorScheme.onError,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.error.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer),
                            ),
                          ),
                        ));
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            ),
          ]),
    );
  }
}
