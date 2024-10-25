import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramedia_test/store_view.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.text,
      required this.action,
      required this.size,
      this.available = true});
  String text;
  bool available;
  Size size;
  VoidCallback action;

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return InkWell(
        onTap: available ? action : null,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset(
            'assets/images/button.png',
            width: size.width,
          ),
          Text(text,
              style: TextStyle(
                  fontFamily: 'Amarante',
                  color: available
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 77, 77, 77),
                  fontSize: 22,
                  fontWeight: FontWeight.w400))
        ]));
  }
}
