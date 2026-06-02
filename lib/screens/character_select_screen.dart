import 'package:flutter/material.dart';
import '../models/game_state.dart';

class CharacterSelectScreen extends StatefulWidget {
  final Function(String, GameMetrics) onCharacterSelected;

  const CharacterSelectScreen({
    super.key,
    required this.onCharacterSelected,
  });

  @override
  State<CharacterSelectScreen> createState() => _CharacterSelectScreenState();
}

class _OperativeClass {
  final String name;
  final String description;
  final GameMetrics startingMetrics;
  final Color accentColor;
  final String role;

  _OperativeClass({
    required this.name,
    required this.description,
    required this.startingMetrics,
    required this.accentColor,
    required this.role,
  });
}

class _CharacterSelectScreenState extends State<CharacterSelectScreen> {
  late TextEditingController _nameController;
  _OperativeClass? _selectedClass;

  final List<_OperativeClass> _operatives = [
    _OperativeClass(
      name: 'NETRUNNER',
      role: 'Digital Infiltrator',
      description: 'Master of encrypted networks and data protocols',
      startingMetrics: GameMetrics(
        mutualAid: 40,
        ecoIndex: 20,
        funds: 400,
        techAptitude: 85,
        empathyIndex: 30,
        leadership: 35,
        rebellionIndex: 60,
      ),
      accentColor: const Color(0xFF00FFCC),
    ),
    _OperativeClass(
      name: 'STREET FIXER',
      role: 'Resource Coordinator',
      description: 'Connects people and resources through underground networks',
      startingMetrics: GameMetrics(
        mutualAid: 75,
        ecoIndex: 35,
        funds: 600,
        techAptitude: 50,
        empathyIndex: 70,
        leadership: 80,
        rebellionIndex: 40,
      ),
      accentColor: const Color(0xFFFFD700),
    ),
    _OperativeClass(
      name: 'ECO-INFILTRATOR',
      role: 'Environmental Saboteur',
      description: 'Specialized in restoration and ecological intervention',
      startingMetrics: GameMetrics(
        mutualAid: 65,
        ecoIndex: 95,
        funds: 250,
        techAptitude: 40,
        empathyIndex: 90,
        leadership: 45,
        rebellionIndex: 70,
      ),
      accentColor: const Color(0xFF00FF88),
    ),
  ];

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

  void _selectCharacter() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter codename and select operative class'),
          backgroundColor: Color(0xFFFF006E),
        ),
      );
      return;
    }
    widget.onCharacterSelected(name, _selectedClass!.startingMetrics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OPERATIVE REGISTRATION',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 28,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '[SELECT CLASS & CODENAME]',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF00FFCC),
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
              ),
              const SizedBox(height: 40),
              Text(
                'Choose your operative class:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                    ),
              ),
              const SizedBox(height: 20),
              Column(
                children: _operatives.map((operative) {
                  final isSelected = _selectedClass == operative;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _ClassCard(
                      operative: operative,
                      isSelected: isSelected,
                      onTap: () => setState(() => _selectedClass = operative),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'OPERATIVE CODENAME',
                  labelStyle: const TextStyle(
                    color: Color(0xFF00FFCC),
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                  hintText: 'Enter your alias',
                  hintStyle: TextStyle(
                    color: Colors.white.withAlpha((75)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Color(0xFF00FFCC),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Color(0xFF00FFCC),
                      width: 2.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: _BootButton(
                  label: 'DEPLOY OPERATIVE',
                  onPressed: _selectCharacter,
                  accentColor: _selectedClass?.accentColor ?? const Color(0xFF00FFCC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClassCard extends StatefulWidget {
  final _OperativeClass operative;
  final bool isSelected;
  final VoidCallback onTap;

  const _ClassCard({
    required this.operative,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<_ClassCard>
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
        onTap: () {
          widget.onTap();
          _hoverController.forward();
        },
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.02)
              .animate(_hoverController),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isSelected
                    ? [
                        widget.operative.accentColor.withAlpha((30)),
                        widget.operative.accentColor.withAlpha((10)),
                      ]
                    : [
                        Colors.white.withAlpha((5)),
                        Colors.white.withAlpha((2)),
                      ],
              ),
              border: Border.all(
                color: widget.isSelected
                    ? widget.operative.accentColor
                    : Colors.white.withAlpha((30)),
                width: widget.isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                        color: widget.operative.accentColor
                            .withAlpha((80)),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.operative.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: widget.operative.accentColor,
                        letterSpacing: 2,
                      ),
                    ),
                    const Spacer(),
                    if (widget.isSelected)
                      Icon(
                        Icons.check_circle,
                        color: widget.operative.accentColor,
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.operative.role,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withAlpha((150)),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.operative.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha((180)),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                _StatBar(
                  label: 'TECH APTITUDE',
                  value: widget.operative.startingMetrics.techAptitude,
                  color: const Color(0xFF00FFCC),
                ),
                const SizedBox(height: 8),
                _StatBar(
                  label: 'LEADERSHIP',
                  value: widget.operative.startingMetrics.leadership,
                  color: widget.operative.accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatBar({
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
                fontSize: 10,
                color: Colors.white.withAlpha((120)),
                letterSpacing: 1,
              ),
            ),
            Text(
              '$value/100',
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 4,
            backgroundColor: Colors.white.withAlpha((30)),
            valueColor: AlwaysStoppedAnimation(color.withAlpha((200))),
          ),
        ),
      ],
    );
  }
}

class _BootButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color accentColor;

  const _BootButton({
    required this.label,
    required this.onPressed,
    required this.accentColor,
  });

  @override
  State<_BootButton> createState() => _BootButtonState();
}

class _BootButtonState extends State<_BootButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.05)
              .animate(_controller),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.accentColor,
                  widget.accentColor.withAlpha((200)),
                ],
              ),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: widget.accentColor.withAlpha((100)),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              widget.label,
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
      ),
    );
  }
}
