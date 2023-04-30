import 'package:flutter/widgets.dart';

class ObservableValue<T> {
  ObservableValue({required T defaultValue}) : _value = defaultValue;

  late T _value;
  T get value => _value;
  set value(T newValue) {
    _value = newValue;
    for (var listener in _listeners) {
      listener.call();
    }
  }

  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }
}

class Observable<T> extends StatefulWidget {
  final ObservableValue<T> observable;
  final Widget Function(BuildContext context, T value) builder;

  const Observable({
    Key? key,
    required this.observable,
    required this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ObservableState<T>();
}

class _ObservableState<T> extends State<Observable<T>> {
  late T value;
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    value = widget.observable._value;
    _addListener();
  }

  @override
  void didUpdateWidget(Observable<T> oldWidget) {
    if (oldWidget.observable != widget.observable) {
      oldWidget.observable.removeListener(listener);
      value = widget.observable._value;
      _addListener();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.observable.removeListener(listener);
    super.dispose();
  }

  void _addListener() {
    listener = _valueChangesListener;
    widget.observable.addListener(listener);
  }

  void _valueChangesListener() =>
      setState(() => value = widget.observable._value);

  @override
  Widget build(BuildContext context) => widget.builder(context, value);
}
