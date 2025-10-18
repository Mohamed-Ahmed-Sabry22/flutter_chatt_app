import 'package:flutter/material.dart';

class Customtextformfeild extends StatelessWidget {
  const Customtextformfeild({
    super.key,
    required this.hintText,
    required this.labelText,
    this.onChanged,
    this.validator,
    this.suffixWidget,
    required this.obscureText,
  });
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final Widget? suffixWidget;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 3),
        SizedBox(
          height: 60,
          child: TextFormField(
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            cursorColor: const Color.fromARGB(255, 97, 96, 96),
            cursorHeight: 18,
            decoration: InputDecoration(
              helperText: " ",
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
              errorStyle: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 236, 42, 28),
              ),
              contentPadding: EdgeInsets.only(top: 10, left: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 107, 106, 106),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 243, 29, 29),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 250, 23, 23),
                ),
              ),
              suffixIcon: suffixWidget,
            ),
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
