# Echoes of 2076 - Implementation Summary

## Overview
A dark-themed, choice-driven narrative RPG about social environmental resistance in a dystopian 2076.

## Architecture

### 1. **models.dart**
Core game state and narrative structure:
- **GameState**: Tracks player name, Community Trust (0-100), Eco-Restoration (0-100), Funds
- **StoryNode**: Represents a narrative node with title, text, choices, and metadata
- **Choice**: A selectable option that points to the next node and modifies game state
- **StateModifiers**: Encapsulates delta changes (trust, eco, funds) applied by choices

### 2. **story_data.dart**
A complete 3-node starter narrative with branching paths:
- **Intro**: "The Wake" - Introduction to the resistance movement
- **Dilemma**: "The Arbor" - A pivotal choice with 3 options:
  - Fund aquifer remediation (high stakes, high impact)
  - Start with smaller commitments (pragmatic path)
  - Report to Enforcement (betrayal path)
- **Outcomes**: 4 unique endings reflecting the choice made
  - Committed operative (danger + impact)
  - Measured progress (trust + responsibility)
  - Cautious avoidance (safe + guilt)
  - Informant (reward + corruption)

### 3. **main.dart**
Production-ready UI with:
- **Dark Theme**: Pitch black (#0B0C10) & deep charcoal (#1F2833) backgrounds
- **Accents**: 
  - Neon mint (#45A29E) for normal choices and metrics
  - Muted crimson (#660000) for high-stakes choices
- **UI Structure**:
  - Top: Horizontal metrics dashboard (Trust, Eco, Funds)
  - Middle: Narrative content in translucent bordered container
  - Bottom: Vertical choice buttons with styled variants
- **Features**:
  - Smooth fade transitions between nodes
  - Markdown-aware text rendering (headings, bold, formatting)
  - Responsive layout using CustomScrollView + SliverFillRemaining
  - State management via StatefulWidget with AnimationController

## Game Flow

```
┌─────────────┐
│ THE WAKE    │  (Intro node)
│ (Ignore/Go) │
└──────┬──────┘
       │
       ├──→ GO TO MEETING ──┐
       │                     │
       └──→ IGNORE ────┐     │
                       │     │
                   (Cautious │
                   Outcome)  │
                            │
                    ┌───────┘
                    │
            ┌──────▼────────┐
            │ THE ARBOR      │  (Dilemma node)
            │ (3 choices)    │
            └──┬──────┬──┬───┘
               │      │  │
    ┌──────────┘      │  └──────────┐
    │                 │             │
    ▼                 ▼             ▼
(Committed)    (Pragmatic)    (Betrayal)
  Outcome        Outcome       Outcome
```

## Theme & Aesthetics
- **Color Palette**: Cyberpunk noir with environmental motifs
- **Typography**: Clean sans-serif with geometric letterheading
- **Icons**: Unicode symbols (◆ ♣ ◎) for metrics
- **Tone**: Dark, urgent, morally complex—resistance through small acts of grace

## Testing
- Widget tests verify app initialization and core UI elements
- All tests passing

## Getting Started
```bash
flutter pub get
flutter run
```

## Future Extensions
- Persistent game saves with JSON serialization
- Sound/ambient audio layer
- Character relationship tracking
- Mid-game resource scarcity mechanics
- Procedural node generation for replayability
