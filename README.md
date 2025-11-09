# Heartalk

Application mobile interactive de questions et sujets de discussion pour renforcer les liens entre personnes selon differents contextes relationnels.

## Description

Heartalk est une application Flutter conçue pour faciliter les conversations authentiques et profondes entre couples, amoureux et amis. Elle propose un systeme de questions et sujets de discussion adaptes a chaque contexte relationnel, avec trois niveaux de difficulte pour une progression naturelle des echanges.

## Fonctionnalites Principales

### Categories Relationnelles

**En Couple**
- Questions pour renforcer la complicite
- Sujets de discussion sur l'avenir commun
- 90 questions et 45 sujets sur 3 niveaux

**En Amoureux**
- Questions pour mieux se connaitre
- Exploration des valeurs et aspirations
- 90 questions et 45 sujets sur 3 niveaux

**Entre Ami(e)s**
- Questions ludiques et profondes
- Sujets varies pour tisser des liens
- 90 questions et 45 sujets sur 3 niveaux

### Niveaux de Difficulte

**Niveau 1 - Leger**
- Questions amusantes et decontractees
- Ideal pour briser la glace
- 33% du contenu

**Niveau 2 - Moyen**
- Questions introspectives
- Partage de valeurs et experiences
- 33% du contenu

**Niveau 3 - Profond**
- Questions vulnerables et intimes
- Exploration des peurs et blessures
- 33% du contenu

### Fonctionnalites Techniques

**Systeme de Jeu**
- Roue aleatoire pour selection de joueur
- Mode Question et Mode Sujet de Discussion
- Timer de 5 minutes pour les sujets
- Systeme de suivi des questions utilisees

**Accessibilite**
- Synthese vocale (TTS) en français
- Lecture audio des questions et sujets
- Controles de lecture intuitifs
- Reglages personnalisables

**Animations**
- Transitions fluides entre ecrans
- Animations de rotation pour la roue
- Effets tactiles avec haptic feedback
- Animations de progression du timer

**Base de Donnees**
- SQLite pour stockage local
- 270 questions au total
- 135 sujets de discussion
- Historique des sessions de jeu

## Architecture

### Stack Technique

- **Framework**: Flutter 3.9.2
- **Langage**: Dart
- **State Management**: Riverpod 2.6.1
- **Base de donnees**: SQLite (sqflite 2.4.1)
- **Synthese vocale**: flutter_tts 4.2.3
- **Navigation**: go_router 14.6.2
- **Animations**: Flutter Animation API

### Structure du Projet

```
lib/
├── core/
│   ├── database/
│   │   ├── database_helper.dart          # Gestionnaire SQLite
│   │   ├── database_enriched_data.dart   # 270 questions
│   │   └── database_enriched_topics.dart # 135 sujets
│   ├── services/
│   │   └── tts_service.dart              # Service de synthese vocale
│   ├── theme/
│   │   ├── app_theme.dart                # Theme de l'application
│   │   └── app_colors.dart               # Palette de couleurs
│   └── routes/
│       └── app_router.dart               # Configuration des routes
├── features/
│   ├── onboarding/
│   │   ├── splash_screen.dart            # Ecran de demarrage
│   │   └── onboarding_screen.dart        # Tutoriel initial
│   ├── category/
│   │   └── category_selection_screen.dart # Selection de categorie
│   ├── players/
│   │   ├── player_input_screen.dart      # Ajout de joueurs
│   │   └── players_list_screen.dart      # Liste des joueurs
│   ├── game/
│   │   ├── game_selection_screen.dart    # Choix Question/Sujet
│   │   ├── spin_wheel_screen.dart        # Roue de selection
│   │   ├── question_display_screen.dart  # Affichage question
│   │   └── topic_timer_screen.dart       # Timer pour sujets
│   ├── settings/
│   │   └── settings_screen.dart          # Parametres app
│   └── debug/
│       └── database_debug_screen.dart    # Debug base de donnees
└── main.dart
```

## Installation

### Prerequis

- Flutter SDK 3.9.2 ou superieur
- Dart 3.0.0 ou superieur
- Android Studio / VS Code avec extensions Flutter
- Un emulateur Android/iOS ou appareil physique

### Etapes d'Installation

1. Cloner le repository
```bash
git clone https://github.com/votre-username/heartalk.git
cd heartalk
```

2. Installer les dependances
```bash
flutter pub get
```

3. Verifier la configuration
```bash
flutter doctor
```

4. Lancer l'application
```bash
flutter run
```

## Dependances Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.5.0
  
  # Navigation
  go_router: ^14.6.2
  
  # Base de donnees
  sqflite: ^2.4.1
  path: ^1.9.0
  uuid: ^4.5.1
  
  # Synthese vocale
  flutter_tts: ^4.2.3
  
  # UI/UX
  smooth_page_indicator: ^1.2.0+3
  lottie: ^3.1.2
```

## Base de Donnees

### Schema

**categories**
- id (TEXT PRIMARY KEY)
- name (TEXT)
- emoji (TEXT)
- description (TEXT)
- primary_color (TEXT)
- secondary_color (TEXT)

**questions**
- id (TEXT PRIMARY KEY)
- category_id (TEXT)
- text (TEXT)
- level (INTEGER: 1-3)
- is_used (INTEGER: 0-1)

**topics**
- id (TEXT PRIMARY KEY)
- category_id (TEXT)
- text (TEXT)
- duration (INTEGER)
- level (INTEGER: 1-3)
- is_used (INTEGER: 0-1)

**game_sessions**
- id (TEXT PRIMARY KEY)
- category_id (TEXT)
- players (TEXT)
- started_at (INTEGER)
- ended_at (INTEGER)

### Statistiques du Contenu

- Total: 405 entrees (270 questions + 135 sujets)
- Distribution par niveau: 33% niveau 1, 33% niveau 2, 33% niveau 3
- Distribution par categorie: 90 questions et 45 sujets par categorie
- Temps de discussion total: 11h15 (135 sujets x 5 minutes)

## Utilisation

### Flux de Navigation

1. **Splash Screen**: Ecran de demarrage avec animation
2. **Onboarding**: Presentation des fonctionnalites (premier lancement)
3. **Selection de Categorie**: Choix entre Couple, Amoureux, Amis
4. **Ajout de Joueurs**: Configuration des participants
5. **Selection du Mode**: Question ou Sujet de Discussion
6. **Roue de Selection**: Tirage aleatoire du joueur
7. **Affichage du Contenu**: Question avec TTS ou Sujet avec timer
8. **Repetition**: Retour a la roue pour le prochain tour

### Mode Question

- Affichage d'une question aleatoire
- Lecture audio disponible via bouton speaker
- Indication du niveau de difficulte (1-3 etoiles)
- Navigation vers question suivante

### Mode Sujet de Discussion

- Affichage d'un sujet de discussion
- Timer de 5 minutes avec animation
- Lecture audio du sujet
- Alertes visuelles et haptiques a 30 secondes
- Changement de couleur progressif (vert > orange > rouge)

## Tests et Debug

### Ecran de Debug

Un ecran de debug est disponible pour verifier:
- Nombre total de questions et sujets
- Distribution par niveau de difficulte
- Distribution par categorie
- Reinitialisation de la base de donnees

### Commandes Utiles

```bash
# Analyse statique du code
flutter analyze

# Lancer les tests
flutter test

# Generer l'APK
flutter build apk --release

# Generer l'AAB pour Play Store
flutter build appbundle --release
```

## Documentation

- `docs/TTS_GUIDE.md`: Guide complet du systeme TTS
- `docs/PHASE_B_ENRICHISSEMENT.md`: Documentation de l'enrichissement de la base
- `docs/SUMMARY_PHASE_B.md`: Resume executif Phase B

## Roadmap

### Version 1.0 (Actuelle)
- 3 categories relationnelles
- 270 questions enrichies
- 135 sujets de discussion
- Systeme TTS integre
- Animations fluides

### Version 1.1 (A venir)
- Filtrage par niveau de difficulte
- Statistiques de jeu detaillees
- Mode nuit
- Personnalisation des avatars

### Version 2.0 (Future)
- Questions personnalisees par utilisateur
- Mode multijoueur en ligne
- Systeme de badges et achievements
- Packs thematiques premium
- Support multilingue

## Contribution

Les contributions sont les bienvenues. Pour contribuer:

1. Fork le projet
2. Creer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de details.

## Auteur

Developpe avec passion pour faciliter les conversations authentiques et renforcer les liens humains.

## Contact

Pour toute question ou suggestion:
- GitHub Issues: [Creer un issue](https://github.com/votre-username/heartalk/issues)
- Email: votre.email@example.com

## Remerciements

- Flutter Team pour le framework exceptionnel
- Communaute open source pour les packages utilises
- Tous les utilisateurs qui testent et ameliorent l'application
