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

delete() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    delete();
    return Scaffold(
      backgroundColor: AppColorsLight.lightColor,
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
          color: AppColorsLight.lightColor,
          child: Text("Coming Soon....",
              style: TextStyle(
                  color: AppColorsLight.primaryColor,
                  fontSize: 50,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
