import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Const/assests.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String icon;
  final Function(String)?
      onChanged; // Change the type of onChanged to Function(String)?

  final Color iconColor;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.iconColor,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.validator,
    required this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      // Call the onChanged function with the updated value
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: AppColors.kLightWhite2,
        filled: true,
        errorMaxLines: 3,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor),
            child: SvgPicture.asset(icon),
          ),
        ),
      ),
    );
  }
}

class MyPassField extends StatefulWidget {
  final TextEditingController controller;
  final String icon;
  final Color iconColor;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  MyPassField({
    Key? key,
    required this.iconColor,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.validator,
    required this.onChanged,
    this.keyboardType,
  }) : super(key: key);

  @override
  _MyPassFieldState createState() => _MyPassFieldState();
}

class _MyPassFieldState extends State<MyPassField> {
  late String data;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: AppColors.kLightWhite2,
        filled: true,
        errorMaxLines: 3,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: widget.iconColor),
            child: SvgPicture.asset(widget.icon),
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;

  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: color ?? AppColors.kPrimary, fontSize: fontSize ?? 14),
      ),
    );
  }
}
