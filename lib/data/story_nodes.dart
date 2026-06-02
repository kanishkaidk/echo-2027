import '../models/game_state.dart';

class StoryNodeDatabase {
  static final Map<String, StoryNode> nodes = {
    // ===== ACT I: THE LOWER HAB-DECKS =====
    // Chapter 1: The Air Scrubber Breach (Nodes 1-10)

    'node_001_intro': StoryNode(
      id: 'node_001_intro',
      characterName: 'The Ghost Matrix',
      dialogueText:
          'Welcome back, Operative. The atmospheric acid levels have spiked 40% in the past 72 hours. Corporate overrides have locked the oxygen scrubbers behind premium credit walls. Below the neon spires, our underground resistance struggles to sustain breath. A decryption pulse has intercepted new corporate blueprints. What do you do?',
      typewrittenText:
          'Welcome back, Operative. The atmospheric acid levels have spiked 40% in the past 72 hours. Corporate overrides have locked the oxygen scrubbers behind premium credit walls. Below the neon spires, our underground resistance struggles to sustain breath. A decryption pulse has intercepted new corporate blueprints. What do you do?',
      characterAvatar: 'assets/avatars/ghost_matrix.png',
      choices: [
        GameChoice(
          id: 'choice_001_reroute',
          text: '[EXECUTE] Reroute generator matrices to power public hydroponic bays',
          mutualAidDelta: 20,
          ecoIndexDelta: 15,
          fundsDelta: -150,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 15,
            techDelta: 10,
            leadershipDelta: 12,
            rebellionDelta: 5,
          ),
        ),
        GameChoice(
          id: 'choice_001_sell',
          text:
              '[PROFIT MOTIVE] Sell the encryption bypasses to an autonomous broker',
          mutualAidDelta: -25,
          ecoIndexDelta: -10,
          fundsDelta: 400,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: -15,
            techDelta: 20,
            leadershipDelta: -10,
            rebellionDelta: 15,
          ),
        ),
        GameChoice(
          id: 'choice_001_hybrid',
          text: '[CALCULATED] Reroute partial power, keep some encryption for yourself',
          mutualAidDelta: 8,
          ecoIndexDelta: 8,
          fundsDelta: 150,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 15,
            leadershipDelta: 8,
            rebellionDelta: 12,
          ),
        ),
      ],
    ),

    'node_002_breach_aftermath': StoryNode(
      id: 'node_002_breach_aftermath',
      characterName: 'ECHO-7 [Resistance Coordinator]',
      dialogueText:
          'Your decision created ripples. The scrubbers are now online in Sector 7, but Enforcement is tracking the power surge. We have 8 hours before they converge on the junction. Do we bunker down and defend, scatter and hide, or push forward with a counter-offensive?',
      typewrittenText:
          'Your decision created ripples. The scrubbers are now online in Sector 7, but Enforcement is tracking the power surge. We have 8 hours before they converge on the junction. Do we bunker down and defend, scatter and hide, or push forward with a counter-offensive?',
      characterAvatar: 'assets/avatars/echo7.png',
      choices: [
        GameChoice(
          id: 'choice_002_defend',
          text: '[FORTIFY] Prepare defensive positions at the junction',
          mutualAidDelta: 15,
          ecoIndexDelta: 0,
          fundsDelta: -200,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 10,
            techDelta: 5,
            leadershipDelta: 20,
            rebellionDelta: 15,
          ),
        ),
        GameChoice(
          id: 'choice_002_scatter',
          text: '[DISPERSE] Melt into the city, regroup in safe houses',
          mutualAidDelta: 5,
          ecoIndexDelta: 0,
          fundsDelta: -50,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: -5,
            techDelta: 10,
            leadershipDelta: 0,
            rebellionDelta: 10,
          ),
        ),
        GameChoice(
          id: 'choice_002_counter',
          text: '[STRIKE BACK] Launch a coordinated counter-strike on Enforcement hub',
          mutualAidDelta: 25,
          ecoIndexDelta: -5,
          fundsDelta: 0,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 8,
            techDelta: 18,
            leadershipDelta: 25,
            rebellionDelta: 30,
          ),
        ),
      ],
    ),

    'node_003_market_connection': StoryNode(
      id: 'node_003_market_connection',
      characterName: 'KAEL [Black Market Broker]',
      dialogueText:
          'I heard about the scrubber play. Impressive. Listen, your movement needs resources. I can supply medical kits, encrypted comms, even military-grade decryption tools. But every purchase marks you in the corporate ledgers. How deep do you want to go into debt?',
      typewrittenText:
          'I heard about the scrubber play. Impressive. Listen, your movement needs resources. I can supply medical kits, encrypted comms, even military-grade decryption tools. But every purchase marks you in the corporate ledgers. How deep do you want to go into debt?',
      characterAvatar: 'assets/avatars/kael.png',
      choices: [
        GameChoice(
          id: 'choice_003_full_load',
          text: '[FULL ARSENAL] Buy everything - we need to be ready',
          mutualAidDelta: 10,
          ecoIndexDelta: 0,
          fundsDelta: -300,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 8,
            techDelta: 20,
            leadershipDelta: 15,
            rebellionDelta: 18,
          ),
        ),
        GameChoice(
          id: 'choice_003_minimal',
          text: '[SELECTIVE] Only critical supplies - stay below the radar',
          mutualAidDelta: 5,
          ecoIndexDelta: 5,
          fundsDelta: -100,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 10,
            leadershipDelta: 8,
            rebellionDelta: 8,
          ),
        ),
        GameChoice(
          id: 'choice_003_barter',
          text: '[TRADE] Offer information instead of credits - intel for tools',
          mutualAidDelta: 0,
          ecoIndexDelta: 0,
          fundsDelta: 50,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 15,
            leadershipDelta: 10,
            rebellionDelta: 12,
          ),
        ),
      ],
    ),

    // Nodes 4-10 continue the Chapter 1 narrative
    'node_004_faction_pressure': StoryNode(
      id: 'node_004_faction_pressure',
      characterName: 'SISTER MAIA [Mutual Aid Cell Leader]',
      dialogueText:
          'The outer districts are celebrating the scrubber victory, but it\'s fragile. We\'re getting pressure from rival factions wanting credit. Do we share resources with them, consolidate power, or operate independently?',
      typewrittenText:
          'The outer districts are celebrating the scrubber victory, but it\'s fragile. We\'re getting pressure from rival factions wanting credit. Do we share resources with them, consolidate power, or operate independently?',
      characterAvatar: 'assets/avatars/sister_maia.png',
      choices: [
        GameChoice(
          id: 'choice_004_share',
          text: '[COALITION] Form a unified resistance front with all factions',
          mutualAidDelta: 35,
          ecoIndexDelta: 10,
          fundsDelta: -100,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 20,
            techDelta: 5,
            leadershipDelta: 25,
            rebellionDelta: 10,
          ),
        ),
        GameChoice(
          id: 'choice_004_consolidate',
          text: '[DOMINANCE] Absorb rival factions\' members into our movement',
          mutualAidDelta: 10,
          ecoIndexDelta: 0,
          fundsDelta: 200,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: -10,
            techDelta: 10,
            leadershipDelta: 20,
            rebellionDelta: 25,
          ),
        ),
        GameChoice(
          id: 'choice_004_independent',
          text: '[ISOLATION] Maintain autonomy, no entangling alliances',
          mutualAidDelta: 0,
          ecoIndexDelta: 5,
          fundsDelta: 0,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 12,
            leadershipDelta: 8,
            rebellionDelta: 15,
          ),
        ),
      ],
    ),

    'node_005_eco_crisis': StoryNode(
      id: 'node_005_eco_crisis',
      characterName: 'DR. XAVIER [Environmental Scientist]',
      dialogueText:
          'The scrubber victory bought us time, but the real crisis is the aquifer. It\'s contaminated with industrial waste. Remediation costs 500 credits and months of work. We can attempt it, ignore it, or weaponize the pollution as a bargaining chip.',
      typewrittenText:
          'The scrubber victory bought us time, but the real crisis is the aquifer. It\'s contaminated with industrial waste. Remediation costs 500 credits and months of work. We can attempt it, ignore it, or weaponize the pollution as a bargaining chip.',
      characterAvatar: 'assets/avatars/dr_xavier.png',
      choices: [
        GameChoice(
          id: 'choice_005_remediate',
          text: '[RESTORE] Fund full aquifer restoration - the planet comes first',
          mutualAidDelta: 20,
          ecoIndexDelta: 40,
          fundsDelta: -500,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 25,
            techDelta: 15,
            leadershipDelta: 10,
            rebellionDelta: 5,
          ),
        ),
        GameChoice(
          id: 'choice_005_leverage',
          text: '[LEVERAGE] Use contamination as blackmail against corporates',
          mutualAidDelta: -10,
          ecoIndexDelta: -20,
          fundsDelta: 300,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: -15,
            techDelta: 18,
            leadershipDelta: 15,
            rebellionDelta: 30,
          ),
        ),
        GameChoice(
          id: 'choice_005_temporary',
          text: '[PATCH] Deploy temporary filtration, save funds for later',
          mutualAidDelta: 5,
          ecoIndexDelta: 15,
          fundsDelta: -150,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 10,
            techDelta: 12,
            leadershipDelta: 10,
            rebellionDelta: 10,
          ),
        ),
      ],
    ),

    // Continue with nodes 6-10 for Chapter 1
    'node_006_enforcement_intel': StoryNode(
      id: 'node_006_enforcement_intel',
      characterName: 'CIPHER [Hacker Collective]',
      dialogueText:
          'We\'ve intercepted Enforcement communications. They\'re planning a sweep of Lower Hab-Deck 7. Three possible responses: evacuate civilians and avoid conflict, set up an ambush to damage their forces, or hack their communications to create false leads.',
      typewrittenText:
          'We\'ve intercepted Enforcement communications. They\'re planning a sweep of Lower Hab-Deck 7. Three possible responses: evacuate civilians and avoid conflict, set up an ambush to damage their forces, or hack their communications to create false leads.',
      characterAvatar: 'assets/avatars/cipher.png',
      choices: [
        GameChoice(
          id: 'choice_006_evacuate',
          text: '[PROTECT] Organize mass evacuation to safe zones',
          mutualAidDelta: 30,
          ecoIndexDelta: 0,
          fundsDelta: -200,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 25,
            techDelta: 8,
            leadershipDelta: 22,
            rebellionDelta: 5,
          ),
        ),
        GameChoice(
          id: 'choice_006_ambush',
          text: '[COMBAT] Prepare tactical ambush - strike them first',
          mutualAidDelta: 10,
          ecoIndexDelta: -5,
          fundsDelta: 0,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 12,
            leadershipDelta: 20,
            rebellionDelta: 30,
          ),
        ),
        GameChoice(
          id: 'choice_006_hack',
          text: '[DECEPTION] Corrupt their comms, send false intelligence',
          mutualAidDelta: 5,
          ecoIndexDelta: 0,
          fundsDelta: 100,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 10,
            techDelta: 25,
            leadershipDelta: 10,
            rebellionDelta: 20,
          ),
        ),
      ],
    ),

    'node_007_supply_shortage': StoryNode(
      id: 'node_007_supply_shortage',
      characterName: 'LOGISTICS TEAM [Supply Chain]',
      dialogueText:
          'Our medical supplies are depleted. We can raid a corporate depot (risky), negotiate with black market distributors (expensive), or implement ration protocols (unpopular but sustainable).',
      typewrittenText:
          'Our medical supplies are depleted. We can raid a corporate depot (risky), negotiate with black market distributors (expensive), or implement ration protocols (unpopular but sustainable).',
      characterAvatar: 'assets/avatars/logistics.png',
      choices: [
        GameChoice(
          id: 'choice_007_raid',
          text: '[AGGRESSIVE] Launch a raid on the corporate medical depot',
          mutualAidDelta: 15,
          ecoIndexDelta: -5,
          fundsDelta: 150,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 12,
            techDelta: 15,
            leadershipDelta: 18,
            rebellionDelta: 28,
          ),
        ),
        GameChoice(
          id: 'choice_007_negotiate',
          text: '[COMMERCE] Pay black market prices for full resupply',
          mutualAidDelta: 5,
          ecoIndexDelta: 0,
          fundsDelta: -350,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 10,
            leadershipDelta: 8,
            rebellionDelta: 8,
          ),
        ),
        GameChoice(
          id: 'choice_007_ration',
          text: '[DISCIPLINE] Implement strict rationing, maintain morale through unity',
          mutualAidDelta: 10,
          ecoIndexDelta: 5,
          fundsDelta: 0,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 15,
            techDelta: 5,
            leadershipDelta: 15,
            rebellionDelta: 10,
          ),
        ),
      ],
    ),

    'node_008_reputation_test': StoryNode(
      id: 'node_008_reputation_test',
      characterName: 'STREET COUNCIL [Underground Govs]',
      dialogueText:
          'Word of your actions has spread. The street council is testing your commitment. They\'re offering three contracts: help a civilian resistance cell, protect a data cache, or eliminate a corporate informant.',
      typewrittenText:
          'Word of your actions has spread. The street council is testing your commitment. They\'re offering three contracts: help a civilian resistance cell, protect a data cache, or eliminate a corporate informant.',
      characterAvatar: 'assets/avatars/street_council.png',
      choices: [
        GameChoice(
          id: 'choice_008_protect_civilians',
          text: '[SOLIDARITY] Assist the civilian resistance cell with resources',
          mutualAidDelta: 25,
          ecoIndexDelta: 5,
          fundsDelta: -100,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 20,
            techDelta: 5,
            leadershipDelta: 18,
            rebellionDelta: 12,
          ),
        ),
        GameChoice(
          id: 'choice_008_data_cache',
          text: '[KNOWLEDGE] Secure the data cache - information is power',
          mutualAidDelta: 5,
          ecoIndexDelta: 0,
          fundsDelta: 200,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 8,
            techDelta: 20,
            leadershipDelta: 10,
            rebellionDelta: 15,
          ),
        ),
        GameChoice(
          id: 'choice_008_eliminate',
          text: '[RUTHLESS] Eliminate the informant - send a message',
          mutualAidDelta: -20,
          ecoIndexDelta: 0,
          fundsDelta: 250,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: -20,
            techDelta: 10,
            leadershipDelta: 15,
            rebellionDelta: 35,
          ),
        ),
      ],
    ),

    'node_009_chapter_climax': StoryNode(
      id: 'node_009_chapter_climax',
      characterName: 'THE PHANTOM [Unknown Contact]',
      dialogueText:
          'Corporate is mobilizing. They\'re launching Operation Cleanse to neutralize the entire Lower Deck resistance. We have one shot: escape, fight, or attempt a desperate negotiation with their leadership.',
      typewrittenText:
          'Corporate is mobilizing. They\'re launching Operation Cleanse to neutralize the entire Lower Deck resistance. We have one shot: escape, fight, or attempt a desperate negotiation with their leadership.',
      characterAvatar: 'assets/avatars/phantom.png',
      choices: [
        GameChoice(
          id: 'choice_009_escape',
          text: '[RETREAT] Evacuate to the Mid-Tier Spire, live to fight another day',
          mutualAidDelta: 10,
          ecoIndexDelta: 0,
          fundsDelta: -150,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 12,
            techDelta: 8,
            leadershipDelta: 12,
            rebellionDelta: 8,
          ),
        ),
        GameChoice(
          id: 'choice_009_fight',
          text: '[DEFIANCE] Make a final stand - become a symbol of resistance',
          mutualAidDelta: 30,
          ecoIndexDelta: 0,
          fundsDelta: 0,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 20,
            techDelta: 10,
            leadershipDelta: 30,
            rebellionDelta: 35,
          ),
        ),
        GameChoice(
          id: 'choice_009_negotiate',
          text: '[DIPLOMACY] Seek a ceasefire - corporate might listen to reason',
          mutualAidDelta: 5,
          ecoIndexDelta: 5,
          fundsDelta: 100,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 15,
            techDelta: 12,
            leadershipDelta: 20,
            rebellionDelta: 5,
          ),
        ),
      ],
    ),

    'node_010_chapter_conclusion': StoryNode(
      id: 'node_010_chapter_conclusion',
      characterName: 'ECHO-7 [Resistance Coordinator]',
      dialogueText:
          'Chapter One concludes. Your actions in the Lower Hab-Decks have marked you. Whether you escaped, fought, or negotiated, the corporate world knows your name now. The Mid-Tier Spire awaits. New challenges. New alliances. Are you ready?',
      typewrittenText:
          'Chapter One concludes. Your actions in the Lower Hab-Decks have marked you. Whether you escaped, fought, or negotiated, the corporate world knows your name now. The Mid-Tier Spire awaits. New challenges. New alliances. Are you ready?',
      characterAvatar: 'assets/avatars/echo7.png',
      choices: [
        GameChoice(
          id: 'choice_010_advance',
          text: '[PROCEED] Enter Act II - The Mid-Tier Spire Infrastructure',
          mutualAidDelta: 0,
          ecoIndexDelta: 0,
          fundsDelta: 0,
          isHighStakes: false,
        ),
      ],
    ),

    // ===== ACT II: THE MID-TIER SPIRE (Nodes 11-25) =====
    'node_011_spire_arrival': StoryNode(
      id: 'node_011_spire_arrival',
      characterName: 'ATLAS [Spire Syndicate Leader]',
      dialogueText:
          'Welcome to the Mid-Tier. Your reputation precedes you. The Spire is where resources flow, data is currency, and every contract has a price. We\'re planning something massive: the Data Center Heist. Corporate stores their most valuable assets in Vault-7. Are you in?',
      typewrittenText:
          'Welcome to the Mid-Tier. Your reputation precedes you. The Spire is where resources flow, data is currency, and every contract has a price. We\'re planning something massive: the Data Center Heist. Corporate stores their most valuable assets in Vault-7. Are you in?',
      characterAvatar: 'assets/avatars/atlas.png',
      choices: [
        GameChoice(
          id: 'choice_011_accept',
          text: '[COMMITMENT] Yes - I\'m ready to hit Vault-7',
          mutualAidDelta: 10,
          ecoIndexDelta: 0,
          fundsDelta: -100,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 15,
            leadershipDelta: 12,
            rebellionDelta: 20,
          ),
        ),
        GameChoice(
          id: 'choice_011_decline',
          text: '[CAUTION] Not yet - I need more intel on Vault-7',
          mutualAidDelta: 0,
          ecoIndexDelta: 0,
          fundsDelta: 0,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 12,
            leadershipDelta: 8,
            rebellionDelta: 10,
          ),
        ),
        GameChoice(
          id: 'choice_011_negotiate',
          text: '[LEVERAGE] Help me establish myself first, then we\'ll discuss terms',
          mutualAidDelta: 5,
          ecoIndexDelta: 0,
          fundsDelta: 50,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 8,
            techDelta: 15,
            leadershipDelta: 15,
            rebellionDelta: 12,
          ),
        ),
      ],
    ),

    // Continue with nodes 12-25 for Act II...
    'node_012_vault_preparation': StoryNode(
      id: 'node_012_vault_preparation',
      characterName: 'TECH SPECIALIST [Heist Team]',
      dialogueText:
          'The vault has triple-redundant security systems. We need either: a hacker to break the encryption, a specialist to bypass physical locks, or someone to infiltrate from inside corporate. Which approach resonates with you?',
      typewrittenText:
          'The vault has triple-redundant security systems. We need either: a hacker to break the encryption, a specialist to bypass physical locks, or someone to infiltrate from inside corporate. Which approach resonates with you?',
      characterAvatar: 'assets/avatars/tech_specialist.png',
      choices: [
        GameChoice(
          id: 'choice_012_hacker',
          text: '[DIGITAL] Recruit elite hackers to break encryption systems',
          mutualAidDelta: 5,
          ecoIndexDelta: 0,
          fundsDelta: -200,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 25,
            leadershipDelta: 10,
            rebellionDelta: 15,
          ),
        ),
        GameChoice(
          id: 'choice_012_physical',
          text: '[MECHANICAL] Hire a master locksmith and safecracker',
          mutualAidDelta: 0,
          ecoIndexDelta: 0,
          fundsDelta: -250,
          isHighStakes: false,
          personalityImpact: PersonalityDelta(
            empathyDelta: 5,
            techDelta: 15,
            leadershipDelta: 12,
            rebellionDelta: 12,
          ),
        ),
        GameChoice(
          id: 'choice_012_infiltrate',
          text: '[SOCIAL] Turn a corporate employee - get inside access',
          mutualAidDelta: 10,
          ecoIndexDelta: 0,
          fundsDelta: -150,
          isHighStakes: true,
          personalityImpact: PersonalityDelta(
            empathyDelta: 12,
            techDelta: 10,
            leadershipDelta: 15,
            rebellionDelta: 18,
          ),
        ),
      ],
    ),

    // Nodes 13-25 continue the Act II narrative and build toward the climax
    // (abbreviated for space - in production these would each be fully developed)
  };

  /// Get a story node by ID
  static StoryNode? getNode(String id) => nodes[id];

  /// Get all nodes in an act
  static List<StoryNode> getActNodes(int act) {
    final prefix = act == 1
        ? 'node_00'
        : act == 2
            ? 'node_01'
            : 'node_02';
    return nodes.values
        .where((node) => node.id.startsWith(prefix))
        .toList();
  }
}
