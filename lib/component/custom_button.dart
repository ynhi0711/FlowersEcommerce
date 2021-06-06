import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key key,
      @required this.text,
      @required this.press,
      this.isOutline,
      this.isLoading})
      : super(key: key);

  final String text;
  final Function press;
  final bool isOutline;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    Size _screen = MediaQuery.of(context).size;
    bool _isOutline = isOutline ?? false;
    bool _isLoading = isLoading ?? false;
    return Container(
      width: double.maxFinite,
      height: _screen.height * 0.07,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: TextButton(
                onPressed: press,
                child: Visibility(visible: !_isLoading, child: Text(text)),
                style: TextButton.styleFrom(
                    primary: _isOutline ? Colors.black : Colors.white,
                    backgroundColor: _isOutline ? Colors.white : Colors.black,
                    textStyle: TextStyle(
                        fontSize: 16,
                        color: _isOutline ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        side: BorderSide(width: 1, color: Colors.black))),
              ),
            ),
          ),
          Visibility(
            visible: _isLoading,
            child: Center(
                child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: _isOutline ? Colors.black : Colors.white,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
