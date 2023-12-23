import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/SignupData.dart';
import '../UI_Components/CustomTextField.dart';
import '../Const/assests.dart';

class S3 extends StatefulWidget {
  @override
  State<S3> createState() => _ShoeAppSignInPageState();
}

class _ShoeAppSignInPageState extends State<S3> {
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
    final data = Provider.of<s3_data>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: data.formKey,
          child: Column(
            children: [
              const SizedBox(height: 250),
              MyTextField(
                onChanged: (password) {
                  data.onPasswordChanged(password);

                  data.isFormValid = data.formKey.currentState!.validate();
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
              MyTextField(
                onChanged: (value) {
                  data.isFormValid = data.formKey.currentState!.validate();
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
              const SizedBox(
                height: 33,
              ),
              const SizedBox(height: 25),
              data.userTypeSelection,
            ],
          ),
        ),
      ),
    );
  }
}
