import 'package:flutter/material.dart';
import 'package:resto/User/theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UI_Components/CustomTextField.dart';
import '../Const/assests.dart';
import 'RegisterPage.dart';
import 'package:resto/Auth/API.dart';
import 'package:resto/User/Pages/Settings/DeveloperOptions.dart';
import '/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ForgotPasswordForm.dart';

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

  void _validateFirstName(String value) {
    // Additional validation logic for the first name if needed
    _formKey.currentState!.validate();
  }

  void saveInfo(String token, String type, int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('type', type);
    await prefs.setInt('id', id);
    widget.update();
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
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
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
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButtonTheme(
                            data: IconButtonThemeData(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColorsLight.primaryColor.shade500))),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const DeveloperOptions(),
                                  ));
                                },
                                icon: Icon(Icons.settings)),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                  child: Column(children: [
                    Center(
                      child: Text('Sign In',
                          style: GoogleFonts.dmSerifDisplay(
                            color: AppColorsLight.primaryColor,
                            fontSize: 45,
                          )),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Welcome back! Please enter your details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
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
                        } else if (value == 'admin') {
                          return null;
                        } else if (!value.contains("@")) {
                          return 'Please enter a valid email address';
                        }

                        return null;
                      },
                      hintText: 'Email',
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
                        data: FilledButtonThemeData(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    AppColorsLight.primaryColor.shade600),
                                elevation: MaterialStatePropertyAll(3))),
                        child: FilledButton(
                          onPressed: () async {
                            if (_mailController.text == 'admin' &&
                                _passwordController.text == "admin") {
                              APIStatus status =
                                  await login('admin@admin.com', 'adminadmin');

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return ForgotPasswordForm();
                                },
                              );
                              //foodTitles.insert(0, 'element');
                            });
                          },
                          child: const Text('Forgot Password?'),
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
