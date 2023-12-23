import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/User/theme/app_color.dart';

import 'TimeLine.dart';

class Stiper extends StatelessWidget {
  bool isrecevied;
  bool indelivary;
  bool isdelivred;
  String orderId;
  Stiper(
      {required this.isrecevied,
      required this.indelivary,
      required this.isdelivred,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.grey.shade100,
          title: Text("  Order tracking",
              style: GoogleFonts.aladin(
                color: AppColorsLight.primaryColor,
                fontSize: 45,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              Text("order id :" + orderId,
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  )),
              MyTimeline(
                  isLast: false,
                  isFirst: true,
                  IsPast: isrecevied,
                  Track_data: "order is recevied"),
              MyTimeline(
                  isLast: false,
                  isFirst: false,
                  IsPast: indelivary,
                  Track_data: 'order in delivary'),
              MyTimeline(
                  isLast: true,
                  isFirst: false,
                  IsPast: isdelivred,
                  Track_data: "order is delivred"),
            ],
          ),
        ),
      ),
    );
  }
}
