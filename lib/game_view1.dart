import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

import 'chip_view.dart';
import 'game_view2.dart';
import 'model/game_model.dart';

class GameView1 extends StatefulWidget {
  GameView1({super.key});

  @override
  State<StatefulWidget> createState() => _GameView1State();
}

class _GameView1State extends State<GameView1> {
  late int step;
  String get _text {
    String text = '';
    switch (step) {
      case 1:
        text =
            "Hi. I'm Maria, and I'm one of the few left in this cursed town. This used to be a place of joy and winnings, but now... look around.";
      case 2:
        text =
            "I stayed because my grandfather owned one of these casinos. I want to restore the town to its former glory, but I can't do it alone.";
      case 3:
        text =
            "I can't leave until the curse is lifted. I have a scroll that explains how to lift the curse. But to do that, we need to complete several challenges in the casino.";
    }
    return text;
  }

  String get question1 {
    String question = '';
    switch (step) {
      case 1:
        question = "What happened to the town?";
      case 2:
        question = "Why can't you leave?";
      case 3:
        question = "What kind of challenges?";
    }
    return question;
  }

  String get question2 {
    String question = '';
    switch (step) {
      case 1:
        question = "What happened to the town?";
      case 2:
        question = "How do you plan to save the town?";
      case 3:
        question = "Show me the scroll.";
    }
    return question;
  }

  String get question3 {
    String question = '';
    switch (step) {
      case 1:
        question = "How can the curse be lifted?";
      case 2:
        question = "Do you have a plan?";
      case 3:
        question = "How can I help you?";
    }
    return question;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int state = Provider.of<GameModel>(context, listen: true).state;
    step = state;
    return Scaffold(
        body: Stack(children: [
      Center(
          child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background2.png'),
                      fit: BoxFit.cover)))),
      Positioned(
          top: size.height * 0.05,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                onPressed: () =>
                    ({Navigator.popUntil(context, (route) => route.isFirst)}),
                icon: Image.asset('assets/images/home_icon.png',
                    width: 32, height: 32)),
            Spacer(),
            ChipView()
          ])),
      Positioned(
          top: size.height * 0.1,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              alignment: AlignmentDirectional.center,
              height: size.height * 0.3,
              width: size.width * 0.9,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/text_background1.png'),
                      fit: BoxFit.contain)),
              child: Text(
                _text,
                style: const TextStyle(
                    fontFamily: 'Alatsi', color: Colors.white, fontSize: 20),
                textAlign: TextAlign.justify,
              ))),
      Positioned(
          top: size.height * 0.3,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Image.asset(
            'assets/images/woman.png',
            height: size.height * 0.7,
            width: size.width * 0.8,
          )),
      Positioned(
          bottom: 0, // size.height * 0.1,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              // alignment: AlignmentDirectional.bottomCenter,
              height: size.height * 0.25,
              width: size.width * 0.9,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/questions_background.png'),
                      fit: BoxFit.contain)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Provider.of<GameModel>(context, listen: false).next();
                          if (state == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameView2()));
                          }
                        },
                        child: Text(
                          question1,
                          style: TextStyle(
                              fontFamily: 'Alatsi',
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Color.fromARGB(255, 4, 217, 254)),
                          textAlign: TextAlign.start,
                        )),
                    SizedBox(height: size.height * 0.02),
                    GestureDetector(
                        onTap: () {
                          Provider.of<GameModel>(context, listen: false).next();
                          if (state == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameView2()));
                          }
                        },
                        child: Text(
                          question2,
                          style: TextStyle(
                              fontFamily: 'Alatsi',
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Color.fromARGB(255, 4, 217, 254)),
                          textAlign: TextAlign.start,
                        )),
                    SizedBox(height: size.height * 0.02),
                    GestureDetector(
                        onTap: () {
                          Provider.of<GameModel>(context, listen: false).next();
                          if (state == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameView2()));
                          }
                        },
                        child: Text(
                          question3,
                          style: TextStyle(
                              fontFamily: 'Alatsi',
                              color: Colors.white,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  Color.fromARGB(255, 4, 217, 254)),
                          textAlign: TextAlign.start,
                        )),
                  ])))
    ]));
  }
}
