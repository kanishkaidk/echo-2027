import 'package:flutter/material.dart';

class GameMetrics {
  final int mutualAid; // Community trust (0-100)
  final int ecoIndex; // Environmental restoration (0-100)
  final int funds; // Credits available (0-∞)

  GameMetrics({
    this.mutualAid = 50,
    this.ecoIndex = 30,
    this.funds = 200,
  });

  GameMetrics copyWith({
    int? mutualAid,
    int? ecoIndex,
    int? funds,
  }) {
    return GameMetrics(
      mutualAid: mutualAid ?? this.mutualAid,
      ecoIndex: ecoIndex ?? this.ecoIndex,
      funds: funds ?? this.funds,
    );
  }

  // Clamp metrics to 0-100 range
  GameMetrics clamp() {
    return GameMetrics(
      mutualAid: mutualAid.clamp(0, 100),
      ecoIndex: ecoIndex.clamp(0, 100),
      funds: funds,
    );
  }
}

class GameChoice {
  final String id;
  final String text;
  final int mutualAidDelta;
  final int ecoIndexDelta;
  final int fundsDelta;
  final bool isHighStakes; // Determines visual styling

  GameChoice({
    required this.id,
    required this.text,
    this.mutualAidDelta = 0,
    this.ecoIndexDelta = 0,
    this.fundsDelta = 0,
    this.isHighStakes = false,
  });

  factory GameChoice.fromJson(Map<String, dynamic> json) {
    return GameChoice(
      id: json['id'] as String,
      text: json['text'] as String,
      mutualAidDelta: json['mutualAidDelta'] as int? ?? 0,
      ecoIndexDelta: json['ecoIndexDelta'] as int? ?? 0,
      fundsDelta: json['fundsDelta'] as int? ?? 0,
      isHighStakes: json['isHighStakes'] as bool? ?? false,
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
