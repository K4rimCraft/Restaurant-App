import 'package:flutter/material.dart';
import '../UI_Components/CustomTextField.dart';
import '../Const/assests.dart';
import '../Providers/SignupData.dart';
import 'package:provider/provider.dart';
import 'package:resto/Auth/API.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  double? height = 250;

  int selected = 0;
  String email = '';
  String code = '';
  void _validateEmailName(String value) {
    // Additional validation logic for the first name if needed
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
          height: height,
          child: Container(
            padding: const EdgeInsets.all(40),
            alignment: Alignment.topCenter,
            child: Form(
                key: _formKey,
                child: [
                  ListView(controller: yourScrollController, children: <Widget>[
                    const Text(
                      'Did You Forget Your Password?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      onChanged: _validateEmailName,
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
                      child: FilledButton.tonal(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              email = _mailController.text;
                              APIStatus2 status =
                                  await generateCode(_mailController.text);
                              print(status.message);
                              if (status.statusCode == 200) {
                                code = status.message;
                                setState(() {
                                  selected = 1;
                                });
                              } else {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          showCloseIcon: true,
                                          duration: const Duration(seconds: 3),
                                          content: Text(status.message)));
                                }
                              }
                            }
                          },
                          child: const Text('Send Email')),
                    )
                  ]),
                  ListView(controller: yourScrollController, children: <Widget>[
                    const Text(
                      'Enter the code sent in your email.',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      // onChanged: (ss) {
                      //   _formKey.currentState!.validate();
                      // },
                      controller: _codeController,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Code',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.numbers),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a code';
                        } else if (code != value) {
                          return 'Code does not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: FilledButton.tonal(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ChangePass(
                                    email: email,
                                  );
                                }));
                                //selected = 2;
                              });
                            }
                          },
                          child: const Text('Check')),
                    )
                  ]),
                ][selected]),
          ),
        ),
      ),
    );
  }
}

class ChangePass extends StatefulWidget {
  final String email;
  const ChangePass({super.key, required this.email});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  void initState() {
    super.initState();
    // Use WidgetsBinding to add a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call your validation function when the widget is initialized
      validateForm();
    });
  }


// Validation function
  void validateForm() {
    final data = Provider.of<s3_data>(context, listen: false);

    if (!data.passwordController.text.isEmpty ||
        !data.passwordRepeatController.text.isEmpty) {
      data.validatePassword(data.passwordRepeatController.text);
      data.validatePassword(data.passwordRepeatController.text);
      // Set the initial form validity
      data.isFormValid = data.formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<forgot_data>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: data.formKey,
          child: Column(
            children: [
              const SizedBox(height: 180),
              MyPassField(
                onChanged: (password) {
                  data.onPasswordChanged(password ?? '');

                  data.isFormValid = data.formKey.currentState!.validate();
                  return;
                },
                validator: (value) {
                  return data.validatePassword(value);
                },
                iconColor: AppColors.kPeriwinkle,
                controller: data.passwordController,
                keyboardType: TextInputType.visiblePassword,
                icon: AppAssets.kLock,
                hintText: 'Password',
              ),
              const SizedBox(
                height: 15,
              ),
              MyPassField(
                onChanged: (value) {
                  data.isFormValid = data.formKey.currentState!.validate();
                  return;
                },
                validator: (value) {
                  return value != data.passwordController.text
                      ? "Password not matched"
                      : null;
                },
                iconColor: AppColors.kPeriwinkle,
                controller: data.passwordRepeatController,
                keyboardType: TextInputType.visiblePassword,
                icon: AppAssets.kLock,
                hintText: ' Repeat Password',
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data.isPassword8Char ? Colors.green : Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("At least 8 characters"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data.isPasswordHas1Number
                          ? Colors.green
                          : Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("At least 1 number"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data.hasUppercase ? Colors.green : Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("Has Uppercase"),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data.hasLowercase ? Colors.green : Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("Has  Lowercase "),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data.hasSpecialCharacters
                          ? Colors.green
                          : Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text("Has  Special Characters "),
                ],
              ),
              const SizedBox(height: 10),
              FilledButton.tonal(
                  onPressed: () async {
                    if (data.formKey.currentState!.validate()) {
                      APIStatus2 status = await changePassword(
                          widget.email, data.passwordController.text);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            duration: const Duration(seconds: 3),
                            content: Text(status.message)));
                        data.passwordController.text = '';
                        data.passwordRepeatController.text = '';
                        while (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }
                    }
                  },
                  child: const Text('Change Password')),
            ],
          ),
        ),
      ),
    );
  }
}
