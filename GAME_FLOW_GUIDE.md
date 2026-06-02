# 🎮 Echoes of 2076: Complete Game Flow

## 📱 User Journey Map

```
┌─────────────────┐
│  SPLASH SCREEN  │  • Black background
│   3 seconds     │  • Animated boot sequence
│                 │  • Terminal text reveal
└────────┬────────┘
         │ [Auto-transition]
         ↓
┌─────────────────────────────────────┐
│     ONBOARDING (4 Pages)            │
│                                     │
│ Page 1: Welcome & Context           │ • "Welcome, Operative"
│ Page 2: Metrics Teaching (Sliders)  │ • Interactive stat adjustment
│ Page 3: Personality Dimensions      │ • 4 trait breakdown
│ Page 4: Ready for Deployment        │ • "Begin Mission" button
│                                     │
│ Progress bar at bottom              │ • 25% → 50% → 75% → 100%
└────────┬────────────────────────────┘
         │ [Tap NEXT or BEGIN MISSION]
         ↓
┌──────────────────────────────────────┐
│   CHARACTER SELECT SCREEN            │
│                                      │
│  ╔══════════════════════════════╗   │
│  ║ NETRUNNER                    ║   │ • Tech-focused
│  ║ Digital Infiltrator          ║   │ • Tech: 85, Funds: 400
│  ║ Master of encrypted networks ║   │ • Stat bars shown
│  ║ [STAT BAR] TECH: 85/100     ║   │
│  ║ [STAT BAR] LEAD: 35/100     ║   │
│  ╚══════════════════════════════╝   │
│                                      │
│  ╔══════════════════════════════╗   │
│  ║ STREET FIXER                 ║   │ • Leadership-focused
│  ║ Resource Coordinator         ║   │ • Leadership: 80, Funds: 600
│  ║ Connects people & resources  ║   │ • Stat bars shown
│  ║ [STAT BAR] LEAD: 80/100     ║   │
│  ║ [STAT BAR] TECH: 50/100     ║   │
│  ╚══════════════════════════════╝   │
│                                      │
│  ╔══════════════════════════════╗   │
│  ║ ECO-INFILTRATOR              ║   │ • Environment-focused
│  ║ Environmental Saboteur       ║   │ • Eco: 95, Funds: 250
│  ║ Restoration specialist       ║   │ • Stat bars shown
│  ║ [STAT BAR] ECO: 95/100      ║   │
│  ║ [STAT BAR] EMPA: 90/100     ║   │
│  ╚══════════════════════════════╝   │
│                                      │
│  Operative Codename: [TEXT INPUT]   │
│                                      │
│  ┌──────────────────────────────┐   │
│  │  DEPLOY OPERATIVE            │   │ Green gradient button
│  └──────────────────────────────┘   │
└──────────────────────────────────────┘
         │ [Tap DEPLOY]
         ↓
┌─────────────────────────────────────────────────┐
│        HOME SCREEN (Dashboard Hub)              │
│                                                 │
│ OPERATIVE DASHBOARD         ⚙️ SETTINGS         │
│ SHADOW-7                                        │
│                                                 │
│ ╔════════════════════════════════════════════╗ │
│ ║ OPERATIVE LEVEL         MISSION TIME       ║ │
│ ║ TIER-7 OPERATIVE        02:45:31          ║ │
│ ╚════════════════════════════════════════════╝ │
│                                                 │
│ ╔════════════════════════════════════════════╗ │
│ ║            ENGAGE MISSION ⚡               ║ │ ← Pulsing
│ ║  [Massive glowing button with border]     ║ │
│ ║    INCOMING OPERATIONAL DIRECTIVE         ║ │
│ ╚════════════════════════════════════════════╝ │
│                                                 │
│ SYSTEM STATUS                                   │
│                                                 │
│ ┌──────────────┬──────────────┐               │
│ │ MUTUAL AID   │ ECO INDEX    │               │
│ │ 65/100       │ 42/100       │               │
│ └──────────────┴──────────────┘               │
│                                                 │
│ ┌──────────────┬──────────────┐               │
│ │ SCRIP TOKENS │ NODES        │               │
│ │ 850          │ 12           │               │
│ └──────────────┴──────────────┘               │
│                                                 │
│ PERSONALITY MATRIX                              │
│ [Bar] EMPATHY:        70/100                    │
│ [Bar] TECH APTITUDE:  55/100                    │
│ [Bar] LEADERSHIP:     48/100                    │
│ [Bar] REBELLION:      62/100                    │
│                                                 │
│ ┌──────────────┬──────────────┐               │
│ │ PROFILE      │ LEADERBOARD  │               │
│ │ 👤           │ 🏆           │               │
│ └──────────────┴──────────────┘               │
└─────────────────────────────────────────────────┘
         │ [Tap ENGAGE MISSION]
         ↓
┌────────────────────────────────────────────────────┐
│            GAMEPLAY SCREEN (Core Loop)            │
│                                                    │
│ [Grid background]                                 │
│                                                    │
│ GLASS HUD (Top):                                  │
│ ┌──────────────────────────────────────────────┐ │
│ │ Mutual Aid: 65 | Eco: 42 | Funds: 850       │ │
│ │ Empathy: 70 | Tech: 55 | Lead: 48 | Rebel: 62│
│ └──────────────────────────────────────────────┘ │
│                                                    │
│ STORY NODE (Center):                              │
│ ╔────────────────────────────────────────────┐   │
│ ║ THE PHANTOM [UNKNOWN CONTACT]              ║   │ Cyan border
│ ║                                            ║   │
│ ║ Corporate is mobilizing. They're          ║   │
│ ║ launching Operation Cleanse to            ║   │
│ ║ neutralize the entire Lower Deck          ║   │
│ ║ resistance. We have one shot: escape,     ║   │ Text reveals
│ ║ fight, or attempt negotiation with        ║   │ character by
│ ║ their leadership...                       ║   │ character
│ ║                                            ║   │
│ ╚────────────────────────────────────────────┘   │
│                                                    │
│ CHOICE PILLS (Interactive):                       │
│                                                    │
│ ┌────────────────────────────────────────────┐   │
│ │ [RETREAT] Evacuate to the Mid-Tier        │   │ Cyan, normal
│ │ Live to fight another day                 │   │
│ └────────────────────────────────────────────┘   │
│                                                    │
│ ┌────────────────────────────────────────────┐   │
│ │ [DEFIANCE] Make a final stand              │   │ Pink (high-stakes)
│ │ Become a symbol of resistance             │   │ Glow effect
│ └────────────────────────────────────────────┘   │
│                                                    │
│ ┌────────────────────────────────────────────┐   │
│ │ [DIPLOMACY] Seek a ceasefire               │   │ Gold, negotiation
│ │ Corporate might listen to reason          │   │
│ └────────────────────────────────────────────┘   │
│                                                    │
│ RETURN TO DASHBOARD | RESET GAME                  │
└────────────────────────────────────────────────────┘
         │ [Tap a choice pill]
         ↓
      (Metrics update!)
      Mutual Aid: 65 → 95 (choice impact)
      Leadership: 48 → 78 (choice impact)
      Funds: 850 → 850 (no change)
         ↓
      (Gemini generates next node)
      API call sent → JSON response → Parsed
         ↓
      (New story appears!)
      Different character
      Different scenario
      Different choices
         │
         └─→ [Loop back to GAMEPLAY SCREEN]
             Choose again...
             Next node generated...
             Again and again...
         │
         └─→ [OR: Tap RETURN TO DASHBOARD]
             │
             ↓
         ┌────────────────────────────────────────────────┐
         │         PROFILE SCREEN (Stats View)            │
         │                                                │
         │ OPERATIVE PROFILE          ← (back arrow)      │
         │ SHADOW-7                                       │
         │                                                │
         │ PRIMARY METRICS                                │
         │ ┌────────────────────────────────────────┐    │
         │ │ OPERATIVE LEVEL: TIER-7 OPERATIVE │    │
         │ │ TOTAL SCRIP: 850 CREDITS          │    │
         │ │ NODES VISITED: 12                 │    │
         │ └────────────────────────────────────────┘    │
         │                                                │
         │ PSYCHOLOGICAL PROFILE                          │
         │ ┌───────────────────────────────────────┐     │
         │ │ Empathy Index:    [====== ] 70/100  │     │
         │ │ Tech Aptitude:    [====   ] 55/100  │     │
         │ │ Leadership:       [====   ] 48/100  │     │
         │ │ Rebellion Index:  [====== ] 62/100  │     │
         │ └───────────────────────────────────────┘     │
         │                                                │
         │ ACHIEVEMENTS UNLOCKED                          │
         │ ┌─────────┬─────────┬─────────┬──────────┐   │
         │ │ 💰      │ 🤝      │ 🌱      │ ✊       │   │
         │ │ SCRIP   │ COMMUN. │ ECO     │ REBEL   │   │
         │ │ COLLECT.│ SUPPORT │ CONSCIOUS│QUESTION│   │
         │ └─────────┴─────────┴─────────┴──────────┘   │
         │ ┌─────────┬─────────┬─────────┬──────────┐   │
         │ │ 👑      │ 📖      │ 🔒      │ 🔒      │   │
         │ │ EMERGING│ FIRST   │ LOCKED  │ LOCKED  │   │
         │ │ LEADER  │ STEPS   │         │         │   │
         │ └─────────┴─────────┴─────────┴──────────┘   │
         │                                                │
         └────────────────────────────────────────────────┘
         │ [Tap back arrow OR tap another nav button]
         ↓
         ┌────────────────────────────────────────────────┐
         │      LEADERBOARD SCREEN (Rankings)             │
         │                                                │
         │ GLOBAL LEADERBOARD        ← (back arrow)       │
         │ [TOP OPERATIVES RANKING]                       │
         │                                                │
         │ YOUR RANK: #5             SCRIP: 850          │
         │                                                │
         │ ┌────────────────────────────────────────┐    │
         │ │ #1 🥇 CIPHER ORACLE      2850 SCRIP   │    │ Gold highlight
         │ │ #2 🥈 GHOST WALKER       2640 SCRIP   │    │ Silver highlight
         │ │ #3 🥉 NEXUS PRIME        2520 SCRIP   │    │ Bronze highlight
         │ │ #4    ROGUE AGENT 7      2390 SCRIP   │    │
         │ │ #5 → SHADOW-7            850 SCRIP    │    │ Cyan highlight
         │ │      [CURRENT PLAYER]                 │    │
         │ │ #6    ECHO PHANTOM       2100 SCRIP   │    │
         │ │ #7    VAULT BREAKER      1980 SCRIP   │    │
         │ │ #8    SHADOW RUNNER      1850 SCRIP   │    │
         │ └────────────────────────────────────────┘    │
         │                                                │
         └────────────────────────────────────────────────┘
         │ [Tap back arrow OR another nav]
         ↓
         ┌─────────────────────────────────────────────┐
         │     STORY MAP SCREEN (Progression Tree)     │
         │                                             │
         │ STORY MAP         ← (back arrow)            │
         │ [NARRATIVE PROGRESSION TREE]                │
         │                                             │
         │ ACT I: THE LOWER HAB-DECKS                  │
         │ Where resistance begins below the neon      │
         │                                             │
         │ ├─ 🟢 The Air Scrubber Breach      [✓]    │ ← Completed
         │ ├─ 🟢 The Black Market Pipeline    [✓]    │ ← Completed
         │ ├─ 🟢 The Enforcer Retaliation     [  ]   │ ← Active
         │                                             │
         │ ACT II: THE MID-TIER SPIRE                  │
         │ Infrastructure systems & corporate weakness │
         │ [UNLOCK REQUIRED: 200+ FUNDS]               │
         │                                             │
         │ ├─ 🔒 The Data Center Heist       [  ]   │ ← Locked
         │ └─ 🔒 The Firewall Sabotage       [  ]   │ ← Locked
         │                                             │
         │ ACT III: THE CORE MAINFRAME                │
         │ The final decryption matrix                │
         │ [UNLOCK REQUIRED: 5+ NODES VISITED]        │
         │                                             │
         │ └─ 🔒 Final Override               [  ]   │ ← Locked
         │                                             │
         └─────────────────────────────────────────────┘
         │ [Tap back arrow]
         ↓
         ┌────────────────────────────────────────────────┐
         │      SETTINGS SCREEN (Options)                 │
         │                                                │
         │ SYSTEM SETTINGS           ← (back arrow)       │
         │                                                │
         │ DISPLAY & RENDERING                            │
         │ ┌────────────────────────────────────────┐    │
         │ │ GLITCH EFFECT         [  ━━● ON ]    │    │ Toggle
         │ │ Toggles terminal scanline filter     │    │
         │ └────────────────────────────────────────┘    │
         │                                                │
         │ AUDIO SETTINGS                                 │
         │ ┌────────────────────────────────────────┐    │
         │ │ SOUND EFFECTS         [  ━━● ON ]    │    │ Toggle
         │ │ Enable/disable game audio feedback   │    │
         │ └────────────────────────────────────────┘    │
         │                                                │
         │ TEXT RENDERING                                 │
         │ ┌────────────────────────────────────────┐    │
         │ │ TYPEWRITER SPEED                 NORMAL    │
         │ │ ┌─────────────────────────────────┐        │
         │ │ │ Slow   ●────────────── Instant │        │ Slider
         │ │ └─────────────────────────────────┘        │
         │ └────────────────────────────────────────┘    │
         │                                                │
         │ DANGER ZONE                                    │
         │ ┌────────────────────────────────────────┐    │
         │ │ ⚠️ SYSTEM CACHE WIPE                  │    │ Pink
         │ │ Flushes all progress & resets game   │    │
         │ └────────────────────────────────────────┘    │
         │                                                │
         │ INFO                                           │
         │ ECHOES OF 2076  v1.0.0 | Delhi Neo-Noir     │
         │                                                │
         └────────────────────────────────────────────────┘
         │ [Tap back arrow]
         ↓
         ┌──────────────────────────────────────┐
         │  Returns to HOME SCREEN               │
         │  (Dashboard hub)                      │
         │                                       │
         │  ┌─────────────────────────────────┐ │
         │  │  ENGAGE MISSION ⚡               │ │
         │  │    (Ready for more gameplay?)   │ │
         │  └─────────────────────────────────┘ │
         └──────────────────────────────────────┘
                         │
                         └─ Tap again...
                            Story generation...
                            New choices...
                            Personality evolves...
```

---

## 🎬 Typical Playthrough Timeline

### First Session (45 minutes)
- Splash: 3 sec
- Onboarding: 4 min (interactive sliders)
- Character select: 1 min
- Dashboard exploration: 2 min
- Gameplay Act I: 35 min (10 nodes × 3-4 min per node)

### Second Session (30 minutes)
- Dashboard return: 1 min
- Gameplay Act II: 25 min (8 nodes, tougher choices)
- Profile check: 2 min (see new achievements)
- Leaderboard: 2 min

### Third+ Sessions
- Full Act III: 45+ min (25 nodes, finale)
- Alternative paths: Replay with different character
- Achievement hunting: Target specific unlocks

---

## 🏆 Achievement Progression Path

```
First 5 Nodes:
├─ [FIRST STEPS] ✅ Complete 5 nodes

First 10 Nodes:
├─ [QUESTION AUTHORITY] ✅ Rebellion 50+
├─ [ECO CONSCIOUS] ✅ Eco Index 50+
└─ [EMERGING LEADER] ✅ Leadership 50+

Node 20:
├─ [NARRATIVE EXPLORER] ✅ Visited 20 nodes
└─ Various stat milestones

Node 50:
├─ [VETERAN PATHFINDER] ✅ Visited 50 nodes
├─ [ENVIRONMENTAL SAVIOR] ✅ Eco 80+
├─ [COMMUNITY LEADER] ✅ Mutual Aid 80+
└─ [ELITE NETRUNNER] ✅ Tech Aptitude 80+

Final Node 53:
├─ [NARRATIVE MASTER] ✅ Visited all nodes
└─ [PERFECTLY BALANCED] ✅ All metrics 50+
```

---

## 🎨 Visual Moments Worth Experiencing

1. **Splash Screen Boot Sequence** - The game feels real, like you're accessing a restricted system
2. **First Story Node Choice** - Moment of real consequence (choice 1/50+)
3. **Personality Pivot** - When metrics reveal your operative archetype
4. **Act II Unlock** - Cinematic moment when Mid-Tier Spire opens
5. **Final Node Climax** - All your choices culminate in the ending
6. **Leaderboard Check** - See where you rank vs. other players' styles
7. **Achievement Cascade** - Multiple unlocks at once when reaching milestones
8. **Return to Dashboard** - The hub feels more "yours" after 20+ nodes

---

## 🎮 Gameplay Styles (Paths to Victory)

### Pure Heart Path
- Max Empathy, avoid Rebellion
- Story: Humanitarian ending
- Achievements: PURE HEART + COMMUNITY LEADER
- Funds: Lowest
- Playstyle: Sacrifice personal gain for collective good

### Cold Logic Path
- Max Tech Aptitude, low Empathy
- Story: Pragmatic ending
- Achievements: COLD LOGIC + ELITE NETRUNNER
- Funds: Highest
- Playstyle: Exploit systems for profit

### Revolutionary Path
- Max Rebellion, high Leadership
- Story: Chaos/uprising ending
- Achievements: REBEL OPERATIVE + TACTICAL MASTERMIND
- Funds: Medium-high
- Playstyle: Maximize conflict, leader of the resistance

### Balanced Path
- 50-70 across all stats
- Story: Nuanced "realistic" ending
- Achievements: PERFECTLY BALANCED + RENAISSANCE OPERATIVE
- Funds: Medium
- Playstyle: Weigh every decision carefully

---

## 📊 Success Indicators (You're "Winning" If...)

✅ Tried all 9 screens  
✅ Unlocked at least 5 achievements  
✅ Reached Act II (200+ funds)  
✅ Personality archetype emerged (see profile)  
✅ Metric balance tells a story (all high/low/mixed)  
✅ Leaderboard position makes sense (rich = high funds, etc.)  
✅ Return multiple times (hooked on narrative)  

---

## 🚀 Launch Day Checklist

- [ ] Play through Splash → Onboarding → CharSelect → Home
- [ ] Complete Act I (all 10 nodes)
- [ ] Check 3 achievements unlocked
- [ ] View Profile (personality visible)
- [ ] Check Leaderboard (you appear)
- [ ] Adjust Settings (test glitch toggle)
- [ ] View Story Map (see Act II locked/unlocked)
- [ ] Return to gameplay (continue to Act II)
- [ ] Share your operative codename! 🎮

---

**Your game is ready to play. What will your operative become?** 🌆🤖✊
