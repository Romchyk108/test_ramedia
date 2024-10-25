import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/game_model.dart';

class ChipView extends StatelessWidget {
  ChipView({super.key});

  @override
  Widget build(BuildContext context) {
    int chips = Provider.of<GameModel>(context, listen: true).chips;
    return Stack(alignment: AlignmentDirectional.centerStart, children: [
      Container(
          alignment: AlignmentDirectional.centerEnd,
          width: 137,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Rectangle4.png'))),
          child: Text('$chips',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center)),
      Image.asset('assets/images/chip_red.png', width: 44, height: 44)
    ]);
  }
}