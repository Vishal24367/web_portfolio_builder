import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier {
  ViewState _state = ViewState.IDLE;

  ViewState get state => _state;

  set state(ViewState viewState) {
    _state = viewState;
    if (_state == ViewState.IDLE) notifyListeners();
  }
}

enum ViewState { IDLE, BUSY }
