import 'package:flutter/material.dart';
import '../UI_Components/CustomTextField.dart';
import '../UI_Components/PrimaryButton.dart';
import '../Const/assests.dart';
import 'RegisterPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../UI_Components/DateTextField.dart';
import 'ForgotPasswordForm.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  int selected = 0;
  void _validateFirstName(String value) {
    // Additional validation logic for the first name if needed
    _formKey.currentState!.validate();
  }

  final ScrollController yourScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 300,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomSheet: Container(
              padding: const EdgeInsets.all(40),
              alignment: Alignment.topCenter,
              child: Form(
                  key: _formKey,
                  child: [
                    ListView(children: <Widget>[
                      const Text(
                        'Did You Forget Your Password?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        onChanged: _validateFirstName,
                        iconColor: AppColors.kLavender,
                        controller: _mailController,
                        keyboardType: TextInputType.emailAddress,
                        icon: AppAssets.kMail,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          } else if (!value.contains("@")) {
                            return 'Please enter a valid email address';
                          }

                          return null;
                        },
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 50,
                        child: FilledButton.tonal(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                            child: const Text('Send Email')),
                      )
                    ]),
                  ][selected]),
            ),
          ),
        ),
      ),
    );
  }
}
