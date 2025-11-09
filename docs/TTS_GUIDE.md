# Système de Synthèse Vocale (Text-to-Speech)

## 📢 Fonctionnalités

Le système TTS permet la lecture vocale des questions et sujets de discussion dans l'application Heartalk.

### ✅ Écrans avec lecture vocale
- **QuestionDisplayScreen** : Lecture des questions avec bouton speaker
- **TopicTimerScreen** : Lecture des sujets de discussion avec bouton speaker

## 🎯 Utilisation

### Bouton Speaker
- **Icône volume_off** (🔇) : Appuyez pour démarrer la lecture
- **Icône volume_up** (🔊 en vert) : Appuyez pour arrêter la lecture

### Fonctionnalités du TtsService

```dart
final TtsService tts = TtsService();

// Initialiser le service
await tts.initialize();

// Lire un texte
await tts.speak("Votre texte à lire");

// Arrêter la lecture
await tts.stop();

// Mettre en pause
await tts.pause();

// Configurer la vitesse (0.0 = très lent, 1.0 = très rapide)
await tts.setSpeechRate(0.5);

// Configurer le volume (0.0 = muet, 1.0 = maximum)
await tts.setVolume(1.0);

// Configurer la tonalité (0.5 = grave, 2.0 = aigu, 1.0 = normal)
await tts.setPitch(1.0);

// Changer la langue
await tts.setLanguage("fr-FR"); // Français
await tts.setLanguage("en-US"); // Anglais
```

## ⚙️ Configuration par défaut

- **Langue** : Français (fr-FR)
- **Vitesse** : 0.5 (normale)
- **Volume** : 1.0 (maximum)
- **Tonalité** : 1.0 (normale)

## 🔧 Package utilisé

- **flutter_tts** v4.2.3 : Package Flutter pour la synthèse vocale
- Documentation : https://pub.dev/packages/flutter_tts

## 📱 Plateformes supportées

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🎨 Design

Les boutons speaker sont intégrés dans le coin supérieur droit des cartes de contenu :
- Icône grise quand inactif
- Icône verte quand lecture en cours
- Animation fluide de basculement

## 🚀 Améliorations possibles

1. **Paramètres utilisateur** : Ajouter des réglages dans SettingsScreen
   - Vitesse de lecture
   - Volume
   - Tonalité
   - Langue

2. **Lecture automatique** : Option pour lire automatiquement les questions/sujets

3. **Contrôle du timer** : Mettre le timer en pause pendant la lecture

4. **Multi-langues** : Support de plusieurs langues selon la catégorie

5. **Effets sonores** : Ajouter des sons de démarrage/arrêt

## 📝 Notes techniques

- Le service est un **Singleton** (une seule instance dans toute l'application)
- La lecture s'arrête automatiquement lors de la navigation
- La méthode `dispose()` arrête proprement la lecture
- Les états de lecture sont suivis pour mettre à jour l'UI
