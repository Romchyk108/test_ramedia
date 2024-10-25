import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'button.dart';
import 'chip_view.dart';

class StoreView extends StatefulWidget {
  StoreView();

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  List<String> cardNames = [
    'assets/images/2chips2.png',
    'assets/images/3chips2.png',
    'assets/images/5chips2.png',
    'assets/images/10chips2.png'
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      Center(
          child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/backgroung1.png'),
                      fit: BoxFit.cover)))),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color:
              Colors.black.withOpacity(0)
        )),
      Positioned(
          top: size.height * 0.05,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                onPressed: () => ({Navigator.pop(context)}),
                icon: Image.asset('assets/images/home_icon.png',
                    width: 32, height: 32)),
            Spacer(),
            ChipView()
          ])),
      Center(
          child: SizedBox(
              width: size.width * 0.9,
              child: GridView.builder(
                  itemCount: cardNames.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 210,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 40.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {},
                        child: Image.asset(cardNames[index]));
                  })))
    ]));
  }
}
