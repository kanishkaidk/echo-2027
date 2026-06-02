# 🌆 Echoes of 2076

An immersive, brutalist cyber-industrial visual novel and text-based role-playing game built using Flutter. Set in the toxic, corporate-choked underbelly of a futuristic Delhi, players navigate a dense web of systemic resistance, mutual aid logistics, and black-market software deployment. 

Every choice carries systemic weight—shifting local metrics, fluctuating currency assets, and profiling your strategic personality profile in real-time.

---

## 🎨 Design System: Delhi 2076 Neo-Noir

This application deliberately rejects standard modern flat design trends and overused color schemes. Instead, it implements a highly custom, **Brutalist Cyber-Industrial** visual framework optimized for high-density terminal readability:

* **Scaffold Void (`0xFF020204`):** An absolute obsidian canvas mimicking deactivated military terminal hardware.
* **Toxic Mint Green (`0xFF00FFCC`):** The primary color vector used for stable system frameworks, grid lines, and active terminal paths.
* **Neon Synth-Pink (`0xFFFF006E`):** Used strictly for high-stakes operational choices, compromised security overrides, and systemic failures.
* **Cyber-Gold (`0xFFFFD700`):** Tracks your liquid nano-scrip transaction indicators.
* **Cathode-Ray Typography:** Monospaced structural text pairing a custom layout hierarchy with subtle glowing drop-shadows to emulate vintage high-frequency CRT monitor matrices.

---

## ⚙️ Core Architecture & RPG Mechanics
[Act I: The Lower Hab-Decks]
├── Chapter 1: The Air Scrubber Breach
├── Chapter 2: The Black Market Pipeline
└── Chapter 3: The Enforcer Retaliation

[Act II: The Mid-Tier Spire Infrastructure] (Requires Act I Completion)
├── Chapter 4: The Data Center Heist
└── Chapter 5: The Corporate Firewall Sabotage

[Act III: The Core Cloud Mainframe]
└── Chapter 6: Final Decryption Matrix Override

### 1. Dynamic State Tracking HUD
The player must balance four core resource indices simultaneously via a glassmorphic command header widget. Letting either structural index fall to `0%` triggers an immediate terminal disconnect (Game Over):
* **Mutual Aid (%):** Faction alignment with local civilian blocks, community safety nets, and underground cell coordination.
* **Eco Index (%):** The atmospheric air filter viability index of your sector.
* **Funds (Scrip Coins):** Black-market financial assets used to bypass physical corporate checkpoints or purchase premium tactical gear.

### 2. Psychological Operative Profiling
The engine tracks invisible traits based on individual decision branches, altering how NPCs interact with your profile across subsequent stages:
* **Empathy Index ($E_i$):** Humanitarian prioritization over direct efficiency vectors.
* **Tech Aptitude ($T_a$):** Tactical capability regarding architectural overloads and hardware exploitation.
* **Leadership ($L_d$):** Your organizational grip over local militant resistance networks.
* **Rebellion Index ($R_b$):** Exposure and aggression indicators targeted at corporate system security layers.

---

## 🛠️ Application Feature Roadmap

* [x] **State Machine Router Engine:** Seamless enum-driven transition states tracking `Intro` → `Registration` → `Gameplay` → `GameOver` views.
* [x] **Kinetic Floating Choice Pills:** Reactive choice interfaces equipped with dedicated hardware micro-interaction scale scales and glowing aura shadow responses.
* [x] **Asymmetric Grid Canvas Background:** Pure declarative UI rendering utilizing `CustomPainter` vector arrays to draw technical grid guidelines dynamically.
* [x] **Typewriter Narrative Rendering:** Specialized text asset streams revealing data blocks character-by-character to maximize immersion.
* [ ] **Visual Stage Selection Map:** A vertical interactive branching timeline tree tracking stage locks and progression markers via custom node links.
* [ ] **Operative Character Carousel Selection:** Specialized starting class configurations (Netrunner, Street Fixer, Eco-Infiltrator) adjusting base stat arrays.
* [ ] **Local Setting Control Matrix:** Real-time calibration tools adjusting typewriter character read speeds and scanning glitch filters.

---

## 🚀 Local Installation & Deployment

To launch the app locally on your machine in full debug mode using embedded command line variables, follow these parameters:

### Prerequisites
* Flutter SDK (3.x or higher)
* Google Chrome (for target web runtime compilation)

### Execution Pipeline
```bash
# Clone the repository remote path
git clone [https://github.com/kanishkaidk/mobile-game-app.git](https://github.com/kanishkaidk/mobile-game-app.git)

# Change directory into the project folder root
cd mobile-game-app

# Wipe compilation build artifacts and refresh local index caches
flutter clean
flutter pub get

# Compile and spin up the live server thread using target environment variables
flutter run -d chrome --dart-define=GEMINI_API_KEY="YOUR_SECURE_GEMINI_API_KEY_HERE"
📜 Development Logs & Milestones
Phase 1: Setup base engine architecture and established deep responsive dark-theme glassmorphic widget templates.

Phase 2: Migrated remote JSON string network processing handlers to optimized async structural services.

Phase 3: Engineered fully isolated local database routing logic to guarantee maximum execution speeds, bypass API token usage caps, and shield project environments against CORS blocking loops.

## 📤 Push It Live!

Save that file as `README.md`, pop open your **Git Bash** terminal inside VS Code, and run this fast sequence to make it look incredible on GitHub:

```bash
git add README.md
git commit -m "docs: generate comprehensive cyberpunk technical documentation readme"
git push
