import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:resto/User/API/BookingAPI.dart';
import '../../External/Booking_Pdf.dart';
import 'Booking_SPage.dart';
import '../../models/booking_table.dart';
import '../../theme/app_color.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Future<List<dynamic>> futureCurrentBooking = getCurrentBooking();
  TextEditingController _date = TextEditingController();
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsLight.lightColor,
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text(
              "Booking",
              style: GoogleFonts.aladin(
                color: AppColorsLight.primaryColor,
                fontSize: 45,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
            future: futureCurrentBooking,
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
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 50),
                              child: Center(
                                child: Text(
                                  "Choose Your Time",
                                  style: GoogleFonts.aladin(
                                    color: AppColorsLight.primaryColor,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        controller: TextEditingController(
                                            text: BookingTable.name),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Table Name',
                                        ),
                                        enabled: false,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextField(
                                        keyboardType: TextInputType.datetime,
                                        controller: _date,
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                              Icons.calendar_today_rounded),
                                          border: OutlineInputBorder(),
                                          labelText: 'Select Day',
                                        ),
                                        onTap: () async {
                                          pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2026),
                                          );
                                          if (pickedDate != null) {
                                            setState(() {
                                              _date.text = DateFormat.MEd()
                                                  .format(pickedDate!);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColorsLight.primaryColor),
                                ),
                                onPressed: () {
                                  if (pickedDate != null) {
                                    BookingTable.dateTime = pickedDate;
                                    Navigator.of(context)
                                        .push(
                                          MaterialPageRoute(
                                            builder: (context) => BookingSPage(
                                              selectedPage: 2,
                                            ),
                                          ),
                                        )
                                        .whenComplete(() => setState(
                                              () {
                                                futureCurrentBooking =
                                                    getCurrentBooking();
                                              },
                                            ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: AppColorsLight
                                          .secondaryColor.shade800,
                                      action: SnackBarAction(
                                        label: "OK",
                                        textColor: AppColorsLight.lightColor,
                                        onPressed: () {},
                                      ),
                                      content: Text(
                                          "Select The Date Of Booking",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ));
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Book A Table",
                                      style: GoogleFonts.dmSerifDisplay(
                                        fontSize: 20,
                                        color: AppColorsLight.lightColor,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_right_outlined,
                                      color: AppColorsLight.lightColor,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // BookingTable.setName = snapshot.data![0]['firstName'];
                  BookingTable.tableNumber = snapshot.data![0]['tableNumber'];
                  BookingTable.numOfSeats = snapshot.data![0]['numberOfPeople'];
                  BookingTable.setDate =
                      snapshot.data![0]['date'].toString().substring(0, 10);
                  BookingTable.setStartTime =
                      snapshot.data![0]['startTime'].toString().substring(0, 5);
                  BookingTable.setEndTime =
                      snapshot.data![0]['endTime'].toString().substring(0, 5);

                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 10.0, left: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: AppColorsLight.secondaryColor.shade100,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Your Table is Booked",
                                          style: GoogleFonts.aladin(
                                            color: AppColorsLight.primaryColor,
                                            fontSize: 35,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            openQr(context);
                                          },
                                          icon: Icon(
                                            Icons.qr_code,
                                            color: AppColorsLight.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColorsLight.lightColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Table Name: ",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 28,
                                                ),
                                              ),
                                              Text(
                                                BookingTable.name!,
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColorsLight.lightColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Table: ",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 28,
                                                ),
                                              ),
                                              Text(
                                                "${BookingTable.tableNumber}",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColorsLight.lightColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Number Of Seats: ",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 28,
                                                ),
                                              ),
                                              Text(
                                                "${BookingTable.numOfSeats}",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColorsLight.lightColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Date:",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 28,
                                                ),
                                              ),
                                              Text(
                                                BookingTable.date!,
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 25,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColorsLight.lightColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Start Time: ",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 28,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${BookingTable.startTime}",
                                                    style: GoogleFonts.aladin(
                                                      color: AppColorsLight
                                                          .primaryColor,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColorsLight.lightColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "End Time: ",
                                                style: GoogleFonts.aladin(
                                                  color: AppColorsLight
                                                      .primaryColor,
                                                  fontSize: 28,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${BookingTable.endTime}",
                                                    style: GoogleFonts.aladin(
                                                      color: AppColorsLight
                                                          .primaryColor,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColorsLight
                                                          .primaryColor),
                                            ),
                                            onPressed: () {
                                              PdfGenerator(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.download,
                                                  color:
                                                      AppColorsLight.lightColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Download",
                                                  style: GoogleFonts
                                                      .dmSerifDisplay(
                                                    fontSize: 20,
                                                    color: AppColorsLight
                                                        .lightColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColorsLight
                                                          .primaryColor),
                                            ),
                                            onPressed: () async {
                                              await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Confirm"),
                                                      content: const Text(
                                                          "Are you sure you want to cancel your booking?"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child:
                                                              const Text('Yes'),
                                                          onPressed: () async {
                                                            APIStatus status =
                                                                await deleteBooking();
                                                            if (context
                                                                .mounted) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();

                                                              if (status
                                                                      .statusCode ==
                                                                  200) {}
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      content: Text(
                                                                          status
                                                                              .message)));
                                                            }
                                                          },
                                                        ),
                                                        TextButton(
                                                          child:
                                                              const Text('No'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });

                                              setState(() {
                                                futureCurrentBooking =
                                                    getCurrentBooking();
                                                BookingTable.clear();
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color:
                                                      AppColorsLight.lightColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Cancel",
                                                  style: GoogleFonts
                                                      .dmSerifDisplay(
                                                    fontSize: 20,
                                                    color: AppColorsLight
                                                        .lightColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
            })

        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
        //   child: FloatingActionButton.extended(
        //     backgroundColor: AppColorsLight.primaryColor,
        //     label: Row(
        //       children: [
        //         Text(
        //           "Book A Table",
        //           style: GoogleFonts.dmSerifDisplay(
        //             fontSize: 20,
        //             color: AppColorsLight.lightColor,
        //           ),
        //         ),
        //         const Icon(
        //           Icons.arrow_right_outlined,
        //           color: AppColorsLight.lightColor,
        //         ),
        //       ],
        //     ),
        //     onPressed: () {
        //       if (pickedDate != null) {
        //         BookingTable.dateTime = pickedDate;
        //         Navigator.of(context)
        //             .push(
        //               MaterialPageRoute(
        //                 builder: (context) => BookingSPage(
        //                   selectedPage: 2,
        //                 ),
        //               ),
        //             )
        //             .whenComplete(() => setState(
        //                   () {},
        //                 ));
        //       } else {
        //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //           backgroundColor: AppColorsLight.secondaryColor.shade800,
        //           action: SnackBarAction(
        //             label: "OK",
        //             textColor: AppColorsLight.lightColor,
        //             onPressed: () {},
        //           ),
        //           content: Text("Select The Date Of Booking",
        //               style: TextStyle(fontWeight: FontWeight.bold)),
        //         ));
        //       }
        //     },
        //   ),
        // ),
        );
  }

  Future<void> openQr(BuildContext context) async {
    final qrData = "${BookingTable.name}#"
        "${BookingTable.tableNumber}#"
        "${BookingTable.numOfSeats}#"
        "${BookingTable.date}#"
        "${BookingTable.startTime}#"
        "${BookingTable.endTime}#";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: Container(
        width: 300.0,
        height: 300.0,
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 300.0,
        ),
      )),
    );
  }
}
