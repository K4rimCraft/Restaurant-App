import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_color.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("About Us",
            style: GoogleFonts.aladin(
              color: AppColorsLight.primaryColor,
              fontSize: 45,
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text("Team Members:",
                      style: GoogleFonts.dmSerifDisplay(
                        color: AppColorsLight.primaryColor,
                        fontSize: 40,
                      )),
                  Text(
                      "- Karim Salah Eldin Elghmary\n- Mahmoud Galal Ramadan El-Gendy\n- Hassan Mohamed Hassan Ali\n- Mohamed Gehad Hussien Metwally\n- Ahmed Mohamed Salah Eldin\n- Nancy Ayman Nabil Mohamed\n- Mohamed Mahmoud Mohamed Ghanem\n- Kareem Wael Tolba Muhammad\n- Reham Hamdy Mohamed Ibrahim\n- Shahd AlSayed Ahmed Ali\n- Mohamed Ahmed Mahmoud Mohamed",
                      style: TextStyle(fontSize: 17)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
