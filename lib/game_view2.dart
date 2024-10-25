import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:ramedia_test/button.dart';

import 'chip_view.dart';
import 'model/game_model.dart';
import 'game_view2.dart';
import 'slot_view1.dart';

class GameView2 extends StatefulWidget {
  GameView2({super.key});

  @override
  State<StatefulWidget> createState() => _GameView2State();
}

class _GameView2State extends State<GameView2> {
  late int step;
  List<String> _requirements = [
    'Win 10,000 Chips',
    'Get 3 matches in the slot.',
    'Make 10 spins.',
    'Win 20,000 Chips',
    'Get matches in all three rows simultaneously'
  ];
  List<Widget> _requirementsWidget = [];

  String get _text {
    String text = '';
    switch (step) {
      case 4:
        text = "Win 10,000 Chips";
      case 5:
        text =
            'These tasks symbolize the stages of happiness and luck that were once part of this town. If we complete them, the curse will be lifted, and the town will return to its former glory.';
      case 6:
        text =
            'I live with the hope that we can bring this town back. If the curse is lifted, people will start coming back, and the town will come alive again.';
    }
    return text;
  }

  String get question1 {
    String question = '';
    switch (step) {
      case 4:
        question = "What happens if we complete them?";
      case 5:
        question = "What's your plan afterward?";
      case 6:
        question = "I'll help you. Let's lift the curse together.";
    }
    return question;
  }

  String get question2 {
    String question = '';
    switch (step) {
      case 4:
        question = "How did you find this scroll?";
      case 5:
        question = "How do you cope with being here alone?";
      case 6:
        question = "This is too risky. I need to leave.";
    }
    return question;
  }

  String get question3 {
    String question = '';
    switch (step) {
      case 5:
        question = "What will happen when the town is freed from the curse?";
    }
    return question;
  }

  void incrementStep() {
    print('step - $step');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GameView2()));
    // }
  }

  @override
  void initState() {
    super.initState();
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
                      image: AssetImage('assets/images/background3.png'),
                      fit: BoxFit.cover)))),
      Positioned(
          top: state == 4 ? size.height * 0.05 : size.height * 0.15,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              alignment: AlignmentDirectional.center,
              height: state == 4 || state == 7
                  ? state == 7
                      ? size.height * 0.55
                      : size.height * 0.45
                  : size.height * 0.25,
              width: state == 4 || state == 7 ? size.width : size.width * 0.9,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: state == 4 || state == 7
                          ? AssetImage('assets/images/text_background2.png')
                          : AssetImage('assets/images/text_background1.png'),
                      fit: BoxFit.fill)),
              child: state == 4 || state == 7
                  ? listRequirements()
                  : Text(
                      _text,
                      style: const TextStyle(
                          fontFamily: 'Alatsi',
                          color: Colors.white,
                          fontSize: 20),
                      textAlign: TextAlign.justify,
                    ))),
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
      if (state != 7)
        Positioned(
            top: state == 4 || state == 7
                ? size.height * 0.4
                : size.height * 0.35,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: Image.asset(
              'assets/images/woman.png',
              height: state == 4 ? size.height * 0.6 : size.height * 0.7,
              width: state == 4 ? size.width * 0.7 : size.width * 0.8,
            )),
      if (state != 7)
        Positioned(
            bottom: 0, // size.height * 0.1,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                // alignment: AlignmentDirectional.bottomCenter,
                height: size.height * 0.25,
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/questions_background.png'),
                        fit: BoxFit.contain)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Provider.of<GameModel>(context, listen: false)
                                .next();
                            if (state == 7) {}
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
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: size.height * 0.02),
                      GestureDetector(
                          onTap: () {
                            Provider.of<GameModel>(context, listen: false)
                                .next();
                            if (state == 6) {
                              Provider.of<GameModel>(context, listen: false)
                                  .reset();
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
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
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(height: size.height * 0.02),
                      if (question3.isNotEmpty)
                        GestureDetector(
                            onTap: () {
                              Provider.of<GameModel>(context, listen: false)
                                  .next();
                            },
                            child: Text(
                              question3,
                              style: const TextStyle(
                                  fontFamily: 'Alatsi',
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 4, 217, 254)),
                              textAlign: TextAlign.center,
                            )),
                    ])))
      else
        Positioned(
            bottom: size.height * 0.15,
            left: size.width * 0.2,
            right: size.width * 0.2,
            child: CustomButton(
                text: 'START',
                action: () {
                  Provider.of<GameModel>(context, listen: false).next();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SlotView1()));
                },
                size: Size(size.width * 0.5, 100)))
    ]));
  }

  Widget _buildRequirement(int i) {
    var size = MediaQuery.of(context).size;
    return Container(
        alignment: AlignmentDirectional.center,
        width: size.width * 0.7,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(102, 183, 138, 90)),
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                    fontFamily: 'Alatsi',
                    color: Color.fromARGB(255, 57, 21, 0),
                    fontSize: 20),
                textAlign: TextAlign.center,
              )),
          SizedBox(width: 5),
          Flexible(
              child: Text(_requirements[i],
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                      fontFamily: 'Alatsi',
                      color: Color.fromARGB(255, 57, 21, 0),
                      fontSize: 20),
                  textAlign: TextAlign.center))
        ]));
  }

  Widget listRequirements() {
    if (_requirementsWidget.isEmpty) {
      for (var item = 0; item < _requirements.length; item++) {
        _requirementsWidget.add(_buildRequirement(item));
      }
    }
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _requirementsWidget));
  }
}
