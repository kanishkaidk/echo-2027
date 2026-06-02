import 'package:flutter/material.dart';
import '../models/game_state.dart';

class LeaderboardScreen extends StatelessWidget {
  final String playerName;
  final GameMetrics playerMetrics;
  final VoidCallback onBack;

  const LeaderboardScreen({
    super.key,
    required this.playerName,
    required this.playerMetrics,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final mockLeaderboard = _generateLeaderboard();
    final playerRank = _findPlayerRank(mockLeaderboard, playerName);

    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: Stack(
        children: [
          CustomPaint(
            painter: _GridPainter(),
            size: Size.infinite,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GLOBAL LEADERBOARD',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '[TOP OPERATIVES RANKING]',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: const Color(0xFF00FFCC),
                                  fontSize: 11,
                                  letterSpacing: 1,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'YOUR RANK',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withAlpha((150)),
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '#${playerRank + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFFD700),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'SCRIP BALANCE',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withAlpha((150)),
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${playerMetrics.funds}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFFD700),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: mockLeaderboard.length,
                    itemBuilder: (context, index) {
                      final entry = mockLeaderboard[index];
                      final isPlayer = entry['name'] == playerName;
                      return _LeaderboardRow(
                        rank: index + 1,
                        name: entry['name'] as String,
                        score: entry['score'] as int,
                        isPlayer: isPlayer,
                        isTopThree: index < 3,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _generateLeaderboard() {
    final leaderboard = [
      {'name': 'CIPHER ORACLE', 'score': 2850},
      {'name': 'GHOST WALKER', 'score': 2640},
      {'name': 'NEXUS PRIME', 'score': 2520},
      {'name': 'ROGUE AGENT 7', 'score': 2390},
      {'name': playerName, 'score': playerMetrics.funds},
      {'name': 'ECHO PHANTOM', 'score': 2100},
      {'name': 'VAULT BREAKER', 'score': 1980},
      {'name': 'SHADOW RUNNER', 'score': 1850},
    ];

    leaderboard.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));
    return leaderboard;
  }

  int _findPlayerRank(List<Map<String, dynamic>> leaderboard, String name) {
    return leaderboard.indexWhere((entry) => entry['name'] == name);
  }
}

class _LeaderboardRow extends StatefulWidget {
  final int rank;
  final String name;
  final int score;
  final bool isPlayer;
  final bool isTopThree;

  const _LeaderboardRow({
    required this.rank,
    required this.name,
    required this.score,
    required this.isPlayer,
    required this.isTopThree,
  });

  @override
  State<_LeaderboardRow> createState() => _LeaderboardRowState();
}

class _LeaderboardRowState extends State<_LeaderboardRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  Color _getRankColor() {
    if (widget.rank == 1) return const Color(0xFFFFD700);
    if (widget.rank == 2) return const Color(0xFFC0C0C0);
    if (widget.rank == 3) return const Color(0xFFCD7F32);
    return const Color(0xFF00FFCC);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.01)
            .animate(_hoverController),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isPlayer
                    ? [
                        const Color(0xFF00FFCC).withAlpha((15)),
                        const Color(0xFF00FFCC).withAlpha((5)),
                      ]
                    : widget.isTopThree
                        ? [
                            _getRankColor().withAlpha((12)),
                            _getRankColor().withAlpha((3)),
                          ]
                        : [
                            Colors.white.withAlpha((5)),
                            Colors.white.withAlpha((2)),
                          ],
              ),
              border: Border.all(
                color: widget.isPlayer
                    ? const Color(0xFF00FFCC).withAlpha((80))
                    : widget.isTopThree
                        ? _getRankColor().withAlpha((60))
                        : Colors.white.withAlpha((30)),
                width: widget.isPlayer ? 2 : 1.5,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                // Rank badge
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getRankColor().withAlpha((30)),
                    border: Border.all(
                      color: _getRankColor().withAlpha((80)),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '#${widget.rank}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: _getRankColor(),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: widget.isPlayer
                              ? const Color(0xFF00FFCC)
                              : Colors.white.withAlpha((200)),
                          letterSpacing: 1,
                        ),
                      ),
                      if (widget.isPlayer)
                        Text(
                          '[CURRENT PLAYER]',
                          style: TextStyle(
                            fontSize: 10,
                            color: const Color(0xFF00FFCC).withAlpha((150)),
                            letterSpacing: 1,
                          ),
                        ),
                    ],
                  ),
                ),

                // Score
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.score}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: _getRankColor(),
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'SCRIP',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withAlpha((120)),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
