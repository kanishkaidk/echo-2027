import 'game_state.dart';

class Achievement {
  final String id;
  final String name;
  final String description;
  final String icon;
  final Color color;
  final String category;
  final bool Function(GameMetrics) unlockedBy;

  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.category,
    required this.unlockedBy,
  });

  bool isUnlocked(GameMetrics metrics) => unlockedBy(metrics);
}

class AchievementSystem {
  static final List<Achievement> allAchievements = [
    // ===== FINANCIAL ACHIEVEMENTS =====
    Achievement(
      id: 'scrip_collector',
      name: 'SCRIP COLLECTOR',
      description: 'Accumulate 500+ credits',
      icon: '💰',
      color: const Color(0xFFFFD700),
      category: 'Financial',
      unlockedBy: (m) => m.funds >= 500,
    ),
    Achievement(
      id: 'scrip_millionaire',
      name: 'SCRIP MILLIONAIRE',
      description: 'Accumulate 1000+ credits',
      icon: '💎',
      color: const Color(0xFFFFD700),
      category: 'Financial',
      unlockedBy: (m) => m.funds >= 1000,
    ),
    Achievement(
      id: 'venture_capitalist',
      name: 'VENTURE CAPITALIST',
      description: 'Accumulate 2000+ credits',
      icon: '🏦',
      color: const Color(0xFFFFD700),
      category: 'Financial',
      unlockedBy: (m) => m.funds >= 2000,
    ),

    // ===== ENVIRONMENTAL ACHIEVEMENTS =====
    Achievement(
      id: 'eco_conscious',
      name: 'ECO CONSCIOUS',
      description: 'Achieve 50+ Eco Index',
      icon: '🌱',
      color: const Color(0xFF00FF88),
      category: 'Environmental',
      unlockedBy: (m) => m.ecoIndex >= 50,
    ),
    Achievement(
      id: 'environmental_savior',
      name: 'ENVIRONMENTAL SAVIOR',
      description: 'Achieve 80+ Eco Index',
      icon: '🌍',
      color: const Color(0xFF00FF88),
      category: 'Environmental',
      unlockedBy: (m) => m.ecoIndex >= 80,
    ),
    Achievement(
      id: 'planet_guardian',
      name: 'PLANET GUARDIAN',
      description: 'Achieve 95+ Eco Index',
      icon: '♻️',
      color: const Color(0xFF00FF88),
      category: 'Environmental',
      unlockedBy: (m) => m.ecoIndex >= 95,
    ),

    // ===== SOCIAL ACHIEVEMENTS =====
    Achievement(
      id: 'community_supporter',
      name: 'COMMUNITY SUPPORTER',
      description: 'Achieve 50+ Mutual Aid',
      icon: '🤝',
      color: const Color(0xFF00FFCC),
      category: 'Social',
      unlockedBy: (m) => m.mutualAid >= 50,
    ),
    Achievement(
      id: 'community_leader',
      name: 'COMMUNITY LEADER',
      description: 'Achieve 80+ Mutual Aid',
      icon: '👥',
      color: const Color(0xFF00FFCC),
      category: 'Social',
      unlockedBy: (m) => m.mutualAid >= 80,
    ),
    Achievement(
      id: 'resistance_icon',
      name: 'RESISTANCE ICON',
      description: 'Achieve 95+ Mutual Aid',
      icon: '🔥',
      color: const Color(0xFF00FFCC),
      category: 'Social',
      unlockedBy: (m) => m.mutualAid >= 95,
    ),

    // ===== TECHNICAL ACHIEVEMENTS =====
    Achievement(
      id: 'novice_hacker',
      name: 'NOVICE HACKER',
      description: 'Achieve 50+ Tech Aptitude',
      icon: '⚡',
      color: const Color(0xFF00D9FF),
      category: 'Technical',
      unlockedBy: (m) => m.techAptitude >= 50,
    ),
    Achievement(
      id: 'elite_netrunner',
      name: 'ELITE NETRUNNER',
      description: 'Achieve 80+ Tech Aptitude',
      icon: '💻',
      color: const Color(0xFF00D9FF),
      category: 'Technical',
      unlockedBy: (m) => m.techAptitude >= 80,
    ),
    Achievement(
      id: 'godlike_hacker',
      name: 'GODLIKE HACKER',
      description: 'Achieve 95+ Tech Aptitude',
      icon: '🤖',
      color: const Color(0xFF00D9FF),
      category: 'Technical',
      unlockedBy: (m) => m.techAptitude >= 95,
    ),

    // ===== LEADERSHIP ACHIEVEMENTS =====
    Achievement(
      id: 'emerging_leader',
      name: 'EMERGING LEADER',
      description: 'Achieve 50+ Leadership',
      icon: '👑',
      color: const Color(0xFFFFD700),
      category: 'Leadership',
      unlockedBy: (m) => m.leadership >= 50,
    ),
    Achievement(
      id: 'commanding_presence',
      name: 'COMMANDING PRESENCE',
      description: 'Achieve 80+ Leadership',
      icon: '⚔️',
      color: const Color(0xFFFFD700),
      category: 'Leadership',
      unlockedBy: (m) => m.leadership >= 80,
    ),
    Achievement(
      id: 'tactical_mastermind',
      name: 'TACTICAL MASTERMIND',
      description: 'Achieve 95+ Leadership',
      icon: '🎯',
      color: const Color(0xFFFFD700),
      category: 'Leadership',
      unlockedBy: (m) => m.leadership >= 95,
    ),

    // ===== REBELLION ACHIEVEMENTS =====
    Achievement(
      id: 'question_authority',
      name: 'QUESTION AUTHORITY',
      description: 'Achieve 50+ Rebellion Index',
      icon: '✊',
      color: const Color(0xFFFF006E),
      category: 'Rebellion',
      unlockedBy: (m) => m.rebellionIndex >= 50,
    ),
    Achievement(
      id: 'rebel_operative',
      name: 'REBEL OPERATIVE',
      description: 'Achieve 80+ Rebellion Index',
      icon: '💣',
      color: const Color(0xFFFF006E),
      category: 'Rebellion',
      unlockedBy: (m) => m.rebellionIndex >= 80,
    ),
    Achievement(
      id: 'chaos_agent',
      name: 'CHAOS AGENT',
      description: 'Achieve 95+ Rebellion Index',
      icon: '⚡',
      color: const Color(0xFFFF006E),
      category: 'Rebellion',
      unlockedBy: (m) => m.rebellionIndex >= 95,
    ),

    // ===== PROGRESSION ACHIEVEMENTS =====
    Achievement(
      id: 'first_steps',
      name: 'FIRST STEPS',
      description: 'Complete your first 5 story nodes',
      icon: '🚀',
      color: const Color(0xFF00FFCC),
      category: 'Progression',
      unlockedBy: (m) => m.totalNodesVisited >= 5,
    ),
    Achievement(
      id: 'narrative_explorer',
      name: 'NARRATIVE EXPLORER',
      description: 'Complete 20 story nodes',
      icon: '🗺️',
      color: const Color(0xFF00FFCC),
      category: 'Progression',
      unlockedBy: (m) => m.totalNodesVisited >= 20,
    ),
    Achievement(
      id: 'veteran_pathfinder',
      name: 'VETERAN PATHFINDER',
      description: 'Complete 50 story nodes',
      icon: '🧭',
      color: const Color(0xFF00FFCC),
      category: 'Progression',
      unlockedBy: (m) => m.totalNodesVisited >= 50,
    ),
    Achievement(
      id: 'narrative_master',
      name: 'NARRATIVE MASTER',
      description: 'Complete all 53 story nodes',
      icon: '📖',
      color: const Color(0xFF00FFCC),
      category: 'Progression',
      unlockedBy: (m) => m.totalNodesVisited >= 53,
    ),

    // ===== BALANCED ACHIEVEMENTS =====
    Achievement(
      id: 'renaissance_operative',
      name: 'RENAISSANCE OPERATIVE',
      description: 'Achieve 70+ in all personality traits',
      icon: '⭐',
      color: const Color(0xFFFFD700),
      category: 'Balanced',
      unlockedBy: (m) =>
          m.empathyIndex >= 70 &&
          m.techAptitude >= 70 &&
          m.leadership >= 70 &&
          m.rebellionIndex >= 70,
    ),
    Achievement(
      id: 'perfectly_balanced',
      name: 'PERFECTLY BALANCED',
      description: 'Achieve 50+ in all core metrics',
      icon: '⚖️',
      color: const Color(0xFF00FFCC),
      category: 'Balanced',
      unlockedBy: (m) =>
          m.mutualAid >= 50 &&
          m.ecoIndex >= 50 &&
          m.empathyIndex >= 50 &&
          m.techAptitude >= 50 &&
          m.leadership >= 50 &&
          m.rebellionIndex >= 50,
    ),

    // ===== EXTREME PATH ACHIEVEMENTS =====
    Achievement(
      id: 'pure_heart',
      name: 'PURE HEART',
      description: 'Achieve 80+ Empathy, below 30 Rebellion',
      icon: '💚',
      color: const Color(0xFF00FF88),
      category: 'Extreme',
      unlockedBy: (m) => m.empathyIndex >= 80 && m.rebellionIndex < 30,
    ),
    Achievement(
      id: 'cold_logic',
      name: 'COLD LOGIC',
      description: 'Achieve 80+ Tech, below 30 Empathy',
      icon: '❄️',
      color: const Color(0xFF00D9FF),
      category: 'Extreme',
      unlockedBy: (m) => m.techAptitude >= 80 && m.empathyIndex < 30,
    ),
    Achievement(
      id: 'revolutionary',
      name: 'REVOLUTIONARY',
      description: 'Achieve 80+ Rebellion Index',
      icon: '🎆',
      color: const Color(0xFFFF006E),
      category: 'Extreme',
      unlockedBy: (m) => m.rebellionIndex >= 80,
    ),
  ];

  /// Get all unlocked achievements for player
  static List<Achievement> getUnlockedAchievements(GameMetrics metrics) {
    return allAchievements.where((a) => a.isUnlocked(metrics)).toList();
  }

  /// Get achievement progress percentage
  static int getProgressPercentage(GameMetrics metrics) {
    final unlocked = getUnlockedAchievements(metrics).length;
    return ((unlocked / allAchievements.length) * 100).round();
  }

  /// Get next achievable achievement (next milestone)
  static Achievement? getNextAchievement(GameMetrics metrics) {
    return allAchievements.firstWhere(
      (a) => !a.isUnlocked(metrics),
      orElse: () => allAchievements.last,
    );
  }

  /// Get achievements by category
  static List<Achievement> getByCategory(String category, GameMetrics metrics) {
    return allAchievements
        .where((a) => a.category == category && a.isUnlocked(metrics))
        .toList();
  }
}

// Import color
import 'package:flutter/material.dart';
