import 'package:resto/Admin/Overview/API.dart';
import 'package:flutter/material.dart';

class BookingsContent extends StatefulWidget {
  const BookingsContent({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookingsContentState createState() => _BookingsContentState();
}

class _BookingsContentState extends State<BookingsContent> {
  late Future<List<BookingData>> futurebooking;
  ScrollController scroll = ScrollController();
  int selected = 0;
  String numberOfPeopleIndex = '';
  String tableNumbersIndex = '';
  List<int> numberOfPeople = [2, 4, 6, 8];
  List<int> tableNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  @override
  void initState() {
    super.initState();
    futurebooking = fetchbooking();
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
              'Bookings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //Text('Filter:'),
              Builder(
                builder: (context) {
                  return ActionChip(
                    avatar: Icon(selected == 1
                        ? Icons.table_restaurant
                        : Icons.table_restaurant_outlined),
                    label: Text(
                      'Table Number${tableNumbersIndex}',
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
                        futurebooking = fetchbooking();
                      });
                    },
                  );
                },
              ),
              Builder(
                builder: (context) {
                  return ActionChip(
                    avatar: Icon(
                        selected == 2 ? Icons.person : Icons.person_outline),
                    label: Text(
                      'Number Of People${numberOfPeopleIndex}',
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
                        futurebooking = fetchbooking();
                      });
                    },
                  );
                },
              )
            ]),
            if (selected == 1)
              Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ScrollbarTheme(
                    data: const ScrollbarThemeData(
                      thickness: MaterialStatePropertyAll(5),
                      crossAxisMargin: -5,
                    ),
                    child: Scrollbar(
                      controller: scroll,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      interactive: true,
                      child: ListView.builder(
                        controller: scroll,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: tableNumbers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 60,
                            child: Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  Center(
                                      child:
                                          Text(tableNumbers[index].toString())),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        tableNumbersIndex =
                                            ": ${(index + 1).toString()}";
                                        futurebooking =
                                            fetchBookingWithTableNumber(
                                                tableNumbers[index]);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
            if (selected == 2)
              Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ScrollbarTheme(
                    data: const ScrollbarThemeData(
                      thickness: MaterialStatePropertyAll(5),
                      crossAxisMargin: -5,
                    ),
                    child: Scrollbar(
                      controller: scroll,
                      scrollbarOrientation: ScrollbarOrientation.bottom,
                      interactive: true,
                      child: ListView.builder(
                        controller: scroll,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: numberOfPeople.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 60,
                            child: Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  Center(
                                      child: Text(
                                          numberOfPeople[index].toString())),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        numberOfPeopleIndex =
                                            ": ${((index + 1) * 2).toString()}";
                                        futurebooking =
                                            fetchBookingWithNumberOfPeople(
                                                numberOfPeople[index]);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
            const Divider(),
            Flexible(
              child: FutureBuilder<List<BookingData>>(
                future: futurebooking,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<BookingData> bookings = snapshot.data!;
                    if (bookings.isNotEmpty) {
                      return ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            // ignore: non_constant_identifier_names
                            final bookingList = bookings[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                              child: Container(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Booking #${bookingList.bookingId}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),

                                    Text(
                                      'Table Number: ${bookingList.tableNumber}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Number Of People: ${bookingList.numberOfPeople}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      'Date: ${bookingList.date.split('T')[0]}',
                                      style: const TextStyle(
                                          color: Colors.green, fontSize: 20),
                                    ),
                                    Text(
                                      'Time: ${bookingList.startTime.substring(0, 5)} - ${bookingList.endTime.substring(0, 5)}',
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),

                                    // const SizedBox(width: 100),
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
