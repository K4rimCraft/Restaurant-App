import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto/Auth/Pages/LoginPage.dart';
import 'package:resto/main.dart';
import 'package:resto/User/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_color.dart';
import '../../API/MenuAPI.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<List<UserData>> futureUser = fetchUserData();
  late TextEditingController firstNameControl;
  late TextEditingController lastNameControl;
  late TextEditingController emailControl;
  late TextEditingController longitudeControl;
  late TextEditingController latitudeControl;
  late TextEditingController phoneNumberControl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // categories = fetchCatagories();
    firstNameControl = TextEditingController();
    lastNameControl = TextEditingController();
    emailControl = TextEditingController();
    longitudeControl = TextEditingController();
    latitudeControl = TextEditingController();
    phoneNumberControl = TextEditingController();
    // nameControl.text = widget.cardData.name;
    // descControl.text = widget.cardData.description;
    // priceControl.text = widget.cardData.price.toString();
    // stockControl.text = widget.cardData.stock.toString();
    // selectedCategories = widget.cardData.catagories ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile",
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
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserData> userData = snapshot.data!;
                    if (userData.isNotEmpty) {
                      firstNameControl.text = userData.first.firstName;
                      lastNameControl.text = userData.first.lastName;
                      emailControl.text = userData.first.email;
                      longitudeControl.text =
                          userData.first.longitudeAddress.toString();
                      latitudeControl.text =
                          userData.first.latitudeAddress.toString();
                      phoneNumberControl.text = userData.first.phoneNumber;

                      return Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Flex(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 10, 0),
                                    child: TextFormField(
                                      controller: firstNameControl,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'First Name'),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Can\'t be empty!';
                                        }
                                        if (value.length < 3) {
                                          return 'Too Short';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 20, 0),
                                    child: TextFormField(
                                      controller: lastNameControl,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Last Name'),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Can\'t be empty!';
                                        }
                                        if (value.length < 3) {
                                          return 'Too Short';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flex(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 0),
                                    child: TextFormField(
                                      //expands: true,
                                      controller: emailControl,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Email',
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Can\'t be empty!';
                                        }
                                        if (value.length < 11) {
                                          return 'Too Short';
                                        }
                                        if (!value.contains('@')) {
                                          return 'Not a valid Email';
                                        }

                                        return null;
                                      },

                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flex(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 10, 0),
                                    child: TextFormField(
                                      controller: longitudeControl,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Longitude'),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Can\'t be empty!';
                                        }

                                        return null;
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^\d*\.?\d*)'))
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 20, 0),
                                    child: TextFormField(
                                      controller: latitudeControl,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Latitude'),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Can\'t be empty!';
                                        }

                                        return null;
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^\d*\.?\d*)'))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flex(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 0),
                                    child: TextFormField(
                                      //expands: true,
                                      controller: phoneNumberControl,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Phone Number',
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Can\'t be empty!';
                                        }

                                        return null;
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'(^[0-9]*$)'))
                                      ],
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                              child: FilledButton.tonal(
                                child: const Text(
                                  'Update Info',
                                  style: TextStyle(fontSize: 18),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _formKey.currentState!.validate();
                                  });

                                  if (_formKey.currentState!.validate()) {
                                    APIStatus status = await updateUser(
                                        UserData(
                                            personId: 0,
                                            firstName: firstNameControl.text,
                                            lastName: lastNameControl.text,
                                            longitudeAddress: double.parse(
                                                longitudeControl.text),
                                            latitudeAddress: double.parse(
                                                latitudeControl.text),
                                            email: emailControl.text,
                                            phoneNumber:
                                                phoneNumberControl.text));
                                    if (mounted) {
                                      if (status.statusCode == 200) {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight:
                                                      Radius.circular(5))),
                                          duration: const Duration(seconds: 1),
                                          content: Text(status.message),
                                        ));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Error"),
                                                content: Text(status.message),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text('Empty');
                    }
                  } else if (snapshot.hasError) {
                    return Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(10),
                        child: Card(
                          color: Theme.of(context).colorScheme.onError,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.error.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer),
                            ),
                          ),
                        ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                })),
      ),
    );
  }
}
