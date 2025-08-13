import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';

class AudioPlayerController {
  final AudioPlayer _player = AudioPlayer();
  String? _currentUrl; // Track the currently playing audio URL
  bool _isPlaying = false;
  bool _isLoading = false; // Track loading state for the current URL
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;

  AudioPlayerController() {
    // Listen to playback state changes
    _playerStateSubscription = _player.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      // Clear loading state when audio starts playing, pauses, or stops
      if (state == PlayerState.playing ||
          state == PlayerState.paused ||
          state == PlayerState.stopped) {
        _isLoading = false;
      }
      notifyListeners();
    });

    // Listen to audio duration
    _durationSubscription = _player.onDurationChanged.listen((duration) {
      _duration = duration;
      _isLoading = false; // Clear loading when duration is received
      notifyListeners();
    });

    // Listen to audio position
    _positionSubscription = _player.onPositionChanged.listen((position) {
      _position = position;
      notifyListeners();
    });

    // Reset states when playback completes
    _playerCompleteSubscription = _player.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _isLoading = false;
      _position = Duration.zero;
      _currentUrl = null;
      notifyListeners();
    });
  }

  // Notify listeners (widgets) of state changes
  final _listeners = <VoidCallback>[];
  void addListener(VoidCallback listener) => _listeners.add(listener);
  void removeListener(VoidCallback listener) => _listeners.remove(listener);
  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  // Getters
  bool isPlaying(String url) => _isPlaying && _currentUrl == url;
  bool isLoading(String url) => _isLoading && _currentUrl == url;
  Duration get duration => _duration;
  Duration get position => _position;
  String? get currentUrl => _currentUrl;

  // Playback controls
  Future<void> play(String url) async {
    try {
      if (_currentUrl == url && _isPlaying) {
        await _player.pause();
        _isPlaying = false;
        _isLoading = false;
        notifyListeners();
      } else {
        // Stop any currently playing audio
        if (_isPlaying) {
          await _player.stop();
          _isPlaying = false;
        }
        if (_currentUrl != url) {
          _isLoading = true; // Set loader for the new URL
          _currentUrl = url;
          notifyListeners();
          await _player.setSourceUrl(url);
        }
        await _player.resume();
        _isPlaying = true;
        _isLoading = false; // Clear loader after resuming
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _isPlaying = false;
      _currentUrl = null;
      notifyListeners();
      throw e; // Let the widget handle the error
    }
  }

  Future<void> playerStop()async{
    if (_isPlaying) {
      await _player.pause();
      _isPlaying = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  void dispose() {
    _playerStateSubscription?.cancel();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _player.dispose();
  }
}
