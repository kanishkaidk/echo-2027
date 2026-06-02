import 'package:flutter/material.dart';

class GameMetrics {
  final int mutualAid;
  final int ecoIndex;
  final int funds;
  final int empathyIndex;
  final int techAptitude;
  final int leadership;
  final int rebellionIndex;
  final int totalNodesVisited;
  final DateTime sessionStartTime;

  GameMetrics({
    this.mutualAid = 50,
    this.ecoIndex = 30,
    this.funds = 200,
    this.empathyIndex = 40,
    this.techAptitude = 40,
    this.leadership = 40,
    this.rebellionIndex = 30,
    this.totalNodesVisited = 0,
    DateTime? sessionStartTime,
  }) : sessionStartTime = sessionStartTime ?? DateTime.now();

  GameMetrics copyWith({
    int? mutualAid,
    int? ecoIndex,
    int? funds,
    int? empathyIndex,
    int? techAptitude,
    int? leadership,
    int? rebellionIndex,
    int? totalNodesVisited,
  }) {
    return GameMetrics(
      mutualAid: mutualAid ?? this.mutualAid,
      ecoIndex: ecoIndex ?? this.ecoIndex,
      funds: funds ?? this.funds,
      empathyIndex: empathyIndex ?? this.empathyIndex,
      techAptitude: techAptitude ?? this.techAptitude,
      leadership: leadership ?? this.leadership,
      rebellionIndex: rebellionIndex ?? this.rebellionIndex,
      totalNodesVisited: totalNodesVisited ?? this.totalNodesVisited,
      sessionStartTime: sessionStartTime,
    );
  }

  GameMetrics clamp() {
    return GameMetrics(
      mutualAid: mutualAid.clamp(0, 100),
      ecoIndex: ecoIndex.clamp(0, 100),
      funds: funds,
      empathyIndex: empathyIndex.clamp(0, 100),
      techAptitude: techAptitude.clamp(0, 100),
      leadership: leadership.clamp(0, 100),
      rebellionIndex: rebellionIndex.clamp(0, 100),
      totalNodesVisited: totalNodesVisited,
      sessionStartTime: sessionStartTime,
    );
  }

  int getElapsedSeconds() {
    return DateTime.now().difference(sessionStartTime).inSeconds;
  }

  String getOperativeLevel() {
    final total = mutualAid + ecoIndex + empathyIndex + techAptitude + leadership;
    if (total > 400) return 'OMEGA OPERATIVE';
    if (total > 350) return 'TIER-7 OPERATIVE';
    if (total > 300) return 'ELITE OPERATIVE';
    if (total > 250) return 'SENIOR OPERATIVE';
    if (total > 200) return 'VETERAN';
    return 'ROOKIE';
  }
}

class GameChoice {
  final String id;
  final String text;
  final int mutualAidDelta;
  final int ecoIndexDelta;
  final int fundsDelta;
  final bool isHighStakes;
  final PersonalityDelta? personalityImpact;

  GameChoice({
    required this.id,
    required this.text,
    this.mutualAidDelta = 0,
    this.ecoIndexDelta = 0,
    this.fundsDelta = 0,
    this.isHighStakes = false,
    this.personalityImpact,
  });

  factory GameChoice.fromJson(Map<String, dynamic> json) {
    return GameChoice(
      id: json['id'] as String,
      text: json['text'] as String,
      mutualAidDelta: json['mutualAidDelta'] as int? ?? 0,
      ecoIndexDelta: json['ecoIndexDelta'] as int? ?? 0,
      fundsDelta: json['fundsDelta'] as int? ?? 0,
      isHighStakes: json['isHighStakes'] as bool? ?? false,
      personalityImpact: json['personalityImpact'] != null
          ? PersonalityDelta.fromJson(json['personalityImpact'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'mutualAidDelta': mutualAidDelta,
      'ecoIndexDelta': ecoIndexDelta,
      'fundsDelta': fundsDelta,
      'isHighStakes': isHighStakes,
      if (personalityImpact != null) 'personalityImpact': personalityImpact!.toJson(),
    };
  }
}

class PersonalityDelta {
  final int empathyDelta;
  final int techDelta;
  final int leadershipDelta;
  final int rebellionDelta;

  PersonalityDelta({
    this.empathyDelta = 0,
    this.techDelta = 0,
    this.leadershipDelta = 0,
    this.rebellionDelta = 0,
  });

  factory PersonalityDelta.fromJson(Map<String, dynamic> json) {
    return PersonalityDelta(
      empathyDelta: json['empathy'] as int? ?? 0,
      techDelta: json['tech'] as int? ?? 0,
      leadershipDelta: json['leadership'] as int? ?? 0,
      rebellionDelta: json['rebellion'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'empathy': empathyDelta,
      'tech': techDelta,
      'leadership': leadershipDelta,
      'rebellion': rebellionDelta,
    };
  }
}

class StoryNode {
  final String id;
  final String characterName;
  final String dialogueText;
  final String typewrittenText; // Animated reveal
  final String characterAvatar; // URL or asset path
  final List<GameChoice> choices;
  final Color? themeColor; // Optional node-specific color

  StoryNode({
    required this.id,
    required this.characterName,
    required this.dialogueText,
    required this.typewrittenText,
    required this.characterAvatar,
    required this.choices,
    this.themeColor,
  });

  factory StoryNode.fromJson(Map<String, dynamic> json) {
    final choicesJson = json['choices'] as List<dynamic>? ?? [];
    return StoryNode(
      id: json['id'] as String? ?? 'unknown',
      characterName: json['characterName'] as String? ?? 'Unknown',
      dialogueText: json['dialogueText'] as String? ?? '',
      typewrittenText: json['typewrittenText'] as String? ?? '',
      characterAvatar: json['characterAvatar'] as String? ?? 'assets/avatar_default.png',
      choices: choicesJson
          .map((c) => GameChoice.fromJson(c as Map<String, dynamic>))
          .toList(),
      themeColor: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'characterName': characterName,
      'dialogueText': dialogueText,
      'typewrittenText': typewrittenText,
      'characterAvatar': characterAvatar,
      'choices': choices.map((c) => c.toJson()).toList(),
    };
  }
}
