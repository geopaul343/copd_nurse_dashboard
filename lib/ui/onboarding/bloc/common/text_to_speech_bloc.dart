
import 'package:rxdart/rxdart.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechBloc{
  // for text to speech
  final isAutoSpeechQuestion = BehaviorSubject<bool>.seeded(false);
  FlutterTts flutterTts = FlutterTts();

  setAutoSpeech(bool isEnable) {
    isAutoSpeechQuestion.add(isEnable);
  }

  Future textToSpeech(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> stopSpeech() async {
    await flutterTts.stop();
  }
}

