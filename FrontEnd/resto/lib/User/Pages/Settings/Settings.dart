import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto/User/Pages/Settings/DeveloperOptions.dart';
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
                    child: Ink(
                        decoration: BoxDecoration(
                            color: AppColorsLight.secondaryColor.shade200,
                            borderRadius: BorderRadius.circular(15)),
                        child: BuildContainer("Profile", Icons.person)),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Cart(),
                    ));
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: AppColorsLight.secondaryColor.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Tooltip(
                        message: 'Go To Cart',
                        child: BuildContainer("My Cart", Icons.shopping_cart)),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Favorite(),
                    ));
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: AppColorsLight.secondaryColor.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Tooltip(
                        message: 'Go To My Favorites',
                        child: BuildContainer("My Favorites", Icons.favorite)),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {},
                  child: Ink(
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
                          SizedBox(
                            height: 30,
                            child: Switch(
                              activeColor: AppColorsLight.primaryColor,
                              value: Settings.darkMode,
                              onChanged: null,
                              // onChanged: (value) {
                              //   setState(() {
                              //     Settings.darkMode = value;
                              //   });
                              // },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DeveloperOptions(),
                    ));
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: AppColorsLight.secondaryColor.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Tooltip(
                        message: 'Developer Options',
                        child: BuildContainer("Developer Options", Icons.code)),
                  ),
                ),
                const SizedBox(height: 50),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy(),
                    ));
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: AppColorsLight.secondaryColor.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Tooltip(
                        message: 'Read Privacy Policy',
                        child: BuildContainer(
                            "Privacy Policy", Icons.contact_page_outlined)),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TermsConditions(),
                    ));
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: AppColorsLight.secondaryColor.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Tooltip(
                        message: 'Read Terms & Conditions',
                        child: BuildContainer(
                            "Terms & Conditions", Icons.contact_page)),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutUs(),
                    ));
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: AppColorsLight.secondaryColor.shade200,
                        borderRadius: BorderRadius.circular(15)),
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
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColorsLight.primaryColor, size: 25),
                const SizedBox(
                  width: 10,
                ),
                Text(name,
                    style: const TextStyle(
                        color: AppColorsLight.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            const Icon(
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
