# 🎮 ECHOES OF 2076 - Setup & Launch Guide

## Elite Architecture Stack
- **State Machine Router**: Intro → Registration → Gameplay
- **Modular Code**: `models/`, `services/`, `widgets/`, `main.dart`
- **Gemini AI**: Procedurally generates story nodes with constrained JSON responses
- **Glassmorphic UI**: BackdropFilter + gradient borders, neon glow effects
- **Typewriter Animation**: Character-by-character dialogue reveal
- **Cyberpunk Aesthetics**: Deep midnight slate (#050508), Neon Mint (#00FFCC), Crimson (#FF006E)

## File Structure
```
lib/
├── main.dart                 # Game state router + UI screens
├── models/
│   └── game_state.dart       # GameMetrics, StoryNode, GameChoice
├── services/
│   └── gemini_service.dart   # Gemini AI integration
└── widgets/
    ├── glass_hud.dart        # Glassmorphic metrics display
    └── typewriter_text.dart  # Animated dialogue text
```

## Critical Setup Steps

### 1️⃣  GET A GEMINI API KEY
- Go to: **https://aistudio.google.com/app/apikeys**
- Create a new API key for Flutter
- Copy the key

### 2️⃣  ADD YOUR API KEY
Open `lib/main.dart` and replace:
```dart
const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
```
with:
```dart
const String geminiApiKey = 'sk-your-actual-key-here';
```

### 3️⃣  INSTALL DEPENDENCIES
```bash
flutter pub get
```

### 4️⃣  RUN THE APP

**For Android/iOS Emulator:**
```bash
flutter run
```

**For Desktop (Windows/macOS/Linux):**
```bash
flutter run -d windows    # Windows
flutter run -d macos      # macOS
flutter run -d linux      # Linux
```

**For Web:**
```bash
flutter run -d chrome
```

### 5️⃣  TEST THE BUILD
```bash
flutter test
```

## What You'll See

**Intro Screen:**
- Dark neon title "ECHOES OF 2076"
- Fade animation
- BEGIN button with hover glow

**Registration Screen:**
- Operative codename input
- Glassmorphic text field with neon border
- DEPLOY button

**Gameplay Screen:**
- Glassmorphic HUD showing Mutual Aid, Eco Index, Funds (with animated sliders + glow)
- Dialogue box with typewriter animation revealing NPC dialogue
- 2-4 choice pills (mint green or crimson)
- Interactive hover effects with scale + glow
- Metrics update when you make choices

## Architecture Highlights

### State Management
- **StatefulWidget** with **AnimationController** for node transitions
- **TweenAnimationBuilder** for smooth metric slider animations
- **AnimatedSwitcher** for cross-fade dialogue transitions

### Gemini Integration
- Sends player choice + current metrics to Gemini
- Forces structured JSON response schema
- Validates and parses response back to `StoryNode`
- System prompt drives dark cyberpunk narrator behavior

### UI Micro-interactions
- **Hover Animations**: Buttons scale + border color shifts on hover
- **Glow Effects**: BoxShadow with high-saturation colors
- **Glassmorphism**: BackdropFilter blur + gradient + thin border
- **Typewriter Effect**: Character-by-character reveal with cursor animation

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "API Key missing" error | Add your Gemini API key to `lib/main.dart` line 12 |
| "Empty response from Gemini" | Check API key validity at https://aistudio.google.com/app/apikeys |
| App crashes on choice click | Ensure internet connection (Gemini requires API calls) |
| Text doesn't animate | Check `AnimationController` is disposed properly |
| No emulator available | Install Android Studio or use `flutter create` to set up a device |

## Performance Tips
- Gemini API calls ~1-2 seconds per node generation (stream responses are disabled for structured JSON)
- Animations run at 60fps with Material3
- Canvas background painter uses minimal GPU (subtle grid)

## Next Steps
- Customize `gemini_service.dart` system prompt for different narrative tones
- Add character avatar images to `story_data`
- Implement save/load persistence with JSON
- Add ambient sound design
- Create branching narrative trees with state-based unlock conditions

---

**Ready to enter the darkness?** 🌃
