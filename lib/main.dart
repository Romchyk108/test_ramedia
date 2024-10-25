import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'
    show FlutterNativeSplash;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ramedia_test/slot_view1.dart';

import 'button.dart';
import 'store_view.dart';
import 'chip_view.dart';
import 'package:ramedia_test/game_view1.dart';
import 'game_view2.dart';
import 'model/game_model.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => GameModel()),
  ], child: MyApp()));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, gameModel, child) {
      return MaterialApp(home: const HomeView());
    });
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() =>
      _HomeViewState(volumeOff: true, withHomeButtons: false);
}

class _HomeViewState extends State<HomeView> {
  _HomeViewState({required this.volumeOff, required this.withHomeButtons});
  bool volumeOff;
  bool withHomeButtons;

  void continueGame(int state) {
    if (state > 0 && state < 4) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GameView1()));
    }
    if (state > 3 && state < 8) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GameView2()));
    }
    if (state > 7 && state < 11) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SlotView1()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int state = Provider.of<GameModel>(context, listen: true).state;
    return Scaffold(
        body: Stack(children: [
      Center(
          child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/backgroung1.png'),
                      fit: BoxFit.cover)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButton(
                        text: 'NEW GAME',
                        action: () {
                          Provider.of<GameModel>(context, listen: false).start();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameView1()));
                        },
                        size: Size(size.width * 0.5, 100)),
                    SizedBox(height: size.height * 0.01),
                    CustomButton(
                        text: 'CONTINUE',
                        action: () {
                          continueGame(state);
                        },
                        available: state != 0,
                        size: Size(size.width * 0.5, 100)),
                    SizedBox(height: size.height * 0.01),
                    CustomButton(
                        text: 'STORE',
                        action: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoreView()));
                        },
                        size: Size(size.width * 0.5, 100)),
                  ]))),
      Positioned(
          top: size.height * 0.05,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                onPressed: () => ({
                      setState(() {
                        volumeOff = !volumeOff;
                      })
                    }),
                icon: volumeOff
                    ? Image.asset('assets/images/volume_off.png',
                        width: 32, height: 32)
                    : Image.asset('assets/images/volume.png',
                        width: 32, height: 32)),
            IconButton(
                onPressed: () => ({}),
                icon: Image.asset('assets/images/home_icon.png',
                    width: 32, height: 32)),
            Spacer(),
            ChipView()
          ]))
    ]));
  }
}
