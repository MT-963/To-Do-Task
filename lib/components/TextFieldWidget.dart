import 'package:flutter/material.dart';

import '../const/colors.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.typeName,
      required this.icon,
      required this.validator,
      this.obscureText = false});
  final TextEditingController controller;
  final FocusNode focusNode;
  final String typeName;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              validator: validator,
              obscureText: obscureText,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    icon,
                    color:
                        focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  hintText: typeName,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xffc5c5c5),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: custom_green,
                      width: 2.0,
                    ),
                  )),
            ),
          ),
        ),
      );
}
