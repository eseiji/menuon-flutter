import 'package:flutter/material.dart' hide Action, State;

class ReduxStore<Action, State> extends ChangeNotifier {
  State _state;
  Future<State> Function(State state, Action action) reducer;
  ReduxStore({required State initialState, required this.reducer})
      : _state = initialState;
  State get state => _state;

  void dispatcher(Action action) async {
    _state = await reducer(state, action);
    // value++;
    notifyListeners();
    // print('PASSANDO NO SIM');
    // print(value);
  }
}
