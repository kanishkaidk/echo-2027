# ECHOES OF 2076: Complete Game Architecture

## 🎮 Game Overview

**Echoes of 2076** is an AI-powered cyberpunk narrative RPG featuring:
- **50+ story nodes** across 3 acts with branching narratives
- **Dynamic personality tracking** that adapts NPC behavior
- **Gemini API integration** for real-time story generation
- **Achievement system** with 30+ unlockables
- **Educational mechanics** embedding values exploration in gameplay

---

## 📊 Game Structure

### Acts & Chapters

```
Act I: The Lower Hab-Decks (Nodes 1-10)
├── Chapter 1: Air Scrubber Breach
├── Chapter 2: Black Market Pipeline
└── Chapter 3: Enforcer Retaliation

Act II: The Mid-Tier Spire (Nodes 11-25)
├── Chapter 4: Data Center Heist
└── Chapter 5: Firewall Sabotage

Act III: Core Cloud Mainframe (Nodes 26-53)
└── Chapter 6: Final Override Sequence
```

### Screen Flow

```
Splash → Onboarding → Character Select → Home Dashboard
                                           ↓
                                    Gameplay Loop
                                    ↓ ↓ ↓ ↓
                              Profile | Leaderboard | Settings | Story Map
```

---

## 🎯 Core Mechanics

### 1. Metrics System

All player decisions impact **4 core metrics** (0-100):

| Metric | Purpose | Unlocks |
|--------|---------|---------|
| **Mutual Aid** | Community trust & collective support | Coalition mechanics, leadership paths |
| **Eco Index** | Environmental restoration commitment | Eco-focused story branches, green endings |
| **Tech Aptitude** | Hacking & systems mastery | Infiltration, data theft, network control |
| **Empathy Index** | Compassion for human suffering | Peaceful resolutions, rescue missions |
| **Leadership** | Ability to inspire & command | Unit coordination, faction control |
| **Rebellion Index** | Hostility toward corporate order | Violent actions, revolutionary paths |

**Financial**: Funds (unlimited) - earned through profitable choices, spent on operations

### 2. Personality Archetype System

Each choice shifts personality dimensions. Archetypes emerge:
- **Pure Heart** (80+ Empathy, <30 Rebellion) → Humanitarian ending
- **Cold Logic** (80+ Tech, <30 Empathy) → Pragmatic ending
- **Revolutionary** (80+ Rebellion) → Chaos ending
- **Balanced** (50-70 all stats) → Nuanced ending

### 3. Story Node Architecture

Each node contains:
```dart
StoryNode {
  id: "node_XXX",
  characterName: "NPC Name",
  dialogueText: "400-600 character narrative",
  characterAvatar: "assets/avatars/name.png",
  choices: [
    GameChoice {
      id: "choice_001",
      text: "[ACTION] Brief description",
      mutualAidDelta: -15 to +35,
      ecoIndexDelta: -40 to +40,
      fundsDelta: -500 to +600,
      personalityImpact: {
        empathy: -25 to +25,
        tech: -25 to +25,
        leadership: -25 to +25,
        rebellion: -25 to +35
      }
    }
  ]
}
```

---

## 🤖 AI Integration (Gemini API)

### Dynamic Story Generation

**GeminiService** generates next story nodes based on:
1. Player's current choice
2. Personality profile (all 6 metrics)
3. Previous node context
4. Story progression state

### Prompt Architecture

```
Player Choice: "[EXECUTE] Reroute generator power"
↓
Context Building:
- Current metrics snapshot
- Previous node ID
- Delta impacts (what this choice changes)
↓
Gemini generates:
- Next NPC dialogue (200-300 words)
- 2-4 new branching choices
- Realistic consequence acknowledgment
↓
JSON parsing into StoryNode
```

### Why Gemini?

- **Adaptive responses**: Story reacts meaningfully to player metrics
- **High-quality narrative**: Professional-grade cyberpunk writing
- **Ethical grounding**: Personality traits shape moral tone
- **Educational**: Embeds real ethical questions about technology, environment, community

---

## 🏆 Achievement System

**30 achievements** organized by category:

### Financial Path
- Scrip Collector (500+ credits)
- Scrip Millionaire (1000+ credits)
- Venture Capitalist (2000+ credits)

### Environmental Path
- Eco Conscious (50+ Eco Index)
- Environmental Savior (80+ Eco Index)
- Planet Guardian (95+ Eco Index)

### Social Path
- Community Supporter → Community Leader → Resistance Icon

### Technical Path
- Novice Hacker → Elite Netrunner → Godlike Hacker

### Extreme Paths
- **Pure Heart** (80+ Empathy, <30 Rebellion)
- **Cold Logic** (80+ Tech, <30 Empathy)
- **Revolutionary** (80+ Rebellion Index)
- **Perfectly Balanced** (50+ all metrics)

---

## 📱 Screen Specifications

### 1. **SplashScreen**
- Animated boot sequence
- Terminal log text with typewriter effect
- Auto-transition after 4 seconds

### 2. **OnboardingScreen** (NEW!)
- 4-page interactive tutorial
- Page 1: Welcome & context
- Page 2: Interactive metric sliders
- Page 3: Personality dimensions explained
- Page 4: Ready for deployment

### 3. **CharacterSelectScreen**
- 3 operative archetypes with stat presets
- Netrunner (High Tech, low funds)
- Street Fixer (High Leadership, high funds)
- Eco-Infiltrator (Max Eco, low funds)

### 4. **HomeScreen** (Dashboard)
- Operative level display
- Mission elapsed timer
- Pulsing "ENGAGE MISSION" button
- 6-stat grid view
- Personality matrix radar
- Quick-nav to Profile, Leaderboard, Settings

### 5. **GameplayScreen** (Core Loop)
- Story node dialogue with typewriter effect
- 2-4 choice pills (high-stakes highlighted in pink)
- Real-time metric updates
- Return home / reset game buttons

### 6. **StoryMapScreen**
- 3-act progression tree
- Locked/unlocked chapter visualization
- Node completion status tracking
- Act prerequisites shown

### 7. **ProfileScreen**
- Operative level & scrip display
- Detailed personality breakdown
- Achievement grid (locked/unlocked)
- Progression stats

### 8. **LeaderboardScreen**
- Top 8 operatives by funds
- Player rank/position highlighted
- Medal colors for top 3 (gold/silver/bronze)

### 9. **SettingsScreen**
- Toggle: Glitch effect, sound effects
- Slider: Typewriter speed (Slow/Normal/Instant)
- Button: System cache wipe (with confirmation)
- Version info

---

## 🎨 Design System: Delhi 2076 Neo-Noir

### Color Palette

| Name | Hex | Usage |
|------|-----|-------|
| **Obsidian Void** | #050508 | Background scaffold |
| **Toxic Mint Green** | #00FFCC | Stable interfaces, primary CTAs |
| **Neon Synth-Pink** | #FF006E | Alerts, high-stakes, danger |
| **Cyber-Gold** | #FFD700 | Financial metrics, premium content |
| **Cyan Accent** | #00D9FF | Secondary emphasis |
| **Eco Green** | #00FF88 | Environmental metrics |

### Typography

- **Display**: Courier New / monospace, 32-48px, 4px letter-spacing, text-shadow glow
- **Headlines**: Courier New, 18-24px, 2px letter-spacing
- **Body**: Courier New, 14-16px, 1.5 line-height
- **Labels**: 10-12px, 1-2px letter-spacing

### Interactive Elements

- **Buttons**: Gradient fill, rounded corners (4-8px), glowing shadow on hover
- **Sliders**: Gradient track, animated thumb
- **Cards**: Gradient background, subtle border glow, scale transform on hover
- **Text**: Typewriter effect (50ms per character), fade-in transitions

---

## 📚 Educational Content

### Embedded Learning Objectives

1. **Ethics in Technology**
   - Choices reveal trade-offs: efficiency vs. humanity, security vs. freedom
   - Corporate surveillance mechanics teach privacy awareness
   - Hacking vs. community organizing debate

2. **Systems Thinking**
   - Environmental impact of corporate extraction
   - Interconnected metrics (help one person, might harm ecosystem)
   - Long-term vs. short-term gains

3. **Narrative Agency**
   - Player learns: choices matter, but outcomes are complex
   - No "good" ending, only "yours"—reflects reality of resistance
   - Personality drives story differently than metrics

4. **Values Clarification**
   - Through gameplay, player discovers their operative archetype
   - Achievements reward value-aligned play
   - Leaderboard shows community chose many different paths

---

## 🛠 Technical Architecture

### File Structure
```
lib/
├── main.dart                          # Router & app initialization
├── models/
│   ├── game_state.dart               # GameMetrics, GameChoice, StoryNode
│   └── achievement_system.dart       # 30 achievements + unlock logic
├── services/
│   └── gemini_service.dart           # AI story generation
├── data/
│   └── story_nodes.dart              # 50+ hardcoded story nodes (fallback)
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── character_select_screen.dart
│   ├── home_screen.dart
│   ├── profile_screen.dart
│   ├── leaderboard_screen.dart
│   ├── settings_screen.dart
│   ├── story_map_screen.dart
│   └── gameplay_screen.dart (in main.dart)
└── widgets/
    ├── glass_hud.dart               # Metrics display widget
    └── typewriter_text.dart         # Character-by-character reveal
```

### State Management Flow

```
GameRouter (State Machine)
├── Maintains: _currentScreen, _playerName, _gameMetrics
├── Transitions: setState() updates screen
└── Callbacks: onMetricsUpdate propagates changes
    ↓
GameplayScreen
├── Calls: GeminiService.generateNextNode()
├── Updates: GameMetrics (personality + core metrics)
├── Calls: widget.onMetricsUpdate(newMetrics)
└── Persists: Updated metrics in router state
```

### Data Flow: Choice → Story → Metrics

```
User taps choice pill
    ↓
_handleChoice(GameChoice) called
    ↓
Apply deltas to GameMetrics
    ↓
Call Gemini API with context
    ↓
Parse response into StoryNode
    ↓
setState() → show new dialogue + choices
    ↓
onMetricsUpdate() → parent router updates state
```

---

## 🚀 How to Extend

### Add a New Story Node
1. Add to `lib/data/story_nodes.dart`:
```dart
'node_026_example': StoryNode(
  id: 'node_026_example',
  characterName: 'NPC Name',
  dialogueText: 'Your story...',
  typewrittenText: 'Your story...',
  characterAvatar: 'assets/avatars/npc.png',
  choices: [ /* 2-4 GameChoice */ ],
),
```

2. Link from previous node's next node ID

### Add a New Achievement
1. Add to `AchievementSystem.allAchievements`:
```dart
Achievement(
  id: 'my_achievement',
  name: 'ACHIEVEMENT NAME',
  description: 'Description of unlock condition',
  icon: '🎯',
  color: const Color(...),
  category: 'Category',
  unlockedBy: (m) => m.mutualAid >= 80 && m.funds < 100,
),
```

### Add Dynamic Story Generation
- Already integrated! Just update Gemini prompts in `gemini_service.dart`
- Adjust `systemPrompt` for different narrative tone
- Modify `_buildPrompt()` for different context windows

---

## 📊 Metrics Reference

### High-Stakes Choices (isHighStakes = true)
- Larger delta values (±40, ±500 funds)
- Usually one "win" metric, one "lose" metric
- Examples:
  - Raid corporate depot: +funds +rebellion, -mutualAid
  - Massive eco project: +eco +mutualAid, -funds
  - Aggressive interrogation: +rebellion +tech, -empathy

### Balanced Choices (isHighStakes = false)
- Moderate deltas (±15, ±150 funds)
- Can have positive in multiple areas
- Lower risk, lower reward
- Examples:
  - Negotiate resources
  - Partial solutions
  - Measured responses

---

## 🎓 Learning Outcomes

After playing Echoes of 2076, users will understand:

✅ **Systems thinking**: How metrics interconnect and influence outcomes  
✅ **Ethical reasoning**: Technology has tradeoffs; no purely "good" choices  
✅ **Value clarification**: What matters most (efficiency, community, growth, freedom)  
✅ **Narrative agency**: Choices shape identity, not just outcomes  
✅ **Cyberpunk literacy**: Genre conventions, corporate dystopia themes  
✅ **Game design**: How mechanics embed meaning (personality as archetype)

---

## 📈 Future Enhancements

- [ ] Save/load game state to local storage
- [ ] Multiplayer leaderboard (backend integration)
- [ ] Voice acting for character dialogue
- [ ] Sound design (hacker ambience, notification pings)
- [ ] Advanced analytics: track which choices most players make
- [ ] DLC: Additional acts beyond core 3
- [ ] Mod support: Custom story nodes via JSON import
- [ ] VR adaptation: Immersive hacker interface
