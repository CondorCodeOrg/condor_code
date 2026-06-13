import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class EventsStreamProvider<T> {
  final PublishSubject<T> _events = PublishSubject<T>();

  Stream<T> get events => _events.stream;

  void addEvent(T event) => _events.add(event);

  @mustCallSuper
  void dispose() {
    _events.close();
  }
}
