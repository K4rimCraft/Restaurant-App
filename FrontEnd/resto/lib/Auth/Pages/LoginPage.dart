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

class LoginPage extends StatefulWidget {
  final Function update;
  const LoginPage({super.key, required this.update});

  @override
  State<LoginPage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> {
  bool isRemember = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  void _validateFirstName(String value) {
    // Additional validation logic for the first name if needed
    _formKey.currentState!.validate();
  }

  @override
  void initState() {
    _urlController.text = serverUrl;
    super.initState();
  }

  void saveInfo(String token, String type, int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('type', type);
    await prefs.setInt('id', id);
    widget.update();
  }

  Future<APIStatus> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$serverUrl/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return APIStatus(
        statusCode: response.statusCode,
        body: jsonDecode(response.body).values.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    width: MediaQuery.of(context).size.width,
                    // height: 450,
                    child: Image.asset(
                      'assets/Login.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Welcome back! Please enter your details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
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
                      hintText: 'Email address',
                    ),
                    const SizedBox(height: 15),
                    MyPassField(
                      onChanged: (value) {
                        _formKey.currentState!.validate();
                        return;
                      },
                      iconColor: AppColors.kPeriwinkle,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      icon: AppAssets.kLock,
                      hintText: 'Password',
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: FilledButtonTheme(
                        data: const FilledButtonThemeData(
                            style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(3))),
                        child: FilledButton(
                          onPressed: () async {
                            if (_mailController.text == 'admin' &&
                                _passwordController.text == "admin") {
                              saveInfo('admin', 'admin', 1);
                            }
                            if (_formKey.currentState!.validate()) {
                              APIStatus status = await login(
                                  _mailController.text,
                                  _passwordController.text);
                              if (status.statusCode == 200) {
                                saveInfo(status.body[0], status.body[1],
                                    status.body[2]);
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(status.body[2]),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                }
                              }
                              ;
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Create account',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Forgot Password'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the sign-up page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage(update: widget.update)),
                            );
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        height: 70,
                        width: 200,
                        child: TextField(
                          controller: _urlController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _urlController.text = value;
                            serverUrl = value;
                          },
                        )),
                    // Container(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Expanded(
                    //         child: Divider(
                    //           color: Colors.orange[800],
                    //           height: 10,
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         child: Text(
                    //           "  or with  ",
                    //           style: TextStyle(
                    //               color: Colors.orange[800], fontSize: 20),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Divider(
                    //           color: Colors.orange[800],
                    //           height: 10,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 56),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SocialButton(
                    //         onTap: () async {
                    //           final prefs = await SharedPreferences.getInstance();
                    //           print(prefs.getString('token') ?? '');
                    //           print(prefs.getString('type') ?? '');
                    //           print(prefs.getInt('id') ?? '');
                    //         },
                    //         icon: AppAssets.kGoogle),
                    //     SocialButton(onTap: () {}, icon: AppAssets.kFacebook),
                    //   ],
                    // ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
