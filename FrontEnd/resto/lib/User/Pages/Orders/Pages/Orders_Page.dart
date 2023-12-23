import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/User/Pages/Orders/Pages/pendingPage.dart';
import '/User/theme/app_color.dart';

class ShowOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColorsLight.appBarColor,
          title: Text("Orders",
              style: GoogleFonts.aladin(
                color: AppColorsLight.primaryColor,
                fontSize: 45,
              )),
          bottom: TabBar(
            labelColor: AppColorsLight.primaryColor,
            dividerColor: AppColorsLight.secondaryColor,
            indicatorColor: AppColorsLight.primaryColor,
            tabs: [
              Tab(
                  child: Text(
                "Pending Orders",
                style: GoogleFonts.aladin(
                  color: AppColorsLight.primaryColor,
                  fontSize: 20,
                ),
              )),
              Tab(
                  child: Text(
                "Completed Orders",
                style: GoogleFonts.aladin(
                  color: AppColorsLight.primaryColor,
                  fontSize: 20,
                ),
              )),
            ],
          ),
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
        body: TabBarView(
          children: [
            OrdersPage(status: 3),
            OrdersPage(status: 4),
          ],
        ),
      ),
    );
  }
}
