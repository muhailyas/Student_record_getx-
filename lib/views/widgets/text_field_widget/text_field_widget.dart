import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../validators/validation_functions.dart';
import '../../home/home_screen.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.function,
      this.autoFocus = false,
      this.suffixIcon});
  final String hintText;
  final TextEditingController controller;
  final Function function;
  final IconData? suffixIcon;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: autoFocus,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return '$hintText is required';
          } else if (!validateFunctions(function, value)) {
            return 'enter valid $hintText';
          }
          return null;
        },
        keyboardType: function == isValidAge ||
                function == isValidMobileNumber ||
                function == isValidBatch
            ? TextInputType.number
            : null,
        style: const TextStyle(color: kFontColorWhite),
        onChanged: (value) {
          if (suffixIcon != null) {
            studentViewController.searchResult(value);
          }
        },
        decoration: InputDecoration(
            labelText: hintText,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(
                      suffixIcon,
                      color: kFontColorWhite,
                    ),
                    onPressed: () {
                      controller.text.isEmpty
                          ? searchController.toggleSearch()
                          : controller.clear();
                      if (suffixIcon != null) {
                        studentViewController.searchResult(controller.text);
                      }
                    },
                  )
                : null,
            labelStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderRadius: kBorderRadius20,
                borderSide: const BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: kBorderRadius20,
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: kBorderRadius20)),
      ),
    );
  }
}
