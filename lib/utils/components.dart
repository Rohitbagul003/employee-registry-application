import 'package:flutter/material.dart';

class Components {
  InputDecoration textFormFieldDecoration(
    String hintText,
    IconData icon,
  ) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        size: 18,
        color: Colors.blue,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(0.4), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
      ),
    );
  }

  InputDecoration textFormFieldDecorationWithSuffix(
    String hintText,
    IconData icon,
    IconData suffixIcon,
  ) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        size: 18,
        color: Colors.blue,
      ),
      suffixIcon: Icon(
        suffixIcon,
        size: 18,
        color: Colors.blue,
      ),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.withOpacity(0.4), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
      ),
    );
  }

  Future showDatePickerDecoration(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
  }
}
