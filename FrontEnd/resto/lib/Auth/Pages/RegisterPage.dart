import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resto/Auth/API.dart';

import 'package:flutter_onboarding_slider/background_final_button.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/s1.dart';
import '../Pages/s2.dart';
import '../Pages/s3.dart';
import '../Providers/SignupData.dart';

class RegisterPage extends StatefulWidget {
  final Function update;
  RegisterPage({required this.update});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Color kDarkBlueColor = const Color(0xFF053149);

  void saveInfo(String token, String type, int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('type', type);
    await prefs.setInt('id', id);
    widget.update();
  }

  @override
  Widget build(BuildContext context) {
    final data1 = Provider.of<s1_data>(context);
    final data2 = Provider.of<s2_data>(context);
    final data3 = Provider.of<s3_data>(context);

    return OnBoardingSlider(
      hasFloatingButton: true,
      finishButtonText: '     Register    ',
      onFinish: () async {
        if (data1.isFormValid && data2.isFormValid && data3.isFormValid) {
          APIStatus status = await register(
              data1.firstNameController.text,
              data1.lastNameController.text,
              data1.emailController.text,
              data3.passwordController.text,
              data2.dateController.text,
              data2.addressController.text,
              data2.address2Controller.text,
              data2.phoneNumberController.text,
              data3.userTypeSelection.selectedUserType);

          if (context.mounted && status.statusCode == 200) {
            //saveInfo();
            (status.body);
            saveInfo(status.body[0], status.body[1], status.body[2]);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(status.body[2]),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please add valid inputs"),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      },
      finishButtonStyle: FinishButtonStyle(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.orange.shade800,
      ),
      controllerColor: Colors.orangeAccent,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      background: [
        Container(),
        Container(),
        Container(),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          child: S1(),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        Container(
          child: S2(),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        Container(
          child: S3(),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ],
    );
  }
}
