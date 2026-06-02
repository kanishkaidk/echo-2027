import 'package:flutter/material.dart';
import '../models/game_state.dart';

class ProfileScreen extends StatelessWidget {
  final String playerName;
  final GameMetrics metrics;
  final VoidCallback onBack;

  const ProfileScreen({
    super.key,
    required this.playerName,
    required this.metrics,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: Stack(
        children: [
          CustomPaint(
            painter: _GridPainter(),
            size: Size.infinite,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
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
                            'OPERATIVE PROFILE',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            playerName.toUpperCase(),
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
                        onTap: onBack,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withAlpha((50)),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white.withAlpha((150)),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Key Metrics
                  Text(
                    'PRIMARY METRICS',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _MetricCard(
                    label: 'OPERATIVE LEVEL',
                    value: metrics.getOperativeLevel(),
                    color: const Color(0xFFFFD700),
                  ),
                  const SizedBox(height: 12),
                  _MetricCard(
                    label: 'TOTAL SCRIP ACCUMULATED',
                    value: '${metrics.funds} CREDITS',
                    color: const Color(0xFFFFD700),
                  ),
                  const SizedBox(height: 12),
                  _MetricCard(
                    label: 'NODES VISITED',
                    value: '${metrics.totalNodesVisited}',
                    color: const Color(0xFF00FFCC),
                  ),
                  const SizedBox(height: 32),

                  // Personality Deep Dive
                  Text(
                    'PSYCHOLOGICAL PROFILE',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _PersonalitySection(metrics: metrics),
                  const SizedBox(height: 32),

                  // Achievements
                  Text(
                    'ACHIEVEMENTS UNLOCKED',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _AchievementGrid(metrics: metrics),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withAlpha((15)),
            color.withAlpha((5)),
          ],
        ),
        border: Border.all(
          color: color.withAlpha((60)),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha((150)),
              letterSpacing: 1,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
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

class _PersonalitySection extends StatelessWidget {
  final GameMetrics metrics;

  const _PersonalitySection({required this.metrics});

  @override
  Widget build(BuildContext context) {
    final traits = [
      ('EMPATHY INDEX', metrics.empathyIndex, const Color(0xFF00FF88)),
      ('TECH APTITUDE', metrics.techAptitude, const Color(0xFF00FFCC)),
      ('LEADERSHIP', metrics.leadership, const Color(0xFFFFD700)),
      ('REBELLION INDEX', metrics.rebellionIndex, const Color(0xFFFF006E)),
    ];

    return Column(
      children: traits.asMap().entries.map((entry) {
        final label = entry.value.$1;
        final value = entry.value.$2;
        final color = entry.value.$3;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha((150)),
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    '${value.clamp(0, 100)}/100',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: value.clamp(0, 100) / 100,
                  minHeight: 8,
                  backgroundColor: Colors.white.withAlpha((20)),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _AchievementGrid extends StatelessWidget {
  final GameMetrics metrics;

  const _AchievementGrid({required this.metrics});

  List<_Achievement> _getAchievements() {
    final achievements = <_Achievement>[];

    if (metrics.funds >= 1000) {
      achievements.add(_Achievement(
        name: 'SCRIP MILLIONAIRE',
        description: 'Accumulated 1000+ credits',
        icon: Icons.attach_money,
        unlocked: true,
        color: const Color(0xFFFFD700),
      ));
    }

    if (metrics.ecoIndex >= 80) {
      achievements.add(_Achievement(
        name: 'ENVIRONMENTAL SAVIOR',
        description: 'Eco Index above 80',
        icon: Icons.eco,
        unlocked: true,
        color: const Color(0xFF00FF88),
      ));
    }

    if (metrics.mutualAid >= 80) {
      achievements.add(_Achievement(
        name: 'COMMUNITY LEADER',
        description: 'Mutual Aid above 80',
        icon: Icons.group,
        unlocked: true,
        color: const Color(0xFF00FFCC),
      ));
    }

    if (metrics.rebellionIndex >= 85) {
      achievements.add(_Achievement(
        name: 'REBEL OPERATIVE',
        description: 'Rebellion Index above 85',
        icon: Icons.flash_on,
        unlocked: true,
        color: const Color(0xFFFF006E),
      ));
    }

    if (metrics.totalNodesVisited >= 20) {
      achievements.add(_Achievement(
        name: 'VETERAN PATHFINDER',
        description: 'Visited 20+ story nodes',
        icon: Icons.route,
        unlocked: true,
        color: const Color(0xFF00FFCC),
      ));
    }

    // Locked achievements
    if (metrics.funds < 2000) {
      achievements.add(_Achievement(
        name: 'CAPITALIST ELITE',
        description: 'Accumulate 2000+ credits',
        icon: Icons.trending_up,
        unlocked: false,
        color: const Color(0xFFFFD700),
      ));
    }

    if (metrics.totalNodesVisited < 50) {
      achievements.add(_Achievement(
        name: 'NARRATIVE MASTER',
        description: 'Complete 50 story nodes',
        icon: Icons.book,
        unlocked: false,
        color: const Color(0xFF00D9FF),
      ));
    }

    return achievements;
  }

  @override
  Widget build(BuildContext context) {
    final achievements = _getAchievements();

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: achievements
          .map((a) => _AchievementTile(achievement: a))
          .toList(),
    );
  }
}

class _Achievement {
  final String name;
  final String description;
  final IconData icon;
  final bool unlocked;
  final Color color;

  _Achievement({
    required this.name,
    required this.description,
    required this.icon,
    required this.unlocked,
    required this.color,
  });
}

class _AchievementTile extends StatelessWidget {
  final _Achievement achievement;

  const _AchievementTile({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: achievement.unlocked
              ? [
                  achievement.color.withAlpha((20)),
                  achievement.color.withAlpha((5)),
                ]
              : [
                  Colors.white.withAlpha((5)),
                  Colors.white.withAlpha((2)),
                ],
        ),
        border: Border.all(
          color: achievement.unlocked
              ? achievement.color.withAlpha((80))
              : Colors.white.withAlpha((30)),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            achievement.icon,
            color: achievement.unlocked
                ? achievement.color
                : Colors.white.withAlpha((80)),
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            achievement.name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: achievement.unlocked
                  ? achievement.color
                  : Colors.white.withAlpha((100)),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            achievement.description,
            style: TextStyle(
              fontSize: 8,
              color: Colors.white.withAlpha((achievement.unlocked ? 120 : 70)),
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
