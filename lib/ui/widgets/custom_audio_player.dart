import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'custom_snackbar.dart';

class AudioWidget extends StatefulWidget {
  final String url;

  const AudioWidget({required this.url, super.key});

  @override
  AudioWidgetState createState() => AudioWidgetState();
}

class AudioWidgetState extends State<AudioWidget> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listen to playback state changes
    _player.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
        // Clear loading state when audio starts playing or is paused/stopped
        if (state == PlayerState.playing || state == PlayerState.paused || state == PlayerState.stopped) {
          _isLoading = false;
        }
      });
    });

    // Listen to audio duration
    _player.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
        // Clear loading when duration is received (indicates audio is ready)
        _isLoading = false;
      });
    });

    // Listen to audio position
    _player.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    // Reset states when playback completes
    _player.onPlayerComplete.listen((_) {
      setState(() {
        _isLoading = false;
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _player.pause();
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = true; // Show loader when starting playback
        });
        await _player.setSourceUrl(widget.url);
        await _player.resume();
      }
    } catch (e) {
      print('Error toggling audio: $e');
      setState(() {
        _isLoading = false; // Hide loader on error
      });
      // Optionally show an error message to the user
      SnackBarCustom.failure('Failed to play audio: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    // Calculate progress (0.0 to 1.0)
    final progress = _duration.inSeconds > 0 ? _position.inSeconds / _duration.inSeconds : 0.0;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: _togglePlayPause,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular progress bar for playback
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: progress, // Indeterminate when loading
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 4,
              ),
            ),
            // CircleAvatar with play/pause icon or loader
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
                  : Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

