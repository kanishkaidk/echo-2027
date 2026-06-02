import 'package:flutter/material.dart';
import '../models/game_state.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _slideController;

  // Demo metrics for interactive sliders
  late int _demoMutualAid = 50;
  late int _demoEcoIndex = 30;
  late int _demoFunds = 200;
  late int _demoEmpathy = 40;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: Stack(
        children: [
          // Background grid
          CustomPaint(
            painter: _GridPainter(),
            size: Size.infinite,
          ),

          // Page view
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              _Page1WelcomeScreen(slideController: _slideController),
              _Page2MetricsScreen(
                demoMutualAid: _demoMutualAid,
                demoEcoIndex: _demoEcoIndex,
                demoFunds: _demoFunds,
                onMutualAidChanged: (v) =>
                    setState(() => _demoMutualAid = v.toInt()),
                onEcoIndexChanged: (v) => setState(() => _demoEcoIndex = v.toInt()),
                onFundsChanged: (v) => setState(() => _demoFunds = v.toInt()),
              ),
              _Page3PersonalityScreen(
                demoEmpathy: _demoEmpathy,
                onEmpathyChanged: (v) => setState(() => _demoEmpathy = v.toInt()),
              ),
              _Page4LetsPlayScreen(),
            ],
          ),

          // Navigation controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'OPERATIVE ORIENTATION',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontSize: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withAlpha((50)),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${_currentPage + 1}/4',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha((150)),
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Footer with progress and button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: (_currentPage + 1) / 4,
                          minHeight: 3,
                          backgroundColor: Colors.white.withAlpha((20)),
                          valueColor: const AlwaysStoppedAnimation(
                            Color(0xFF00FFCC),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _nextPage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF00FFCC),
                                Color(0xFF00D9FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _currentPage == 3 ? 'BEGIN MISSION' : 'NEXT',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF050508),
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
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

class _Page1WelcomeScreen extends StatelessWidget {
  final AnimationController slideController;

  const _Page1WelcomeScreen({required this.slideController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(slideController),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ECHOES OF 2076',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                      shadows: [
                        Shadow(
                          color: const Color(0xFF00FFCC).withAlpha((100)),
                          blurRadius: 20,
                        ),
                      ],
                    ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00FFCC).withAlpha((15)),
                      const Color(0xFF00FFCC).withAlpha((5)),
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFF00FFCC).withAlpha((60)),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, Operative',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'You are entering a world of corporate surveillance, underground resistance, and moral ambiguity. Delhi, 2076. The sky is toxic. The corporations control everything. But whispers speak of those who fight back.\n\nYour choices matter. Your decisions shape the narrative. Every action has psychological weight.\n\nThis briefing will teach you the systems that govern your operative profile.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Page2MetricsScreen extends StatelessWidget {
  final int demoMutualAid;
  final int demoEcoIndex;
  final int demoFunds;
  final Function(double) onMutualAidChanged;
  final Function(double) onEcoIndexChanged;
  final Function(double) onFundsChanged;

  const _Page2MetricsScreen({
    required this.demoMutualAid,
    required this.demoEcoIndex,
    required this.demoFunds,
    required this.onMutualAidChanged,
    required this.onEcoIndexChanged,
    required this.onFundsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Text(
            'CORE METRICS',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your operative profile is defined by four key metrics',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  color: Colors.white.withAlpha((150)),
                ),
          ),
          const SizedBox(height: 24),

          // Mutual Aid
          _MetricSlider(
            label: 'MUTUAL AID',
            description: 'Community trust and collective support',
            value: demoMutualAid,
            onChanged: onMutualAidChanged,
            color: const Color(0xFF00FF88),
          ),
          const SizedBox(height: 20),

          // Eco Index
          _MetricSlider(
            label: 'ECO INDEX',
            description: 'Environmental restoration commitment',
            value: demoEcoIndex,
            onChanged: onEcoIndexChanged,
            color: const Color(0xFF00FFCC),
          ),
          const SizedBox(height: 20),

          // Funds
          _FundsSlider(
            value: demoFunds,
            onChanged: onFundsChanged,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class _Page3PersonalityScreen extends StatelessWidget {
  final int demoEmpathy;
  final Function(double) onEmpathyChanged;

  const _Page3PersonalityScreen({
    required this.demoEmpathy,
    required this.onEmpathyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Text(
            'PSYCHOLOGICAL PROFILE',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Every choice reveals your personality archetype',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  color: Colors.white.withAlpha((150)),
                ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha((8)),
                  Colors.white.withAlpha((2)),
                ],
              ),
              border: Border.all(
                color: Colors.white.withAlpha((30)),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Four Dimensions:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 12),
                _PersonalityDimension(
                  label: 'EMPATHY INDEX',
                  description: 'Compassion for human suffering',
                  color: const Color(0xFF00FF88),
                ),
                const SizedBox(height: 10),
                _PersonalityDimension(
                  label: 'TECH APTITUDE',
                  description: 'Mastery of systems and hacking',
                  color: const Color(0xFF00D9FF),
                ),
                const SizedBox(height: 10),
                _PersonalityDimension(
                  label: 'LEADERSHIP',
                  description: 'Ability to inspire and command',
                  color: const Color(0xFFFFD700),
                ),
                const SizedBox(height: 10),
                _PersonalityDimension(
                  label: 'REBELLION INDEX',
                  description: 'Hostility toward corporate order',
                  color: const Color(0xFFFF006E),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

class _Page4LetsPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'READY FOR DEPLOYMENT?',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 28,
                  ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF006E).withAlpha((15)),
                    const Color(0xFFFF006E).withAlpha((5)),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFFFF006E).withAlpha((60)),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'Your operative profile is initialized. You will face 50+ story nodes, each challenging your values. Your choices shape not just the narrative—they shape who you become.',
                    style:
                        Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '[SYS_AUTH] Authorization granted. Mission parameters locked.',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: const Color(0xFFFF006E),
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricSlider extends StatelessWidget {
  final String label;
  final String description;
  final int value;
  final Function(double) onChanged;
  final Color color;

  const _MetricSlider({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withAlpha((15)),
            color.withAlpha((5)),
          ],
        ),
        border: Border.all(
          color: color.withAlpha((60)),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: color,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withAlpha((120)),
                    ),
                  ),
                ],
              ),
              Text(
                '$value/100',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Slider(
            value: value.toDouble(),
            min: 0,
            max: 100,
            onChanged: onChanged,
            activeColor: color,
            inactiveColor: Colors.white.withAlpha((20)),
          ),
        ],
      ),
    );
  }
}

class _FundsSlider extends StatelessWidget {
  final int value;
  final Function(double) onChanged;

  const _FundsSlider({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFD700).withAlpha((15)),
            const Color(0xFFFFD700).withAlpha((5)),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFFFD700).withAlpha((60)),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SCRIP TOKENS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFD700),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Available credits and resources',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withAlpha((120)),
                    ),
                  ),
                ],
              ),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFD700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Slider(
            value: value.toDouble(),
            min: 0,
            max: 1000,
            divisions: 20,
            onChanged: onChanged,
            activeColor: const Color(0xFFFFD700),
            inactiveColor: Colors.white.withAlpha((20)),
          ),
        ],
      ),
    );
  }
}

class _PersonalityDimension extends StatelessWidget {
  final String label;
  final String description;
  final Color color;

  const _PersonalityDimension({
    required this.label,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white.withAlpha((100)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha((8))
      ..strokeWidth = 0.5;

    const spacing = 50.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
