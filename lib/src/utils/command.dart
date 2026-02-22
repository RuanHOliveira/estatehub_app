import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter/material.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A params);

abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;
  bool get running => _running;

  Result<T>? _result;
  Result? get result => _result;

  bool get success => _result is Success;
  bool get error => _result is Error;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return;
    _result = null;
    _running = true;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command0<T> extends Command<T> {
  Command0(this.action);

  final CommandAction0<T> action;

  Future<void> execute() async {
    await _execute(action);
  }
}

class Command1<T, A> extends Command<T> {
  Command1(this.action);

  final CommandAction1<T, A> action;

  Future<void> execute(A params) async {
    await _execute(() => action(params));
  }
}
