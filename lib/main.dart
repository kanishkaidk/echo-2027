import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'models/game_state.dart';
import 'services/gemini_service.dart';
import 'widgets/glass_hud.dart';
import 'widgets/typewriter_text.dart';
import 'screens/splash_screen.dart';
import 'screens/character_select_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/story_map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EchoesOf2076App());
}

class EchoesOf2076App extends StatelessWidget {
  const EchoesOf2076App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Echoes of 2076',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF050508),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Color(0xFF00FFCC),
            letterSpacing: 3,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF00FFCC),
            letterSpacing: 1.5,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.7,
            color: Color(0xFFE0E0E0),
          ),
        ),
      ),
      home: const GameRouter(),
    );
  }
}

enum GameScreen {
  splash,
  characterSelect,
  home,
  gameplay,
  profile,
  leaderboard,
  settings,
  storyMap,
}

class GameRouter extends StatefulWidget {
  const GameRouter({super.key});

  @override
  State<GameRouter> createState() => _GameRouterState();
}

class _GameRouterState extends State<GameRouter> {
  GameScreen _currentScreen = GameScreen.splash;
  GameMetrics _gameMetrics = GameMetrics();
  String? _playerName;

  void _transitionTo(GameScreen screen, {GameMetrics? metrics}) {
    setState(() {
      _currentScreen = screen;
      if (metrics != null) _gameMetrics = metrics;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case GameScreen.splash:
        return SplashScreen(
          onComplete: () => _transitionTo(GameScreen.characterSelect),
        );

      case GameScreen.characterSelect:
        return CharacterSelectScreen(
          onCharacterSelected: (name, metrics) {
            _playerName = name;
            _gameMetrics = metrics;
            _transitionTo(GameScreen.home);
          },
        );

      case GameScreen.home:
        return HomeScreen(
          playerName: _playerName ?? 'Operative',
          metrics: _gameMetrics,
          onPlayMission: () => _transitionTo(GameScreen.gameplay),
          onViewProfile: () => _transitionTo(GameScreen.profile),
          onViewLeaderboard: () => _transitionTo(GameScreen.leaderboard),
          onViewSettings: () => _transitionTo(GameScreen.settings),
        );

      case GameScreen.gameplay:
        return GameplayScreen(
          playerName: _playerName ?? 'Operative',
          initialMetrics: _gameMetrics,
          onMetricsUpdate: (newMetrics) {
            _gameMetrics = newMetrics;
          },
          onReturnHome: () => _transitionTo(GameScreen.home),
          onGameReset: () => _transitionTo(GameScreen.splash),
        );

      case GameScreen.profile:
        return ProfileScreen(
          playerName: _playerName ?? 'Operative',
          metrics: _gameMetrics,
          onBack: () => _transitionTo(GameScreen.home),
        );

      case GameScreen.leaderboard:
        return LeaderboardScreen(
          playerName: _playerName ?? 'Operative',
          playerMetrics: _gameMetrics,
          onBack: () => _transitionTo(GameScreen.home),
        );

      case GameScreen.settings:
        return SettingsScreen(
          onBack: () => _transitionTo(GameScreen.home),
          onResetGame: () => _transitionTo(GameScreen.splash),
        );

      case GameScreen.storyMap:
        return StoryMapScreen(
          metrics: _gameMetrics,
          onSelectNode: () => _transitionTo(GameScreen.gameplay),
          onBack: () => _transitionTo(GameScreen.home),
        );
    }
  }
}

// ===== INTRO SCREEN =====
class IntroScreen extends StatefulWidget {
  final VoidCallback onStart;

  const IntroScreen({super.key, required this.onStart});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF050508),
              const Color(0xFF0a0a10),
              const Color(0xFF050508),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ECHOES OF 2076',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'A cyberpunk underground story',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF00D9FF),
                        fontSize: 14,
                        letterSpacing: 2,
                      ),
                ),
                const SizedBox(height: 64),
                _AnimatedButton(
                  label: 'BEGIN',
                  onPressed: widget.onStart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===== REGISTRATION SCREEN =====
class RegistrationScreen extends StatefulWidget {
  final Function(String, GameMetrics) onCharacterCreated;

  const RegistrationScreen({
    super.key,
    required this.onCharacterCreated,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF050508),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OPERATIVE REGISTRATION',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 48),
                TextField(
                  controller: _nameController,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Enter operative codename',
                    hintStyle: TextStyle(
                      color: Colors.white.withAlpha((0.3 * 255).toInt()),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF00FFCC),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white.withAlpha((0.2 * 255).toInt()),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF00FFCC),
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (_) => _submitName(),
                ),
                const SizedBox(height: 32),
                _AnimatedButton(
                  label: 'DEPLOY',
                  onPressed: _submitName,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitName() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    widget.onCharacterCreated(name, GameMetrics());
  }
}

// ===== GAMEPLAY SCREEN =====
class GameplayScreen extends StatefulWidget {
  final String playerName;
  final GameMetrics initialMetrics;
  final Function(GameMetrics) onMetricsUpdate;
  final VoidCallback onReturnHome;
  final VoidCallback onGameReset;

  const GameplayScreen({
    super.key,
    required this.playerName,
    required this.initialMetrics,
    required this.onMetricsUpdate,
    required this.onReturnHome,
    required this.onGameReset,
  });

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen>
    with TickerProviderStateMixin {
  late GeminiService _geminiService;
  late GameMetrics _currentMetrics;
  StoryNode? _currentNode;
  bool _isLoading = false;
  late AnimationController _nodeTransitionController;

  @override
  void initState() {
    super.initState();
    _currentMetrics = widget.initialMetrics;
    _nodeTransitionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Secure compiler link setup
    const apiKey = String.fromEnvironment('GEMINI_API_KEY');

    if (apiKey.isEmpty || apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
      _showApiKeyError();
    } else {
      _geminiService = GeminiService(apiKey: apiKey);
      _loadBaselineIntroNode();
    }
  }

  @override
  void dispose() {
    _nodeTransitionController.dispose();
    super.dispose();
  }

  void _showApiKeyError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'API Key missing! Please launch using --dart-define config.',
        ),
        backgroundColor: const Color(0xFFFF006E),
      ),
    );
  }

  /// Injects the static baseline intro branch bypassing empty system calls
  void _loadBaselineIntroNode() {
    setState(() {
      _currentNode = StoryNode(
        id: "intro_sector_7",
        characterName: "The Ghost Matrix",
        dialogueText: "Welcome back, ${widget.playerName}. The atmospheric acid levels outside have spiked. Corporate overrides have locked the oxygen scrubbers behind premium credit walls on lower hab-decks. Below the visual neon spires, our underground resistance is struggling to sustain a solar-punk structural grid. A fresh decryption pulse has intercepted corporate blueprints. Make your play.",
        typewrittenText: "Welcome back, ${widget.playerName}. The atmospheric acid levels outside have spiked. Corporate overrides have locked the oxygen scrubbers behind premium credit walls on lower hab-decks. Below the visual neon spires, our underground resistance is struggling to sustain a solar-punk structural grid. A fresh decryption pulse has intercepted corporate blueprints. Make your play.",
        characterAvatar: "assets/avatars/narrator.png",
        choices: [
          GameChoice(
            id: "choice_leak_1",
            text: "Reroute generator matrices to power public hydroponic bays",
            mutualAidDelta: 15,
            ecoIndexDelta: 10,
            fundsDelta: -100,
            isHighStakes: false,
          ),
          GameChoice(
            id: "choice_leak_2",
            text: "Sell the encryption bypass arrays to an autonomous corporate broker",
            mutualAidDelta: -25,
            ecoIndexDelta: -10,
            fundsDelta: 350,
            isHighStakes: true,
          ),
        ],
      );
    });
    _nodeTransitionController.forward();
  }

  Future<void> _handleChoice(GameChoice choice) async {
    // Apply local state metrics modifiers dynamically
    final personalityDelta = choice.personalityImpact;
    final newMetrics = _currentMetrics.copyWith(
      mutualAid: _currentMetrics.mutualAid + choice.mutualAidDelta,
      ecoIndex: _currentMetrics.ecoIndex + choice.ecoIndexDelta,
      funds: _currentMetrics.funds + choice.fundsDelta,
      empathyIndex: _currentMetrics.empathyIndex + (personalityDelta?.empathyDelta ?? 0),
      techAptitude: _currentMetrics.techAptitude + (personalityDelta?.techDelta ?? 0),
      leadership: _currentMetrics.leadership + (personalityDelta?.leadershipDelta ?? 0),
      rebellionIndex: _currentMetrics.rebellionIndex + (personalityDelta?.rebellionDelta ?? 0),
      totalNodesVisited: _currentMetrics.totalNodesVisited + 1,
    ).clamp();

    widget.onMetricsUpdate(newMetrics);

    setState(() {
      _currentMetrics = newMetrics;
      _isLoading = true;
    });

    _nodeTransitionController.reset();

    try {
      // Direct call to our clean parsed service layer
      final nextNode = await _geminiService.generateNextNode(
        playerChoice: choice,
        currentMetrics: newMetrics,
        previousNodeId: _currentNode?.id ?? 'initial',
      );

      if (mounted) {
        setState(() {
          _currentNode = nextNode;
          _isLoading = false;
        });

        await Future.delayed(const Duration(milliseconds: 100));
        _nodeTransitionController.forward();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating next node: $e'),
            backgroundColor: const Color(0xFFFF006E),
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentNode == null && _isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xFF00FFCC)),
              ),
              const SizedBox(height: 24),
              Text(
                'Connecting to the network...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    if (_currentNode == null) {
      return Scaffold(
        body: Center(
          child: _AnimatedButton(
            label: 'RETRY',
            onPressed: _loadBaselineIntroNode,
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            color: const Color(0xFF050508),
            child: CustomPaint(
              painter: _CyberpunkBackgroundPainter(),
              size: Size.infinite,
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HUD
                  GlassHUD(metrics: _currentMetrics),
                  const SizedBox(height: 32),

                  // Dialogue node with transition
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.95, end: 1.0)
                              .animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _DialogueBox(
                      key: ValueKey(_currentNode!.id),
                      node: _currentNode!,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Choices
                  if (!_isLoading)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _currentNode!.choices
                          .map((choice) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12),
                                child: _ChoicePill(
                                  choice: choice,
                                  onPressed: () =>
                                      _handleChoice(choice),
                                ),
                              ))
                          .toList(),
                    )
                  else
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.color,
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: widget.onReturnHome,
                        child: Text(
                          'RETURN TO DASHBOARD',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Colors.white.withAlpha(
                                    (0.5 * 255).toInt()),
                              ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: widget.onGameReset,
                        child: Text(
                          'RESET GAME',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Colors.white.withAlpha(
                                    (0.4 * 255).toInt()),
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== DIALOGUE BOX WIDGET =====
class _DialogueBox extends StatefulWidget {
  final StoryNode node;

  const _DialogueBox({
    super.key,
    required this.node,
  });

  @override
  State<_DialogueBox> createState() => _DialogueBoxState();
}

class _DialogueBoxState extends State<_DialogueBox> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withAlpha((0.06 * 255).toInt()),
                Colors.white.withAlpha((0.02 * 255).toInt()),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withAlpha((0.15 * 255).toInt()),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Character name
              Text(
                widget.node.characterName.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 16),

              // Typewriter dialogue
              TypewriterText(
                text: widget.node.typewrittenText,
                style: Theme.of(context).textTheme.bodyLarge,
                charDuration: const Duration(milliseconds: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== CHOICE PILL WIDGET =====
class _ChoicePill extends StatefulWidget {
  final GameChoice choice;
  final VoidCallback onPressed;

  const _ChoicePill({
    required this.choice,
    required this.onPressed,
  });

  @override
  State<_ChoicePill> createState() => _ChoicePillState();
}

class _ChoicePillState extends State<_ChoicePill>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.choice.isHighStakes
        ? const Color(0xFFFF006E)
        : const Color(0xFF00FFCC);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        _hoverController.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.03)
            .animate(_hoverController),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accentColor.withAlpha((0.08 * 255).toInt()),
                  accentColor.withAlpha((0.03 * 255).toInt()),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: _isHovering
                    ? accentColor
                    : accentColor.withAlpha((0.4 * 255).toInt()),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: _isHovering
                  ? [
                      BoxShadow(
                        color: accentColor.withAlpha((0.5 * 255).toInt()),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Text(
              widget.choice.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// ===== ANIMATED BUTTON =====
class _AnimatedButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _AnimatedButton({
    required this.label,
    required this.onPressed,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onPressed,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.08)
              .animate(_controller),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isHovering
                    ? [
                        const Color(0xFF00FFCC),
                        const Color(0xFF00D9FF),
                      ]
                    : [
                        const Color(0xFF00FFCC).withAlpha((0.6 * 255).toInt()),
                        const Color(0xFF00D9FF).withAlpha((0.6 * 255).toInt()),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: _isHovering
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00FFCC)
                            .withAlpha((0.4 * 255).toInt()),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF050508),
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===== CYBERPUNK BACKGROUND PAINTER =====
class _CyberpunkBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha((0.02 * 255).toInt())
      ..strokeWidth = 0.5;

    // Draw subtle grid
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_CyberpunkBackgroundPainter oldDelegate) => false;
}
