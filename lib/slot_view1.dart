import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ramedia_test/button.dart';
import 'package:ramedia_test/store_view.dart';
import 'dart:math';

import 'chip_view.dart';
import 'model/game_model.dart';

class SlotView1 extends StatefulWidget {
  SlotView1({super.key});

  @override
  State<StatefulWidget> createState() => _SlotView1State();
}

class _SlotView1State extends State<SlotView1>
    with SingleTickerProviderStateMixin {
  List<String> symbols = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  Random random = Random();
  List<int> resultIndices = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  List<int> stars = [];
  bool spinning = false;
  bool addedChips = false;
  bool notEnoughMoney = false;
  int points = 100;
  int winChips = 0;
  int goalChip = 10000;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: 4 * 3.1514).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut,
    ))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                spinning = false;
              });
            }
          });
    if (symbols.isEmpty) {
      for (int i = 0; i < 9; i++) {
        symbols.add('assets/images/slot$i.png');
      }
    }
  }

  void spin() {
    stars.clear();
    addedChips = false;
    if (Provider.of<GameModel>(context, listen: false).chips >= points) {
      Provider.of<GameModel>(context, listen: false).tappedSpin(points);

      if (!spinning) {
        setState(() {
          spinning = true;
        });

        _controller.reset();
        _controller.forward();

        for (int i = 0; i < 9; i++) {
          // Затримка перед зупинкою кожного барабана
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              resultIndices[i] = random.nextInt(symbols.length);
            });
          });
        }
      }
    } else {
      setState(() {
        points = 100;
        notEnoughMoney = false;
      });
    }
  }

  void checkWins() {
    if (resultIndices[0] == resultIndices[1] &&
        resultIndices[0] == resultIndices[2]) {
      stars.addAll([0, 1, 2]);
      if (!addedChips) {
        Future.microtask(() {
          setState(() {
            winChips += points * 10;
            Provider.of<GameModel>(context, listen: false)
                .winChips(points * 10);
            addedChips = true;
          });
        });
      }
    }
    if (resultIndices[3] == resultIndices[4] &&
        resultIndices[3] == resultIndices[5]) {
      stars.addAll([3, 4, 5]);
      if (!addedChips) {
        Future.microtask(() {
          setState(() {
            winChips += points * 10;
            Provider.of<GameModel>(context, listen: false)
                .winChips(points * 10);
            addedChips = true;
          });
        });
      }
    }
    if (resultIndices[6] == resultIndices[7] &&
        resultIndices[6] == resultIndices[8]) {
      stars.addAll([6, 7, 8]);
      if (!addedChips) {
        Future.microtask(() {
          setState(() {
            winChips += points * 10;
            Provider.of<GameModel>(context, listen: false)
                .winChips(points * 10);
            addedChips = true;
          });
        });
      }
    }
    if (goalChip <= winChips) {
      Future.microtask(() {
        setState(() {
          // Provider.of<GameModel>(context, listen: false).next();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => SlotView2()));
        });
      });
    }
  }

  Widget _buildReel(int reelIndex) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      if (stars.contains(reelIndex))
        Container(
            width: 85,
            height: 85,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: Colors.transparent),
            child: OverflowBox(
                maxWidth: 150,
                maxHeight: 150,
                child: Center(child: Image.asset('assets/images/star.png')))),
      AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.rotate(angle: _animation.value, child: child);
          },
          child: Container(
              width: 85,
              height: 85,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: Colors.transparent),
              child: Center(
                  child: Image.asset(symbols[resultIndices[reelIndex]]))))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (!spinning) {
      checkWins();
    }
    if (Provider.of<GameModel>(context, listen: false).chips < 100) {
      Future.microtask(() {
        setState(() {
          notEnoughMoney = true;
        });
      });
    }

    return Scaffold(
        body: Stack(children: [
      Center(
          child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background4.png'),
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
          top: size.height * 0.08,
          child: Image.asset('assets/images/left_side_slot.png',
              width: size.width * 0.14, height: size.height * 0.6)),
      Positioned(
          top: size.height * 0.08,
          left: size.width * 0.86,
          right: size.width * 0.02,
          child: Image.asset('assets/images/right_side_slot.png',
              width: size.width * 0.14, height: size.height * 0.6)),
      // Слоти
      Positioned(
          top: size.height * 0.15,
          left: size.width * 0.07,
          right: size.width * 0.07,
          child: Container(
              width: size.width * 0.9,
              height: size.height * 0.43,
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/slot_background.png')),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      _buildReel(0),
                      _buildReel(1),
                      _buildReel(2)
                    ]),
                    SizedBox(height: 10),
                    Row(children: [
                      _buildReel(3),
                      _buildReel(4),
                      _buildReel(5)
                    ]),
                    SizedBox(height: 10),
                    Row(children: [
                      _buildReel(6),
                      _buildReel(7),
                      _buildReel(8)
                    ]),
                    SizedBox(height: 10),
                  ]))),

      notEnoughMoney
          ?
          notEnoughMoneyWidget(size)
          : Positioned(
              bottom: size.height * 0.05,
              left: size.width * 0.2,
              right: size.width * 0.2,
              child: Column(children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    height: size.height * 0.12,
                    width: size.width * 0.75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                                'assets/images/chips_background.png'))),
                    child: Text('$winChips/$goalChip Chips',
                        style: const TextStyle(
                            fontFamily: 'Alatsi',
                            color: Color.fromARGB(255, 57, 21, 0),
                            fontSize: 20))),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: spinning ? null : spin,
                    child: Container(
                        width: size.width * 0.3,
                        height: size.height * 0.08,
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/images/spin_background.png'))),
                        child: const Text('SPIN',
                            style: TextStyle(
                                fontFamily: 'Amarante',
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 22,
                                fontWeight: FontWeight.w400)))),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Image.asset('assets/images/minus.png',
                                  height: 40, width: 40),
                              onPressed: () {
                                if (points > 100) {
                                  setState(() {
                                    points -= 100;
                                  });
                                }
                              }),
                          SizedBox(width: 10),
                          Text('$points',
                              style: const TextStyle(
                                  fontFamily: 'Alatsi',
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20)),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Image.asset('assets/images/plus.png',
                                height: 40, width: 40),
                            onPressed: () {
                              setState(() {
                                points += 100;
                              });
                            },
                          ),
                        ]))
              ]))
    ]));
  }

  Widget notEnoughMoneyWidget(Size size) {
    return Stack(children: [
      Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset('assets/images/woman.png',
              height: size.height * 0.4, width: size.width * 0.5)),
      Positioned(
          bottom: size.height * 0.1,
          right: size.width * 0.1,
          child: Container(
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.all(10),
            width: size.width * 0.55,
            height: size.height * 0.17,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                    image: AssetImage('assets/images/text_background1.png'))),
            child: Text("You don't have enough chips to complete the task", style: const TextStyle(
                fontFamily: 'Alatsi',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18)),
          )),
            Positioned(
                bottom: size.height * 0.075,
                right: size.width * 0.17,
                child:
            CustomButton(text: "BUY SHIPS", action: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StoreView()));
            }, size: Size(size.width * 0.4, 100)))
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
