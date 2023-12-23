import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'LoginPage.dart';



class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Set up a 5-second timer
    // _timer = Timer(Duration(seconds: 5), () {
    //   // Navigate to the next page
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => SignInPage()),
    //   );
    // });
  }

  @override
  void dispose() {
    // Cancel the timer to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       BackgroundVideoWidget(url:"assets/v.mp4" ,),
    //     ],
    //   ),
    // );
  }
}
