import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:resto/Admin/MainPage.dart';
import 'package:resto/Delivery/MainPage.dart';
import 'package:resto/Auth/MainPage.dart';
import 'package:resto/User/MainPage.dart';
import 'package:resto/User/theme/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

String serverUrl = "http://localhost:3000";
int selectedInterface = 0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    init();
    super.initState();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? type = prefs.getString('type');
    if (token == null) {
      selectedInterface = 1;
    } else if (type == 'customer') {
      selectedInterface = 2;
    } else if (type == 'deliveryman') {
      selectedInterface = 3;
    } else if (type == 'admin') {
      selectedInterface = 4;
    }

    setState(() {
      animationController.forward(from: 0.0);
    });
  }

  void update() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: getThemeDataLight(),
        // theme: ThemeData(
        //   useMaterial3: true,
        //   colorSchemeSeed: Colors.blue,
        //   brightness: Brightness.light,
        //   fontFamily: 'Kanit',
        //   sliderTheme: const SliderThemeData(
        //       showValueIndicator: ShowValueIndicator.always),
        //   tooltipTheme: TooltipThemeData(
        //       textStyle: const TextStyle(color: Colors.black),
        //       decoration: BoxDecoration(color: Colors.blue.shade50)),
        // ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          brightness: Brightness.dark,
          fontFamily: 'Kanit',
          sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always),
          tooltipTheme: const TooltipThemeData(
              textStyle: TextStyle(color: Colors.white),
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 38, 41, 49))),
        ),
        themeMode: ThemeMode.light,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        //home:
        home: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            FadeTransition(
                opacity:
                    animationController.drive(CurveTween(curve: Curves.easeIn)),
                child: <Widget>[
                  Container(),
                  AuthInterface(update: update),
                  UserInterface(selectedPage: 0),
                  const DeliveryInteface(),
                  AdminInterface(),
                ][selectedInterface])
            //home: AdminInterface(),
          ],
        ));
  }
}
