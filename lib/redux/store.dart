import 'package:flutter/material.dart' hide Action, State;

class ReduxStore<Action, State> extends ChangeNotifier {
  State _state;
  Future<State> Function(State state, Action action) reducer;
  void Function(State state) refresh;
  ReduxStore(
      {required State initialState,
      required this.reducer,
      required this.refresh})
      : _state = initialState;
  State get state => _state;

  Future<void> dispatcher(Action action) async {
    _state = await reducer(state, action);
    // value++;
    notifyListeners();
    // print('PASSANDO NO SIM');
    // print(value);
  }

  void refreshOrderHistory() {
    // _state = refresh(state);
    // _refresh = await refresh!();
    // value++;
    notifyListeners();
    // print(value);
  }
}
