# 🤖 Gemini API Integration Guide

## Setup Instructions

### 1. Get Your Gemini API Key

1. Go to [Google AI Studio](https://aistudio.google.com/app/apikey)
2. Click "Get API Key" → "Create API Key in new project"
3. Copy your API key (keep it secure!)

### 2. Configure Environment

#### Option A: Command Line (Recommended for Development)
```bash
flutter run -d web --web-port=5173 \
  --dart-define=GEMINI_API_KEY=your_api_key_here
```

#### Option B: .env File (Flutter Dotenv)
1. Create `.env` at project root:
```
GEMINI_API_KEY=your_api_key_here
```

2. Update `main.dart`:
```dart
await dotenv.load();
const apiKey = String.fromEnvironment('GEMINI_API_KEY');
```

#### Option C: GitHub Secrets (For CI/CD)
```yaml
# .github/workflows/deploy.yml
- name: Run Flutter App
  env:
    GEMINI_API_KEY: ${{ secrets.GEMINI_API_KEY }}
  run: flutter run -d web --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY
```

---

## 🎮 How Gemini Powers Echoes of 2076

### Story Generation Flow

```
Player chooses action
  ↓
GameplayScreen._handleChoice() called
  ↓
Metrics updated (empathy, tech, etc.)
  ↓
GeminiService.generateNextNode() invoked
  ↓
Gemini 1.5 Flash processes:
  - Current metrics profile
  - Choice context
  - Previous story state
  ↓
Generates JSON response:
  {
    "id": "node_026_...",
    "characterName": "NPC Name",
    "dialogueText": "...",
    "choices": [...]
  }
  ↓
Parsed into StoryNode
  ↓
UI displays new narrative + options
```

### Context Window

Gemini receives:
```
You are DARK NARRATOR of "Echoes of 2076"

Player chose: "[ACTION] Description"

Metrics BEFORE consequence:
- Mutual Aid: 65/100
- Eco Index: 42/100
- Funds: 850 credits
- Empathy: 70/100
- Tech: 55/100
- Leadership: 48/100
- Rebellion: 62/100

Consequence deltas:
- Mutual Aid: +20
- Eco Index: -15
- Funds: +300

Previous node: "node_024_..."

Generate next story beat that:
1. Reacts to consequences
2. Escalates tension
3. Offers 2-4 strategic choices
4. Maintains cyberpunk tone
```

---

## 💰 API Usage & Costs

### Free Tier (Generous!)
- **50 requests/minute** (per IP)
- **1,500 requests/day**
- Perfect for 1-2 playthroughs of full game

### Typical Usage
- Each story node = 1 API call (~15 tokens input, ~200 tokens output)
- 50 nodes = ~50 API calls
- Full playthrough cost: ~$0.001 USD

### Pricing (as of 2024)
- **Input**: $0.075 per 1M tokens
- **Output**: $0.30 per 1M tokens
- Ultra-cheap for development/testing

### Monitor Usage
```dart
// Add to GameplayScreen
print('API Call #${apiCallCount++}');
print('Tokens used: ${response.usageMetadata?.totalTokenCount}');
```

---

## 🔧 Customizing Story Generation

### Modify System Prompt

Edit `lib/services/gemini_service.dart`:

```dart
static const String _systemPrompt = '''
You are the DARK NARRATOR of "Echoes of 2076"...
[Your custom instructions here]
''';
```

**Examples:**
- More humorous tone: "inject dark humor"
- More serious: "emphasize consequences"
- More educational: "embed learning objectives"
- More violent: "don't shy from combat"

### Adjust Generation Parameters

```dart
generationConfig: GenerationConfig(
  responseMimeType: 'application/json',
  temperature: 0.85,    // ← Lower = more consistent, Higher = more creative
  topK: 40,            // ← Limits vocabulary diversity
  topP: 0.9,           // ← Controls randomness
),
```

**Tuning Guide:**
- **temperature 0.5**: Predictable, safe story
- **temperature 0.85**: Balanced, our default
- **temperature 1.0+**: Wild, unpredictable

---

## 🛡️ Error Handling

### Graceful Fallbacks

If Gemini unavailable, game continues with hardcoded story nodes:

```dart
Future<StoryNode> generateNextNode(...) async {
  try {
    final response = await model.generateContent([...]);
    return StoryNode.fromJson(jsonDecode(response.text));
  } catch (e) {
    // Fallback to database
    return StoryNodeDatabase.getNode('fallback_error') ??
        _createEmergencyNode();
  }
}
```

### Debug Logging

```dart
// In GeminiService
print('📡 Sending to Gemini...');
print('💻 Response: ${response.text}');
print('⚠️ Error: $e');
```

---

## 🚀 Deployment Checklist

- [ ] API key in GitHub Secrets (not in code)
- [ ] Error fallbacks tested
- [ ] Rate limiting handled (50 req/min)
- [ ] JSON parsing validates all required fields
- [ ] Character avatar paths are safe (no user input)
- [ ] Metrics deltas within sane ranges (±100 max)
- [ ] Test on real internet connection (not localhost)
- [ ] Monitor first week of user API calls
- [ ] Set up budget alerts on Google Cloud

---

## 📊 Analytics (Optional)

Track AI quality with player metrics:

```dart
// After story generation
analytics.logEvent(
  name: 'story_node_generated',
  parameters: {
    'node_id': node.id,
    'num_choices': node.choices.length,
    'character': node.characterName,
    'player_metrics': {
      'empathy': currentMetrics.empathyIndex,
      'rebellion': currentMetrics.rebellionIndex,
    },
  },
);
```

---

## 🎓 Testing

### Manual Testing
1. Play through Act I (10 nodes = 10 API calls)
2. Check metrics update correctly
3. Verify story reflects your choices
4. Confirm achievements unlock

### Automated Testing
```dart
// lib/services/gemini_service_test.dart
test('generates valid story node', () async {
  final node = await service.generateNextNode(
    playerChoice: testChoice,
    currentMetrics: testMetrics,
    previousNodeId: 'test_node',
  );
  
  expect(node.id, isNotEmpty);
  expect(node.choices.length, greaterThanOrEqualTo(2));
  expect(node.characterAvatar, isValidPath);
});
```

---

## 🔐 Security Best Practices

- ❌ **Don't**: Commit API key to GitHub
- ✅ **Do**: Use GitHub Secrets for CI/CD
- ❌ **Don't**: Expose key in client-side code
- ✅ **Do**: Use --dart-define for local testing
- ❌ **Don't**: Log full API responses
- ✅ **Do**: Log sanitized version
- ❌ **Don't**: Store user API keys
- ✅ **Do**: Keep server-side only

---

## 🆘 Troubleshooting

### "API Key is invalid"
```
→ Check: API key copied exactly?
→ Check: Key not in quotation marks?
→ Check: Correct project selected in Google AI Studio?
→ Try: Delete key, create new one
```

### "Empty response from Gemini"
```
→ Network issue? Check internet connection
→ Rate limit hit? Wait 60 seconds, retry
→ Model overloaded? Switch to gemini-1.5-flash-8b
→ Check: Response is valid JSON?
```

### "JSON parsing error"
```
→ Wrap response in try-catch
→ Log response.text to see actual output
→ Validate: Does output match expected schema?
→ Fallback: Return hardcoded node
```

### Story nodes seem repetitive
```
→ Increase temperature from 0.85 → 1.0
→ Modify system prompt (make examples more diverse)
→ Check: Are metrics varying enough between choices?
```

---

## 📈 Optimization Tips

### Reduce API Calls
1. **Cache successful generations**: Store node_id + hash
2. **Batch requests**: Generate multiple nodes at once
3. **Pre-generate**: Create Act II/III during loading screen

### Improve Response Quality
1. **Refine prompt**: More specific context → better stories
2. **Include examples**: Show what good output looks like
3. **Constrain output**: "Exactly 3 choices" vs. "2-4"

### Monitor Performance
```dart
final stopwatch = Stopwatch()..start();
final node = await geminiService.generateNextNode(...);
print('⏱️ API latency: ${stopwatch.elapsed.inMilliseconds}ms');
```

---

## 🎬 Advanced: Streaming (Optional Future)

For real-time typewriter effect during generation:

```dart
// Not yet implemented, but possible with Gemini
stream = model.generateContentStream([Content.text(prompt)]);
stream.listen((chunk) {
  setState(() => dialogueText += chunk.text);
});
```

---

## 📚 Resources

- [Google AI Studio](https://aistudio.google.com)
- [Gemini API Docs](https://ai.google.dev/tutorials/rest_quickstart)
- [Flutter Google AI Package](https://pub.dev/packages/google_generative_ai)
- [Prompt Engineering Guide](https://ai.google.dev/tutorials/prompt_engineering)

---

## ✅ You're All Set!

Your game is now powered by Gemini's AI story generation. Each player gets a unique, adaptive narrative experience based on their choices and personality profile.

**Questions?** Check the logs, test with the API Studio, and iterate! 🚀
