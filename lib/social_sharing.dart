import 'dart:async';

import 'package:flutter/services.dart';

class SocialSharing {
  static const MethodChannel _channel =
      const MethodChannel('social_sharing');


  Future<String> facebook({String msg = '', String url = ''}) async {
    final Map<String, Object> arguments = Map<String, dynamic>();
    arguments.putIfAbsent('msg', () => msg);
    arguments.putIfAbsent('url', () => url);
    dynamic result;
    try {
      result = await _channel.invokeMethod('facebook', arguments);
    } catch (e) {
      return "false";
    }
    return result;
  }

  ///share to twitter
  Future<String> twitter({String msg = '', String url = '', String image}) async {
    final Map<String, Object> arguments = Map<String, dynamic>();
    arguments.putIfAbsent('msg', () => msg);
    arguments.putIfAbsent('url', () => url);
    arguments.putIfAbsent('image', () => image);
    dynamic result;
    try {
      result = await _channel.invokeMethod('twitter', arguments);
    } catch (e) {
      return "false";
    }
    return result;
  }

  ///use system share ui
  Future<String> system({String msg}) async {
    Map<String, Object> arguments = Map<String, dynamic>();
    arguments.putIfAbsent('msg', () => msg);
    dynamic result;
    try {
      result = await _channel.invokeMethod('system', {'msg': msg});
    } catch (e) {
      return "false";
    }
    return result;
  }
}
