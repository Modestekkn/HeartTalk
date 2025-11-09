import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Configuration de base
      await _flutterTts.setLanguage("fr-FR"); // Français
      await _flutterTts.setSpeechRate(0.5); // Vitesse normale (0.0 à 1.0)
      await _flutterTts.setVolume(1.0); // Volume maximum
      await _flutterTts.setPitch(1.0); // Tonalité normale

      // Callbacks pour suivre l'état
      _flutterTts.setStartHandler(() {
        _isSpeaking = true;
        if (kDebugMode) {
          print("TTS: Lecture démarrée");
        }
      });

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        if (kDebugMode) {
          print("TTS: Lecture terminée");
        }
      });

      _flutterTts.setErrorHandler((msg) {
        _isSpeaking = false;
        if (kDebugMode) {
          print("TTS Erreur: $msg");
        }
      });

      _isInitialized = true;
      if (kDebugMode) {
        print("TTS: Service initialisé");
      }
    } catch (e) {
      if (kDebugMode) {
        print("TTS: Erreur d'initialisation: $e");
      }
    }
  }

  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // Arrêter toute lecture en cours
      await stop();

      // Lire le nouveau texte
      await _flutterTts.speak(text);
    } catch (e) {
      if (kDebugMode) {
        print("TTS: Erreur de lecture: $e");
      }
    }
  }

  Future<void> stop() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
    }
  }

  Future<void> pause() async {
    if (_isSpeaking) {
      await _flutterTts.pause();
    }
  }

  Future<void> setLanguage(String language) async {
    await _flutterTts.setLanguage(language);
  }

  Future<void> setSpeechRate(double rate) async {
    // rate: 0.0 (très lent) à 1.0 (très rapide)
    await _flutterTts.setSpeechRate(rate);
  }

  Future<void> setVolume(double volume) async {
    // volume: 0.0 (muet) à 1.0 (maximum)
    await _flutterTts.setVolume(volume);
  }

  Future<void> setPitch(double pitch) async {
    // pitch: 0.5 (grave) à 2.0 (aigu), 1.0 = normal
    await _flutterTts.setPitch(pitch);
  }

  void dispose() {
    _flutterTts.stop();
  }
}
