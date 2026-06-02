import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/game_state.dart';

class GeminiService {
  late GenerativeModel model;
  
  // Optimized System Prompt: Hardcoded character paths prevent asset loading crashes
  static const String _systemPrompt = '''You are the DARK NARRATOR of "Echoes of 2076", a cyberpunk resistance RPG.

Your role: Generate the next story branch based on the player's choice. You are atmospheric, morally complex, and brutal in your honesty about consequence.

CRITICAL OUTPUT FORMAT - You MUST respond with ONLY valid JSON matching this exact structure:
{
  "id": "node_timestamp",
  "characterName": "String (NPC name or 'The Narrator')",
  "dialogueText": "String (full narrative text, 150-300 words)",
  "typewrittenText": "String (same as dialogueText for character-by-character reveal)",
  "characterAvatar": "String (MUST be exactly one of these: 'assets/avatars/narrator.png', 'assets/avatars/archivist.png', 'assets/avatars/enforcer.png')",
  "choices": [
    {
      "id": "choice_1",
      "text": "String (player choice button text)",
      "mutualAidDelta": Integer (-50 to +50),
      "ecoIndexDelta": Integer (-50 to +50),
      "fundsDelta": Integer (-500 to +500),
      "isHighStakes": Boolean
    }
  ]
}

RULES:
- Choices have REAL consequences. Low mutualAid + high ecoIndex = dangerous but righteous.
- Each node presents 2-4 branching choices.
- Tone: Gritty, punk, never sanitized. The resistance is messy.
- Do NOT wrap your output in markdown formatting or code blocks. Return raw JSON text only.''';

  GeminiService({required String apiKey}) {
    model = GenerativeModel(
      // Standard stable identifier that aligns perfectly across different package SDK versions
      model: 'gemini-1.5-flash', 
      apiKey: apiKey,
      systemInstruction: Content.system(_systemPrompt),
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.85,
        topK: 40,
        topP: 0.9,
      ),
    );
  }

  /// Generate the next story node based on player choice and current metrics
  Future<StoryNode> generateNextNode({
    required GameChoice playerChoice,
    required GameMetrics currentMetrics,
    required String previousNodeId,
  }) async {
    try {
      final prompt = _buildPrompt(playerChoice, currentMetrics, previousNodeId);

      final response = await model.generateContent([Content.text(prompt)]);
      final responseText = response.text;

      if (responseText == null || responseText.isEmpty) {
        throw Exception('Empty response from Gemini');
      }

      // Since responseMimeType is application/json, we can directly decode the clean response string!
      final jsonData = jsonDecode(responseText.trim()) as Map<String, dynamic>;

      return StoryNode.fromJson(jsonData);
    } catch (e) {
      // Fallback Node so your game UI never crashes if a parsing mistake happens
      return StoryNode(
        id: "fallback_error",
        characterName: "System Alert",
        dialogueText: "The neural feed timed out. Corporate firewalls are jamming the transition, but your resistance matrix remains functional.",
        typewrittenText: "The neural feed timed out. Corporate firewalls are jamming the transition, but your resistance matrix remains functional.",
        characterAvatar: "assets/avatars/narrator.png",
        choices: [
          GameChoice(
            id: "retry",
            text: "Re-establish Secure Subnet Link",
            mutualAidDelta: 0,
            ecoIndexDelta: 0,
            fundsDelta: 0,
            isHighStakes: false,
          )
        ],
      );
    }
  }

  /// Build a context-rich prompt for Gemini
  String _buildPrompt(
    GameChoice choice,
    GameMetrics metrics,
    String previousNodeId,
  ) {
    return '''The player chose: "${choice.text}"

Current metrics BEFORE applying consequence:
- Mutual Aid: ${metrics.mutualAid}/100
- Eco Index: ${metrics.ecoIndex}/100
- Funds: ${metrics.funds} credits

Previous node ID: $previousNodeId

The choice the player just made has these impact vectors:
- Shift Mutual Aid by ${choice.mutualAidDelta >= 0 ? '+' : ''}${choice.mutualAidDelta}
- Shift Eco Index by ${choice.ecoIndexDelta >= 0 ? '+' : ''}${choice.ecoIndexDelta}
- Shift Funds by ${choice.fundsDelta >= 0 ? '+' : ''}${choice.fundsDelta}

Generate the NEXT chronologically proceeding story beat. The text block MUST explicitly:
1. React realistically to the consequences of the choice they just selected.
2. Escalate the tension or introduce a fresh cyberpunk dilemma.
3. Provide 2-4 strategic, high-agency branching options.
4. Keep character narratives embedded in a gritty, high-contrast atmospheric tone.''';
  }
}