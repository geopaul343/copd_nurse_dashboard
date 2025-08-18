import 'dart:async';

import 'package:flutter/material.dart';

mixin AutoSpeechMixin<T extends StatefulWidget> on State<T> {
  bool _hasSpoken = false;
  bool _iconColor=false;
  late final StreamSubscription<bool> _speechSub;

  void subscribeToSpeechStream({
    required Stream<bool> stream,
    required Future<void> Function() onSpeak,
    required Future<void> Function() onStop,
    //required void Function(bool) reset,
  }) {
    
    _speechSub = stream.listen((enabled) {
      if (enabled && !_hasSpoken) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await onSpeak();
          _hasSpoken = true;
         // reset(false); // reset to prevent repeat
        });
      } else if (!enabled) {
        onStop(); // stop speaking
        _hasSpoken = false; // reset flag so next time we can speak again
      }
    });
  }

  @override
  void dispose() {
    _speechSub.cancel();
    super.dispose();
  }
}

