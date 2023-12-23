import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../Const/assests.dart'; // Assuming you have a file named 'assets.dart' for your assets

class MyDateField extends StatefulWidget {
  final TextEditingController controller;
  final String icon;
  final Color iconColor;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  MyDateField({
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
  _MyDateFieldState createState() => _MyDateFieldState();
}

class _MyDateFieldState extends State<MyDateField> {
  late String data;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: widget.iconColor),
            child: SvgPicture.asset(widget.icon),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.dark().copyWith(
                    primaryColor: Colors.deepOrange, // Your desired color here
                    hintColor: Colors.deepOrange,
                    colorScheme: ColorScheme.light(primary: Colors.deepOrange),
                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              setState(() {
                data = DateFormat("yyyy-MM-dd").format(pickedDate);
                widget.controller.text = data;
              });

              widget.onChanged?.call(data);
            }
          },
        ),
      ),
    );
  }
}
