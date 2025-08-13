import 'dart:async';

import 'package:flutter/material.dart';
import '../../app/helper/audio_helper.dart';



class AudioWidget extends StatefulWidget {
  final String url;
  final AudioPlayerController controller;

  const AudioWidget({required this.url, required this.controller, super.key});

  @override
  AudioWidgetState createState() => AudioWidgetState();
}

class AudioWidgetState extends State<AudioWidget> {
  @override
  void initState() {
    super.initState();
    // Add listener to controller to update UI when playback state changes
    widget.controller.addListener(_update);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _togglePlayPause() async {
    try {
      await widget.controller.play(widget.url);
    } catch (e) {
      print('Error toggling audio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to play audio: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.controller.currentUrl == widget.url &&
        widget.controller.duration.inSeconds > 0
        ? widget.controller.position.inSeconds /
        widget.controller.duration.inSeconds
        : 0.0;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: _togglePlayPause,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: widget.controller.currentUrl == widget.url ? progress : 0.0,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 4,
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: widget.controller.isLoading(widget.url)
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
                  : Icon(
                widget.controller.isPlaying(widget.url)
                    ? Icons.pause
                    : Icons.play_arrow,
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

