import 'package:flutter/material.dart';
import '../models/game_state.dart';

class HomeScreen extends StatefulWidget {
  final String playerName;
  final GameMetrics metrics;
  final VoidCallback onPlayMission;
  final VoidCallback onViewProfile;
  final VoidCallback onViewLeaderboard;
  final VoidCallback onViewSettings;

  const HomeScreen({
    super.key,
    required this.playerName,
    required this.metrics,
    required this.onPlayMission,
    required this.onViewProfile,
    required this.onViewLeaderboard,
    required this.onViewSettings,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: Stack(
        children: [
          // Grid background
          CustomPaint(
            painter: _DashboardGridPainter(),
            size: Size.infinite,
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OPERATIVE DASHBOARD',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: 24,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.playerName.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: const Color(0xFF00FFCC),
                                  fontSize: 12,
                                  letterSpacing: 2,
                                ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: widget.onViewSettings,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withAlpha((50)),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.settings,
                            color: Colors.white.withAlpha((150)),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Operative Level
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFD700).withAlpha((20)),
                          const Color(0xFFFFD700).withAlpha((5)),
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withAlpha((80)),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OPERATIVE LEVEL',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withAlpha((150)),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.metrics.getOperativeLevel(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFFD700),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'MISSION TIME',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withAlpha((150)),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            _ElapsedTimer(seconds: widget.metrics.getElapsedSeconds()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Primary Mission Button
                  GestureDetector(
                    onTap: widget.onPlayMission,
                    child: _MissionPulseButton(
                      pulseAnimation: _pulseController,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Stats Grid
                  Text(
                    'SYSTEM STATUS',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _StatTile(
                        label: 'MUTUAL AID',
                        value: widget.metrics.mutualAid,
                        color: const Color(0xFF00FF88),
                      ),
                      _StatTile(
                        label: 'ECO INDEX',
                        value: widget.metrics.ecoIndex,
                        color: const Color(0xFF00FFCC),
                      ),
                      _StatTile(
                        label: 'SCRIP TOKENS',
                        value: widget.metrics.funds,
                        color: const Color(0xFFFFD700),
                        isLarge: true,
                      ),
                      _StatTile(
                        label: 'NODES VISITED',
                        value: widget.metrics.totalNodesVisited,
                        color: const Color(0xFFFF006E),
                        isLarge: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Personality Matrix
                  Text(
                    'PERSONALITY MATRIX',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _PersonalityRadar(metrics: widget.metrics),
                  const SizedBox(height: 32),

                  // Navigation Tiles
                  Row(
                    children: [
                      Expanded(
                        child: _NavTile(
                          label: 'PROFILE',
                          icon: Icons.person,
                          onTap: widget.onViewProfile,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _NavTile(
                          label: 'LEADERBOARD',
                          icon: Icons.leaderboard,
                          onTap: widget.onViewLeaderboard,
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

class _StatTile extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final bool isLarge;

  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withAlpha((25)),
            color.withAlpha((8)),
          ],
        ),
        border: Border.all(
          color: color.withAlpha((80)),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withAlpha((150)),
              letterSpacing: 1,
            ),
          ),
          Text(
            isLarge ? value.toString() : '${value.clamp(0, 100)}/100',
            style: TextStyle(
              fontSize: isLarge ? 20 : 16,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionPulseButton extends StatelessWidget {
  final AnimationController pulseAnimation;

  const _MissionPulseButton({required this.pulseAnimation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00FFCC).withAlpha((15)),
            const Color(0xFF00FFCC).withAlpha((5)),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF00FFCC).withAlpha((80)),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0)
                .animate(pulseAnimation),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00FFCC),
                    Color(0xFF00D9FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00FFCC).withAlpha((150)),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Text(
                'ENGAGE MISSION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF050508),
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'INCOMING OPERATIONAL DIRECTIVE',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha((120)),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ElapsedTimer extends StatefulWidget {
  final int seconds;

  const _ElapsedTimer({required this.seconds});

  @override
  State<_ElapsedTimer> createState() => _ElapsedTimerState();
}

class _ElapsedTimerState extends State<_ElapsedTimer> {
  late int _displaySeconds;

  @override
  void initState() {
    super.initState();
    _displaySeconds = widget.seconds;
  }

  @override
  void didUpdateWidget(_ElapsedTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _displaySeconds = widget.seconds;
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_displaySeconds),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w900,
        color: Color(0xFFFFD700),
        letterSpacing: 1,
      ),
    );
  }
}

class _PersonalityRadar extends StatelessWidget {
  final GameMetrics metrics;

  const _PersonalityRadar({required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _PersonalityBar(
            label: 'EMPATHY',
            value: metrics.empathyIndex,
            color: const Color(0xFF00FF88),
          ),
          const SizedBox(height: 12),
          _PersonalityBar(
            label: 'TECH APTITUDE',
            value: metrics.techAptitude,
            color: const Color(0xFF00FFCC),
          ),
          const SizedBox(height: 12),
          _PersonalityBar(
            label: 'LEADERSHIP',
            value: metrics.leadership,
            color: const Color(0xFFFFD700),
          ),
          const SizedBox(height: 12),
          _PersonalityBar(
            label: 'REBELLION',
            value: metrics.rebellionIndex,
            color: const Color(0xFFFF006E),
          ),
        ],
      ),
    );
  }
}

class _PersonalityBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _PersonalityBar({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withAlpha((140)),
                letterSpacing: 1,
              ),
            ),
            Text(
              '${value.clamp(0, 100)}/100',
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: value.clamp(0, 100) / 100,
            minHeight: 6,
            backgroundColor: Colors.white.withAlpha((20)),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

class _NavTile extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _NavTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;

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
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.03)
              .animate(_hoverController),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha((10)),
                  Colors.white.withAlpha((3)),
                ],
              ),
              border: Border.all(
                color: Colors.white.withAlpha((50)),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white.withAlpha((180)),
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withAlpha((180)),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha((8))
      ..strokeWidth = 0.5;

    const spacing = 50.0;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
