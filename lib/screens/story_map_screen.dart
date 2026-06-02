import 'package:flutter/material.dart';
import '../models/game_state.dart';

class StoryMapScreen extends StatelessWidget {
  final GameMetrics metrics;
  final VoidCallback onSelectNode;
  final VoidCallback onBack;

  const StoryMapScreen({
    super.key,
    required this.metrics,
    required this.onSelectNode,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: Stack(
        children: [
          CustomPaint(
            painter: _StoryMapPainter(),
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
                            'STORY MAP',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '[NARRATIVE PROGRESSION TREE]',
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
                  const SizedBox(height: 32),

                  // Act I
                  _ChapterSection(
                    chapterName: 'ACT I: THE LOWER HAB-DECKS',
                    description: 'Where resistance begins below the neon',
                    nodes: [
                      _StoryNodeData(
                        id: 'node_1',
                        name: 'The Air Scrubber Breach',
                        description: 'Atmospheric systems failing',
                        isLocked: false,
                        isCompleted: metrics.totalNodesVisited > 0,
                      ),
                      _StoryNodeData(
                        id: 'node_2',
                        name: 'The Black Market Pipeline',
                        description: 'Underground resource network',
                        isLocked: metrics.totalNodesVisited < 1,
                        isCompleted: metrics.totalNodesVisited > 1,
                      ),
                      _StoryNodeData(
                        id: 'node_3',
                        name: 'The Enforcer Retaliation',
                        description: 'Corporate counter-strike',
                        isLocked: metrics.totalNodesVisited < 2,
                        isCompleted: metrics.totalNodesVisited > 2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Act II
                  _ChapterSection(
                    chapterName: 'ACT II: THE MID-TIER SPIRE',
                    description: 'Infrastructure systems and corporate weakness',
                    isUnlocked: metrics.funds > 200,
                    nodes: [
                      _StoryNodeData(
                        id: 'node_4',
                        name: 'The Data Center Heist',
                        description: 'Breaking encrypted vaults',
                        isLocked: metrics.funds <= 200 || metrics.totalNodesVisited < 3,
                        isCompleted: metrics.totalNodesVisited > 3,
                      ),
                      _StoryNodeData(
                        id: 'node_5',
                        name: 'The Firewall Sabotage',
                        description: 'Network system collapse',
                        isLocked: metrics.funds <= 200 || metrics.totalNodesVisited < 4,
                        isCompleted: metrics.totalNodesVisited > 4,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Act III
                  _ChapterSection(
                    chapterName: 'ACT III: THE CORE MAINFRAME',
                    description: 'The final decryption matrix',
                    isUnlocked: metrics.totalNodesVisited > 4,
                    nodes: [
                      _StoryNodeData(
                        id: 'node_6',
                        name: 'Final Override',
                        description: 'System-wide shutdown sequence',
                        isLocked: metrics.totalNodesVisited <= 4,
                        isCompleted: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryNodeData {
  final String id;
  final String name;
  final String description;
  final bool isLocked;
  final bool isCompleted;

  _StoryNodeData({
    required this.id,
    required this.name,
    required this.description,
    required this.isLocked,
    required this.isCompleted,
  });
}

class _ChapterSection extends StatelessWidget {
  final String chapterName;
  final String description;
  final List<_StoryNodeData> nodes;
  final bool isUnlocked;

  const _ChapterSection({
    required this.chapterName,
    required this.description,
    required this.nodes,
    this.isUnlocked = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isUnlocked
                  ? [
                      const Color(0xFF00FFCC).withAlpha((20)),
                      const Color(0xFF00FFCC).withAlpha((5)),
                    ]
                  : [
                      Colors.white.withAlpha((8)),
                      Colors.white.withAlpha((2)),
                    ],
            ),
            border: Border.all(
              color: isUnlocked
                  ? const Color(0xFF00FFCC).withAlpha((60))
                  : Colors.white.withAlpha((30)),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    chapterName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: isUnlocked
                          ? const Color(0xFF00FFCC)
                          : Colors.white.withAlpha((100)),
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  if (!isUnlocked)
                    Icon(
                      Icons.lock,
                      color: Colors.white.withAlpha((80)),
                      size: 18,
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withAlpha((120)),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: nodes.asMap().entries.map((entry) {
              final index = entry.key;
              final node = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < nodes.length - 1 ? 12 : 0,
                ),
                child: _StoryNodeTile(
                  node: node,
                  chapterUnlocked: isUnlocked,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _StoryNodeTile extends StatefulWidget {
  final _StoryNodeData node;
  final bool chapterUnlocked;

  const _StoryNodeTile({
    required this.node,
    required this.chapterUnlocked,
  });

  @override
  State<_StoryNodeTile> createState() => _StoryNodeTileState();
}

class _StoryNodeTileState extends State<_StoryNodeTile>
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

  @override
  Widget build(BuildContext context) {
    final isAccessible = widget.chapterUnlocked && !widget.node.isLocked;

    return MouseRegion(
      onEnter: isAccessible ? (_) => _hoverController.forward() : null,
      onExit: isAccessible ? (_) => _hoverController.reverse() : null,
      child: GestureDetector(
        onTap: isAccessible
            ? () {
                // Navigate to story node
              }
            : null,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.02)
              .animate(_hoverController),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.node.isCompleted
                    ? [
                        const Color(0xFF00FF88).withAlpha((15)),
                        const Color(0xFF00FF88).withAlpha((5)),
                      ]
                    : isAccessible
                        ? [
                            const Color(0xFF00FFCC).withAlpha((12)),
                            const Color(0xFF00FFCC).withAlpha((3)),
                          ]
                        : [
                            Colors.white.withAlpha((5)),
                            Colors.white.withAlpha((2)),
                          ],
              ),
              border: Border.all(
                color: widget.node.isCompleted
                    ? const Color(0xFF00FF88).withAlpha((80))
                    : isAccessible
                        ? const Color(0xFF00FFCC).withAlpha((60))
                        : Colors.white.withAlpha((20)),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: isAccessible
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00FFCC).withAlpha((40)),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                // Status indicator
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: widget.node.isCompleted
                          ? [
                              const Color(0xFF00FF88),
                              const Color(0xFF00FF88).withAlpha((180)),
                            ]
                          : isAccessible
                              ? [
                                  const Color(0xFF00FFCC),
                                  const Color(0xFF00FFCC).withAlpha((180)),
                                ]
                              : [
                                  Colors.white.withAlpha((30)),
                                  Colors.white.withAlpha((15)),
                                ],
                    ),
                    border: Border.all(
                      color: widget.node.isCompleted
                          ? const Color(0xFF00FF88)
                          : isAccessible
                              ? const Color(0xFF00FFCC)
                              : Colors.white.withAlpha((40)),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: widget.node.isCompleted
                        ? const Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 16,
                          )
                        : widget.node.isLocked
                            ? Icon(
                                Icons.lock,
                                color: Colors.white.withAlpha((80)),
                                size: 16,
                              )
                            : Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF050508),
                                ),
                              ),
                  ),
                ),
                const SizedBox(width: 12),

                // Node info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.node.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: widget.node.isCompleted
                              ? const Color(0xFF00FF88)
                              : isAccessible
                                  ? const Color(0xFF00FFCC)
                                  : Colors.white.withAlpha((120)),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.node.description,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withAlpha((100)),
                        ),
                      ),
                    ],
                  ),
                ),

                if (isAccessible)
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white.withAlpha((100)),
                    size: 18,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryMapPainter extends CustomPainter {
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
