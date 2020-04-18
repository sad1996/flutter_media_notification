import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class MediaNotification {
  static const MethodChannel _channel = MethodChannel('media_notification');
  static final Map<String, Function> _listeners = Map();
  
  Future<dynamic> _myUtilsHandler(MethodCall methodCall) async {
    // Вызываем слушателя события
    _listeners.forEach((String event, Function callback) {
      if (methodCall.method == event) {
        callback();
        return true;
      }
      return null;
    });
  }

  Future show({@required String title, @required String author, bool play = true}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'title': title,
      'author': author,
      'play': play
    };
    await _channel.invokeMethod<Null>('show', params);

    _channel.setMethodCallHandler(_myUtilsHandler);
  }

  Future hide() async {
    await _channel.invokeMethod<Null>('hide');
  }

  void setListener(String event, Function callback) {
    _listeners.addAll({event: callback});
  } 
}
