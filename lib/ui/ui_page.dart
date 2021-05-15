import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';

class EditTextUtils {
  TextFormField getCustomEditTextArea(
      {String labelValue = '',
      String hintValue = '',
      Function validator,
      IconData icon,
      bool validation,
      TextEditingController controller,
      TextInputType keyboardtype = TextInputType.text,
      String validationErrorMsg}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        prefixStyle: TextStyle(color: Style.orangeColor),
        fillColor: Colors.white.withOpacity(0.6),
        filled: true,
        isDense: true,
        labelStyle: TextStyle(color: Style.orangeColor),
        focusColor: Style.orangeColor,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
          borderSide: new BorderSide(
            color:Style.orangeColor,
            width: 1.0,
          ),
        ),
        disabledBorder: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(8.0),
          ),
          borderSide: new BorderSide(color: Style.orangeColor, width: 1.0),
        ),
        hintText: hintValue,
        labelText: labelValue,
      ),
      validator: validator,
    );
  }
}
