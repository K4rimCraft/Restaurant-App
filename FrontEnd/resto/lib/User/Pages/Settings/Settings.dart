
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Favorite.dart';
import '../Orders/Pages/Orders_Page.dart';
import 'Profile.dart';
import 'about_us.dart';
import '../Cart.dart';
import 'privacy_policy.dart';
import 'terms_conditions.dart';
import '../../theme/app_color.dart';

class Settings extends StatefulWidget {
  static bool darkMode = false;
  final int selectedPage;
  const Settings({super.key, required this.selectedPage});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.lightColor,
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text("Settings",
              style: GoogleFonts.aladin(
                color: AppColorsLight.primaryColor,
                fontSize: 45,
              )),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
            child: Column(
              children: [
                Tooltip(
                  message: 'Edit Profile',
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Profile(),
                      ));
                    },
                    child: Ink(child: BuildContainer("Profile", Icons.person)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Cart(),
                    ));
                  },
                  child: Ink(
                    child: Tooltip(
                        message: 'Go To Cart',
                        child: BuildContainer("My Cart", Icons.shopping_cart)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowOrderPage()));
                  },
                  child: Ink(
                    child: Tooltip(
                        message: 'Go To My Orders',
                        child: BuildContainer("My Orders", Icons.shop)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Favorite(),
                    ));
                  },
                  child: Ink(
                    child: Tooltip(
                        message: 'Go To My Favorites',
                        child: BuildContainer("My Favorites", Icons.favorite)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColorsLight.secondaryColor.shade200,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.sunny,
                                color: AppColorsLight.primaryColor, size: 25),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Dark Mode",
                                style: TextStyle(
                                    color: AppColorsLight.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Container(
                          height: 30,
                          child: Switch(
                            activeColor: AppColorsLight.primaryColor,
                            value: Settings.darkMode,
                            onChanged: (value) {
                              setState(() {
                                Settings.darkMode = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(),
                    ));
                  },
                  child: Ink(
                    child: Tooltip(
                        message: 'Read Privacy Policy',
                        child: BuildContainer(
                            "Privacy Policy", Icons.contact_page_outlined)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TermsConditions(),
                    ));
                  },
                  child: Ink(
                    child: Tooltip(
                        message: 'Read Terms & Conditions',
                        child: BuildContainer(
                            "Terms & Conditions", Icons.contact_page)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ));
                  },
                  child: Ink(
                    child: Tooltip(
                        message: 'About Us',
                        child: BuildContainer(
                            "About Us", Icons.question_mark_outlined)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildContainer(String name, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: AppColorsLight.secondaryColor.shade200,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColorsLight.primaryColor, size: 25),
                SizedBox(
                  width: 10,
                ),
                Text("$name",
                    style: TextStyle(
                        color: AppColorsLight.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: AppColorsLight.primaryColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
