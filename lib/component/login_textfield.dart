import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {Key key,
      @required this.hint,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPassword})
      : super(key: key);
  final String hint;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    bool _isPassword = isPassword ?? false;
    return Container(
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        focusNode: focusNode,
        obscureText: _isPassword,
        decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
            filled: true,
            fillColor: Color(0xFFF2F2F2)),
      ),
    );
  }
}
