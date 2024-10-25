import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GameModel extends ChangeNotifier {
  int _state = 0;
  int _chips = 1000;

  int get state {
    return _state;
  }
  int get chips {
    return _chips;
  }

  void tappedSpin(int points) {
    _chips -= points;
    notifyListeners();
  }

  void winChips(int chips) {
    _chips += chips;
    notifyListeners();
  }

  void next() {
    _state += 1;
    print('_state = $_state');
    notifyListeners();
  }

  void start() {
    _state = 1;
    print('_state = $_state');
    notifyListeners();
  }

  void back() {
    if (_state > 0) {
      _state -= 1;
      notifyListeners();
    }
  }

  void reset() {
    _state = 0;
    notifyListeners();
  }
}
