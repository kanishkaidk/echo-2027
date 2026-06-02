// Core game state model
class GameState {
  String playerName;
  int communityTrust; // 0-100
  int ecoRestoration; // 0-100
  int funds;
  String currentNodeId;

  GameState({
    this.playerName = 'Citizen',
    this.communityTrust = 50,
    this.ecoRestoration = 30,
    this.funds = 100,
    this.currentNodeId = 'intro',
  });

  // Apply state deltas from a choice
  void applyModifiers(StateModifiers modifiers) {
    communityTrust = (communityTrust + modifiers.trustDelta).clamp(0, 100);
    ecoRestoration = (ecoRestoration + modifiers.ecoDelta).clamp(0, 100);
    funds = (funds + modifiers.fundsDelta).clamp(0, 9999);
  }

  GameState copyWith({
    String? playerName,
    int? communityTrust,
    int? ecoRestoration,
    int? funds,
    String? currentNodeId,
  }) {
    return GameState(
      playerName: playerName ?? this.playerName,
      communityTrust: communityTrust ?? this.communityTrust,
      ecoRestoration: ecoRestoration ?? this.ecoRestoration,
      funds: funds ?? this.funds,
      currentNodeId: currentNodeId ?? this.currentNodeId,
    );
  }
}

// Modifiers applied when a choice is selected
class StateModifiers {
  final int trustDelta;
  final int ecoDelta;
  final int fundsDelta;

  StateModifiers({
    this.trustDelta = 0,
    this.ecoDelta = 0,
    this.fundsDelta = 0,
  });
}

// A single narrative choice
class Choice {
  final String text;
  final String nextNodeId;
  final StateModifiers modifiers;
  final bool isHighStakes; // Determines UI color (crimson if true)

  Choice({
    required this.text,
    required this.nextNodeId,
    StateModifiers? modifiers,
    this.isHighStakes = false,
  }) : modifiers = modifiers ?? StateModifiers();
}

// A narrative node in the story graph
class StoryNode {
  final String id;
  final String title;
  final String text;
  final String backgroundImageUrl; // Placeholder URL for now
  final List<Choice> choices;
  final bool isFinal; // Marks end-of-branch nodes

  StoryNode({
    required this.id,
    required this.title,
    required this.text,
    this.backgroundImageUrl = 'assets/bg_default.jpg',
    required this.choices,
    this.isFinal = false,
  });
}
