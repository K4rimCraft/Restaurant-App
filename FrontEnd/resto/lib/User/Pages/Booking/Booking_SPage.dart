import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'Booking_Confirm.dart';
import '../../MainPage.dart';
import '../../models/booking_table.dart';
import '../../theme/app_color.dart';

class BookingSPage extends StatefulWidget {
  final int selectedPage;
  const BookingSPage({Key? key, required this.selectedPage}) : super(key: key);

  @override
  State<BookingSPage> createState() => _BookingSPageState();
}

class _BookingSPageState extends State<BookingSPage> {
  int _selected1 = 0;
  int _selected2 = 0;

  BoxDecoration dec1 = BoxDecoration(
    color: AppColorsLight.primaryColor,
    shape: BoxShape.circle,
  );

  BoxDecoration dec2 = BoxDecoration();

  @override
  Widget build(BuildContext context) {
    TimeOfDay? pickedHour;

    final TextEditingController _date = TextEditingController();
    _date.text = DateFormat.yMMMMEEEEd().format(BookingTable.dateTime!);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Booking",
            style: GoogleFonts.aladin(
              color: AppColorsLight.primaryColor,
              fontSize: 40,
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColorsLight.primaryColor),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: TextEditingController(text: BookingTable.name),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Table Name',
                    ),
                    enabled: false,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: _date,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date',
                    ),
                    enabled: false,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: TextEditingController(
                        text: (BookingTable.pickedHour != null)
                            ? "${BookingTable.pickedHour!.hour}:${BookingTable.pickedHour!.minute}"
                            : ""),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.watch_later_outlined),
                      border: OutlineInputBorder(),
                      labelText: 'Selected Hour',
                    ),
                    onTap: () async {
                      TimeOfDay? hourTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (hourTime != null) {
                        setState(() {
                          pickedHour = hourTime;
                          BookingTable.pickedHour = pickedHour;
                          BookingTable.dateTime = BookingTable.dateTime;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColorsLight.primaryColor),
                ),
                onPressed: () {
                  if (BookingTable.pickedHour != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BookingConfirm()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {},
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: const Text('Select An Hour'),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select Table",
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 20,
                        color: AppColorsLight.lightColor,
                      ),
                    ),
                    Icon(
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
    );
  }
}
