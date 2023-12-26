import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../User/theme/app_color.dart';
import 'package:resto/main.dart';

class DeveloperOptions extends StatefulWidget {
  const DeveloperOptions({super.key});

  @override
  State<DeveloperOptions> createState() => _DeveloperOptionsState();
}

class _DeveloperOptionsState extends State<DeveloperOptions> {
  final TextEditingController _urlController = TextEditingController();
  @override
  void initState() {
    _urlController.text = serverUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.lightColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Developer Options",
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
            child: Column(
              children: [
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
                              Icon(Icons.credit_card,
                                  color: AppColorsLight.primaryColor, size: 25),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Turn on payment process",
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
                              value: payment,
                              onChanged: (value) {
                                setState(() {
                                  payment = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.link,
                                  color: AppColorsLight.primaryColor, size: 25),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Server Url",
                                  style: TextStyle(
                                      color: AppColorsLight.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(
                              width: 200,
                              child: TextField(
                                controller: _urlController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  //_urlController.text = value;
                                  serverUrl = value;
                                  prefs.setString('serverUrl', value);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
